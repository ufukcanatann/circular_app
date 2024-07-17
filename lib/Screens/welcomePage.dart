// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:notification_center/notification_center.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/get_services.dart';
import '../Services/post_services.dart';
import 'MyCars.dart';
import 'functions/data.dart';
import 'functions/widget.dart';
import 'login_screen.dart';
import 'mydrives.dart';
import 'products.dart';

class ButtonInfo {
  final String svgPath;
  final Function onTap;
  final String name;

  ButtonInfo({required this.svgPath, required this.onTap, required this.name});
}

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var yolculuklar = [];
  var kulaniciBilgisi;
  int? userid = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    kulaniciBilgisigetir();
    yolculuklistesinigetir("", "", "");
  }

  Future<dynamic> yolculuklistesinigetir(neredenS, nereyeS, tarihs) async {
    if (neredenS == 'Tümü') {
      neredenS = "";
    }
    if (nereyeS == 'Tümü') {
      nereyeS = "";
    }
    var response = await PostServices.aracFiltrele(neredenS, nereyeS, tarihs);

    var ara = json.decode(response.body);
    setState(() {
      yolculuklar = ara['data'];
      isLoading = false;
    });
    return ara['data'];
  }

  Future<dynamic> kulaniciBilgisigetir() async {
    var response = await GetServices.getUserInfo();
    setState(() {
      var ara = json.decode(response.body);

      kulaniciBilgisi = ara['data'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;
    var screenHeight = MediaQuery.of(context).size.height;
    var isTablet = screenWidth > 600;

    if (isLoading) {
      return loadingbar();
    }
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          return true;
        },
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
          child: Column(
            children: [
              SizedBox(height: screenHeight * 0.15),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Merhaba,',
                          style: TextStyle(
                            fontSize: isTablet
                                ? screenWidth * 0.03
                                : screenWidth * 0.05,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          '${kulaniciBilgisi['name']} 👋',
                          style: TextStyle(
                            fontSize: isTablet
                                ? screenWidth * 0.03
                                : screenWidth * 0.05,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  Column(
                    children: [
                      Container(
                        width: screenWidth * 0.3,
                        height: screenHeight * 0.12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(
                              getImagePath(
                                  kulaniciBilgisi['avatar'].toString()),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  barbutton(context, 0, isTablet),
                  barbutton(context, 1, isTablet),
                  barbutton(context, 2, isTablet),
                  barbutton(context, 3, isTablet),
                ],
              ),
              SizedBox(height: screenHeight * 0.05),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text(
                      'Günün yolculuklarından bazıları',
                      style: TextStyle(
                        fontSize: isTablet
                            ? screenWidth * 0.025
                            : screenWidth * 0.045,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      NotificationCenter().notify('updateCounter', data: 1);
                    },
                    child: Text(
                      'Tümünü Gör',
                      style: TextStyle(
                        fontSize:
                            isTablet ? screenWidth * 0.02 : screenWidth * 0.035,
                        color: Color(0xFF5283C1),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10.0),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                physics: PageScrollPhysics(),
                child: Row(
                  children: [
                    for (int i = 0; i < yolculuklar.length; i++)
                      Container(
                        width: screenWidth * 0.9,
                        margin: EdgeInsets.only(right: 5.0),
                        child: Container(
                          width: screenWidth * 0.875,
                          decoration: BoxDecoration(
                            color: const Color(0xFF5283C1),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              rota(context, yolculuklar[i], isTablet),
                              const SizedBox(height: 5.0),
                              detay(context, yolculuklar[i], isTablet),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget rota(
    BuildContext context, Map<String, dynamic> yolculuk, bool isTablet) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 5.0),
    child: Text(
      "${yolculuk['nereden']} - ${yolculuk['nereye']}",
      style: TextStyle(
        fontSize: isTablet
            ? MediaQuery.of(context).size.width * 0.025
            : MediaQuery.of(context).size.width * 0.045,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}

detay(context, yolculuk, bool isTablet) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            getImagePath(yolculuk['image'].toString()),
            width: isTablet
                ? MediaQuery.of(context).size.width * 0.25
                : MediaQuery.of(context).size.width * 0.35,
          ),
          const SizedBox(height: 5.0),
          Text(
            "${yolculuk['marka']} ${yolculuk['model']}",
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            yolculuk['plaka'].toString(),
            style: const TextStyle(
              fontSize: 12.0,
              fontWeight: FontWeight.w400,
              color: Colors.white,
            ),
          ),
        ],
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.25),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(minWidth: 70),
                      child: Text(
                        'Tarih',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      yolculuk['yolcularbaslamasaati']
                          .split(' ')[0]
                          .split('-')
                          .reversed
                          .join('.'),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(minWidth: 70),
                      child: Text(
                        'Puan',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      yolculuk['point'].toString(),
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      constraints: BoxConstraints(minWidth: 70),
                      child: Text(
                        'Kapasite',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Text(
                      '${yolculuk['yolcusayisi']}/${yolculuk['kapasite']} Kişi',
                      textAlign: TextAlign.start,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 10.0),
          ElevatedButton(
            onPressed: () async {
              var response =
                  await PostServices.yolculuktalebigonder(yolculuk['id']);
              var ara = json.decode(response.body);
              if (ara['status'] == 0) {
                notification(context, ara['mesaj'].toString());
              } else {
                notification(context, ara['mesaj'].toString());
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const MyDrivesPage()),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,
              minimumSize: Size(
                MediaQuery.of(context).size.width * 0.15,
                MediaQuery.of(context).size.height * 0.04,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Yolculuk Talep Et',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: isTablet
                        ? MediaQuery.of(context).size.width * 0.02
                        : MediaQuery.of(context).size.width * 0.032,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(width: 5),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white,
                  size: isTablet ? 16 : 18,
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  );
}

barbutton(context, i, bool isTablet) {
  var pageHeight = MediaQuery.of(context).size.height;
  var pageWidth = MediaQuery.of(context).size.width;

  List<ButtonInfo> buttonList = [
    ButtonInfo(
      svgPath: 'assets/images/icons/car-solid.svg',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyCars(),
          ),
        );
      },
      name: 'Araçlarım',
    ),
    ButtonInfo(
      svgPath: 'assets/images/icons/journey.svg',
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const MyDrivesPage(),
          ),
        );
      },
      name: 'Yolculuklarım',
    ),
    ButtonInfo(
      svgPath: 'assets/images/icons/vitrin.svg',
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => ProductPage(),
          ),
        );
      },
      name: 'Vitrin',
    ),
    ButtonInfo(
      svgPath: 'assets/images/icons/exit.svg',
      onTap: () async {
        SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.clear();
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      },
      name: 'Çıkış Yap',
    ),
  ];

  return Expanded(
    child: Row(
      children: [
        Column(
          children: [
            InkWell(
              onTap: () {
                buttonList[i].onTap();
              },
              child: Container(
                height: pageHeight * 0.06,
                width: pageWidth * 0.2,
                decoration: const BoxDecoration(
                  color: Color(0xFFF5F5F5),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: SvgPicture.asset(
                    buttonList[i].svgPath,
                    color: const Color(0xFF5283C1),
                    height: pageHeight * 0.025,
                    width: pageWidth * 0.1,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 5.0),
            Text(
              buttonList[i].name,
              style: TextStyle(
                fontSize: isTablet ? 14 : 14,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ],
        ),
        const SizedBox(width: 5.0),
      ],
    ),
  );
}
