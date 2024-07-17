// ignore_for_file: prefer_const_constructors

import 'dart:ffi';

import 'package:circularmindapp/Screens/test3.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../HomePage.dart';
import '../mydrives.dart';
import '../products.dart';
import '../suruslistesi.dart';
import '../test.dart';
import '../test2.dart';
import '../test3.dart';
import '../testMenu.dart';
import '../welcomePage.dart';

import '../../Services/globals.dart';
import '../Activity.dart';
import '../NotificationPage.dart';
import '../menu.dart';
import '../profile.dart';

AppBar buildHeader(BuildContext context, selectedIndex) {
  var yazi = "";
  if (selectedIndex == 1) {
    yazi = "Yolculuk Listesi";
  } else if (selectedIndex == 2) {
    yazi = "Etkinlikler";
  } else if (selectedIndex == 3) {
    yazi = "Duyurular";
  } else if (selectedIndex == 6) {
    yazi = "Araç Seçin";
  } else if (selectedIndex == 8) {
    yazi = "Ürünler";
  }
  return AppBar(
    iconTheme: const IconThemeData(color: Color(0xFFF5F5F5)),
    title: Text(
      yazi.toString(),
      style: TextStyle(
        color: Colors.white,
      ),
      textAlign: TextAlign.center,
    ),
    backgroundColor: Color(0xFF5283C1),
    leading: selectedIndex == 8
        ? IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
              );
            },
          )
        : null,
  );
}

buildFooter(_selectedIndex, _onItemTapped, context) {
  // if (_selectedIndex > 4) {
  //   _selectedIndex = 3;
  // }

  double iconSize = MediaQuery.of(context).size.width * 0.07;
  return BottomNavigationBar(
    items: <BottomNavigationBarItem>[
      BottomNavigationBarItem(
        icon: Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: SvgPicture.asset(
            'assets/images/icons/house-solid.svg',
            width: iconSize,
            height: iconSize,
            color: _selectedIndex == 0 ? const Color(0xFF5283C1) : ikonColor(),
          ),
        ),
        label: 'Anasayfa',
        backgroundColor: themaColor(),
      ),
      BottomNavigationBarItem(
        icon: Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: SvgPicture.asset(
            'assets/images/icons/journey.svg',
            width: iconSize,
            height: iconSize,
            color: _selectedIndex == 1 ? const Color(0xFF5283C1) : ikonColor(),
          ),
        ),
        label: 'Yolculuklar',
        backgroundColor: themaColor(),
      ),
      BottomNavigationBarItem(
        icon: Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: SvgPicture.asset(
            'assets/images/icons/etkinlik.svg',
            width: iconSize,
            height: iconSize,
            color: _selectedIndex == 2 ? const Color(0xFF5283C1) : ikonColor(),
          ),
        ),
        label: 'Etkinlik',
        backgroundColor: themaColor(),
      ),
      BottomNavigationBarItem(
        icon: Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: SvgPicture.asset(
            'assets/images/icons/duyuru.svg',
            width: iconSize,
            height: iconSize,
            color: _selectedIndex == 3 ? const Color(0xFF5283C1) : ikonColor(),
          ),
        ),
        label: 'Duyuru',
        backgroundColor: themaColor(),
      ),
      BottomNavigationBarItem(
        icon: Container(
          padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
          child: SvgPicture.asset(
            'assets/images/icons/bars-solid.svg',
            width: iconSize,
            height: iconSize,
            color: _selectedIndex == 4 ? const Color(0xFF5283C1) : ikonColor(),
          ),
        ),
        label: 'Menü',
        backgroundColor: themaColor(),
      ),
    ],
    currentIndex: _selectedIndex,
    selectedItemColor: const Color(0xFF5283C1),
    unselectedItemColor: const Color(0xFF333333),
    showUnselectedLabels: true,
    selectedLabelStyle: const TextStyle(fontWeight: FontWeight.normal),
    onTap: _onItemTapped,
  );
}

Widget buildBody(int selectedIndex) {
  final List<Widget> _widgetOptions = <Widget>[
    Container(
      color: Colors.white,
      child: WelcomePage(),
    ),
    SurusListesi(),
    const Activty(),
    const NotificationPage(),
    //Menu(),
    MenuPage(),
    ProfilPage(),
    const MyDrivesPage(),
    ProductPage(),
  ];

  return Center(
    child: Container(
      color: Colors.white,
      child: _widgetOptions.elementAt(selectedIndex),
    ),
  );
}
