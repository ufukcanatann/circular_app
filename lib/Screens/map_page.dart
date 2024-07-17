import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../Services/get_services.dart';
import 'functions/data.dart';
import 'functions/layouts.dart';
import 'functions/mapfunctions.dart';
import 'functions/widget.dart';

GoogleMapController? mapController;

class MapScreen extends StatefulWidget {
  final double enlem;
  final double boylam;
  final String rideid;
  MapScreen({required this.enlem, required this.boylam, required this.rideid});

  @override
  _MapScreenState createState() => _MapScreenState(
      gonderilenenlem: enlem, gonderilenboylam: boylam, gelenrideid: rideid);
}

class _MapScreenState extends State<MapScreen> {
  final double gonderilenenlem;
  final double gonderilenboylam;
  final String gelenrideid;
  _MapScreenState(
      {required this.gonderilenenlem,
      required this.gonderilenboylam,
      required this.gelenrideid});
  var userData;

  List<dynamic> araclistesi = [];
  Set<Marker> markers = {};
  bool isLoading = true;
  LatLng startLocation = LatLng(41.070870, 29.015756);
  LatLng myLocation = LatLng(40.993032, 28.850432);
  var userEnlem = 0.0;
  var userboylam = 0.0;

  @override
  void initState() {
    super.initState();
    getuserdata();
    performAsyncInitialization().then((value) =>
        getCarListApiData().then((value) => addMarkers(araclistesi)));

    Timer.periodic(Duration(seconds: 10), (timer) {
      updateMyLocation();
    });
  }

  getuserdata() async {
    var sonuc = await getUserAllData();
    setState(() {
      userData = sonuc;
    });
  }

  Future<void> performAsyncInitialization() async {
    Position location = await getUserLocation();
    setState(() {
      myLocation = LatLng(location.latitude, location.longitude);
      userEnlem = location.latitude;
      userboylam = location.longitude;
    });
  }

  Future<dynamic> getCarListApiData() async {
    var response = await GetServices.butunSurucListesi();
    setState(() {
      var ara = json.decode(response.body);
      araclistesi = ara['data'];
      isLoading = false;
      startLocation = LatLng(gonderilenenlem, gonderilenboylam);
    });
  }

  Future<BitmapDescriptor> createMarkerIcon(double scale) async {
    final ImageConfiguration imageConfiguration = createLocalImageConfiguration(
      context,
      size: Size(24 * scale, 24 * scale),
    );
    return await BitmapDescriptor.fromAssetImage(
      imageConfiguration,
      'assets/images/pin_64.png',
    );
  }

  void addMarkers(List<dynamic> araclistesi) async {
    LatLng carLocation;

    for (var element in araclistesi) {
      var enlem = element['enlembas'];
      var boylam = element['boylambas'];

      carLocation = LatLng(double.parse(enlem), double.parse(boylam));

      final markerIcon = await createMarkerIcon(1.0); // default scale

      markers.add(Marker(
        markerId: MarkerId(carLocation.toString()),
        position: carLocation,
        icon: markerIcon,
        onTap: () {
          carModalDetail(element, context, gelenrideid, userEnlem, userboylam);
        },
      ));
    }

    setState(() {});
  }

  void updateMyLocation() async {
    Position location = await getUserLocation();
    setState(() {
      myLocation = LatLng(location.latitude, location.longitude);
      userEnlem = location.latitude;
      userboylam = location.longitude;

      markers.removeWhere((marker) => marker.markerId.value == "userLocation");

      markers.add(Marker(
        markerId: MarkerId("userLocation"),
        position: myLocation,
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
      ));
    });
  }

  void onCameraMove(CameraPosition position) async {
    final zoom = position.zoom;
    final scale = zoom < 10 ? 0.5 : zoom / 10;

    markers.clear();
    for (var element in araclistesi) {
      var enlem = element['enlembas'];
      var boylam = element['boylambas'];

      final carLocation = LatLng(double.parse(enlem), double.parse(boylam));
      final markerIcon = await createMarkerIcon(scale);

      markers.add(Marker(
        markerId: MarkerId(carLocation.toString()),
        position: carLocation,
        icon: markerIcon,
        onTap: () {
          carModalDetail(element, context, gelenrideid, userEnlem, userboylam);
        },
      ));
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingbar();
    } else {
      return Scaffold(
        appBar: buildHeader(context, 6),
        body: GoogleMap(
          zoomGesturesEnabled: true,
          initialCameraPosition: CameraPosition(
            target: startLocation,
            zoom: 15.0,
          ),
          markers: markers,
          mapType: MapType.normal,
          onMapCreated: (controller) {
            mapController = controller;
            setState(() {});
          },
          onCameraMove: onCameraMove,
        ),
      );
    }
  }
}
