// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';

import '../Classes/Users.dart';
import '../Services/get_services.dart';
import 'functions/globaldata.dart';
import 'functions/widget.dart';

class NotificationPage extends StatefulWidget {
  const NotificationPage({super.key});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  List<dynamic> veriListesi = [];
  int? userid = 0;
  Users? users;
  bool isLoading = true;

  Future<dynamic> getNotificationApiData() async {
    await getUserInfo();
    var response = await GetServices.getNotificationList(userid, 1);
    setState(() {
      var ara = json.decode(response.body);
      veriListesi = ara['data'];
      print(veriListesi);
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
            rolid: value.rolid,
            token: value.token);
        userid = users?.id;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getNotificationApiData().then((_) {});
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingbar();
    } else {
      if (veriListesi.isEmpty) {
        return Center(
          child: Text(
            'Üzgünüz, listelenecek öğe bulunamadı.',
            style: TextStyle(fontSize: 16, color: Colors.black87),
            textAlign: TextAlign.center,
          ),
        );
      } else {
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: veriListesi.length,
                itemBuilder: (context, index) {
                  return Container(
                    color: Colors.white,
                    child: activitycart(
                      veriListesi[index]['title'],
                      veriListesi[index]['desc'],
                      veriListesi[index]['image'],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      }
    }
  }
}
