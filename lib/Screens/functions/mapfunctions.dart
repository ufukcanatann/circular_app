import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

import '../../Services/post_services.dart';

//kişi konumunu alma
Future<dynamic> getUserLocation() async 
{
  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied)
    {
      // Kullanıcı izni vermedi, işlemi durdurabilirsiniz.
      return;
    }
  }

  if (permission == LocationPermission.deniedForever) {
    // Kullanıcı konum iznini kalıcı olarak reddetti, işlemi durdurabilirsiniz.
    return;
  }

  // Konum bilgisini almak için gerekli izinler verildi, şimdi konumu alabilirsiniz.
  Position position = await Geolocator.getCurrentPosition();
  return position;
}









  
  // ignore: non_constant_identifier_names
  Future<Widget> DrawMap(enlem,boylam) 
  async {
  Set<Marker> markers = Set(); //markers for google map
  LatLng startLocation = LatLng(enlem, boylam);  

     String imgurl = "https://www.fluttercampus.com/img/car.png";
      Uint8List bytes = (await NetworkAssetBundle(Uri.parse(imgurl))
      .load(imgurl))
      .buffer
      .asUint8List();

      markers.add(
        Marker( //add start location marker
          markerId: MarkerId(startLocation.toString()),
          position: startLocation, //position of marker
          infoWindow: const InfoWindow( //popup info 
            title: 'Starting Point ',
            snippet: 'Start Marker',
          ),
          icon:  BitmapDescriptor.fromBytes(bytes), //Icon for Marker
        )
      );


    return 
          
           Container(
             child: GoogleMap( //Map widget from google_maps_flutter package
                    zoomGesturesEnabled: true, //enable Zoom in, out on map
                    initialCameraPosition: CameraPosition( //innital position in map
                      target: startLocation, //initial position
                      zoom: 14.0, //initial zoom level
                    ),
                    markers: markers, //markers to show on map
                    mapType: MapType.normal, //map type
                    onMapCreated: (controller) { //method called when map is created
                    
                    },
                       ),
           );
       
  }






yolculuktalebiolustur(gelenrideid,context) async
{
      var konumalinamadimesaj={"mesaj": "Konum Alınamadı", "code": "200", "status":"0"};
      var deger = await getUserLocation();
      if (deger.runtimeType.toString() == "Position")
      {
       
        http.Response response =
            await PostServices.yolculuktalebigonder(gelenrideid);
        Map responseMap = jsonDecode(response.body);
        return responseMap;
        
      } else
      {
        return konumalinamadimesaj;
      }
}


// yolculuguBitir(carid) async
// {
//       var konumalinamadimesaj={"mesaj": "Konum Alınamadı", "code": "200", "status":"0"};
//       var deger = await getUserLocation();
//       if (deger.runtimeType.toString() == "Position")
//       {
//         var enlem = (deger.latitude);
//         var boylam = (deger.longitude);
//         http.Response response =
//             await PostServices.endajourney(carid,enlem,boylam);
//         Map responseMap = jsonDecode(response.body);
//         return responseMap;
        
//       } else
//       {
//         return konumalinamadimesaj;
//       }
// }