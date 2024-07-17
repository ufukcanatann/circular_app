import 'package:flutter/material.dart';
import 'package:notification_center/notification_center.dart';

import 'functions/data.dart';
import 'functions/layouts.dart';
import 'functions/widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  var userData;
  @override
  void initState() {
    super.initState();
    getuserdata();
    NotificationCenter().subscribe('updateCounter', (int data) {
      if (data == 1) {
        setState(() {
          _selectedIndex = data;
        });
      }
    });
  }

  getuserdata() async {
    var sonuc = await getUserAllData();
    setState(() {
      userData = sonuc;
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _selectedIndex != 0 && _selectedIndex != 4
          ? buildHeader(context, _selectedIndex)
          : null,
      endDrawer: _selectedIndex != 0 && _selectedIndex != 3 && false
          ? drawer(context, userData)
          : null,
      body: WillPopScope(
          child: buildBody(_selectedIndex),
          onWillPop: () async {
            return false;
          }),
      bottomNavigationBar: buildFooter(_selectedIndex, _onItemTapped, context),
      backgroundColor: Colors.white,
    );
  }
}
