// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';

import '../Classes/Users.dart';
import '../Services/get_services.dart';
import 'functions/globaldata.dart';
import 'functions/widget.dart';

class Activty extends StatefulWidget {
  const Activty({super.key});

  @override
  State<Activty> createState() => _ActivtyState();
}

class _ActivtyState extends State<Activty> {
  List<dynamic> veriListesi = [];
  int? userid = 0;
  Users? users;
  bool isLoading = true;

  Future<dynamic> getActivityApiData() async {
    await getUserInfo();
    var response = await GetServices.getNotificationList(userid, 0);
    setState(() {
      var ara = json.decode(response.body);
      veriListesi = ara['data'];
      isLoading = false;
    });
  }

  getUserInfo() {
    getSessionData().then((value) {
      setState(() {
        users = Users(
            id: value.id,
            name: value.name,
            email: value.email,
            logo: value.logo,
            companyname: value.companyname,
            token: value.token,
            rolid: value.rolid);
        userid = users?.id;
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getActivityApiData();
  }

  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingbar();
    } else {
      return ListView.builder(
          itemCount: veriListesi.length,
          itemBuilder: (context, index) {
            return activitycart(
              veriListesi[index]['title'],
              veriListesi[index]['desc'],
              veriListesi[index]['image'],
            );
          });
    }
  }
}
