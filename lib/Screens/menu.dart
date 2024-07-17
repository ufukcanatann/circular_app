// ignore_for_file: unnecessary_const

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Services/get_services.dart';
import 'MyCars.dart';
import 'functions/data.dart';
import 'functions/widget.dart';
import 'login_screen.dart';
import 'mydrives.dart';
import 'products.dart';
import 'profile.dart';
import 'test3.dart';

class Menu extends StatefulWidget {
  const Menu({super.key});

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var kulaniciBilgisi;
  int? userid = 0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    kulaniciBilgisigetir();
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
    if (isLoading) {
      return loadingbar();
    }
    return Scaffold(
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Colors.white),
          child: Stack(
            children: [
              Positioned(
                left: 15,
                top: 228,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.92,
                  height: MediaQuery.of(context).size.width * 1.25,
                  clipBehavior: Clip.antiAlias,
                  decoration: ShapeDecoration(
                    color: const Color(0xFFF5F5F5),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 25,
                top: 240,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.87,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyCars()),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.87,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width * 0.025,
                                top: MediaQuery.of(context).size.height * 0.015,
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.09,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.09,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFF0F0F0),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/images/icons/car-solid.svg',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Araçlarım',
                                      style: TextStyle(
                                        color: Color(0xFF1D1D1D),
                                        fontSize: 18,
                                        fontFamily: 'Inria Sans',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MyDrivesPage()),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.87,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width * 0.025,
                                top: MediaQuery.of(context).size.height * 0.015,
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.09,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.09,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFF0F0F0),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/images/icons/journey.svg',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Yolculuklarım',
                                      style: TextStyle(
                                        color: Color(0xFF1D1D1D),
                                        fontSize: 18,
                                        fontFamily: 'Inria Sans',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ProductPage()),
                          );
                          //Araçlar Sayfası
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.87,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width * 0.025,
                                top: MediaQuery.of(context).size.height * 0.015,
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.09,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.09,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFF0F0F0),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/images/icons/vitrin.svg',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Vitrin',
                                      style: TextStyle(
                                        color: Color(0xFF1D1D1D),
                                        fontSize: 18,
                                        fontFamily: 'Inria Sans',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.87,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width * 0.025,
                                top: MediaQuery.of(context).size.height * 0.015,
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.09,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.09,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFF0F0F0),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/images/icons/nasil-kullanirim.svg',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Nasıl Kullanırım?',
                                      style: TextStyle(
                                        color: Color(0xFF1D1D1D),
                                        fontSize: 18,
                                        fontFamily: 'Inria Sans',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.87,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width * 0.025,
                                top: MediaQuery.of(context).size.height * 0.015,
                                child: Row(
                                  children: [
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFF0F0F0),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/images/icons/bize-ulasin3.svg',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Bize Ulaşın',
                                      style: TextStyle(
                                        color: Color(0xFF1D1D1D),
                                        fontSize: 18,
                                        fontFamily: 'Inria Sans',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.87,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width * 0.025,
                                top: MediaQuery.of(context).size.height * 0.015,
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.09,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.09,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFF0F0F0),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/images/icons/about.svg',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Hakkında',
                                      style: TextStyle(
                                        color: Color(0xFF1D1D1D),
                                        fontSize: 18,
                                        fontFamily: 'Inria Sans',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      InkWell(
                        onTap: () async {
                          SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          prefs.clear();
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()),
                          );
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width * 1,
                          height: MediaQuery.of(context).size.height * 0.07,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.87,
                                  height:
                                      MediaQuery.of(context).size.height * 0.07,
                                  decoration: ShapeDecoration(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: MediaQuery.of(context).size.width * 0.025,
                                top: MediaQuery.of(context).size.height * 0.015,
                                child: Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.09,
                                      height:
                                          MediaQuery.of(context).size.width *
                                              0.09,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Color(0xFFF0F0F0),
                                      ),
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/images/icons/exit.svg',
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    const Text(
                                      'Çıkış Yap',
                                      style: TextStyle(
                                        color: Color(0xFF1D1D1D),
                                        fontSize: 18,
                                        fontFamily: 'Inria Sans',
                                        fontWeight: FontWeight.w400,
                                        height: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: 30,
                top: 86,
                child: Container(
                  width: 310,
                  height: 115,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 135,
                        top: 0,
                        child: Container(
                          width: 175,
                          height: 120,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SizedBox(
                                width: 168,
                                child: Text(
                                  kulaniciBilgisi['name'].toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 26,
                                    fontFamily: 'Inria Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 1.0,
                                  ),
                                  // overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 3),
                              SizedBox(
                                width: 168,
                                child: Text(
                                  kulaniciBilgisi['companyname'].toString(),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    color: Color(0xFF333333),
                                    fontSize: 14,
                                    fontFamily: 'Inria Sans',
                                    fontWeight: FontWeight.w400,
                                    height: 1.0,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              const SizedBox(height: 10.0),
                              Container(
                                width: 175,
                                height: 40,
                                child: Stack(
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  // const ProfilPage(),
                                                  const ProfilePageTest()),
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.transparent,
                                        elevation: 0,
                                      ),
                                      child: Container(
                                        width: 175,
                                        height: 35,
                                        child: Center(
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                'Profili Düzenle',
                                                style: TextStyle(
                                                  color:
                                                      const Color(0xFF5283C1),
                                                  fontSize: 15,
                                                  fontFamily: 'Inria Sans',
                                                  fontWeight: FontWeight.w500,
                                                  height: 0,
                                                ),
                                              ),
                                              SizedBox(height: 3),
                                              Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.25,
                                                height: 1,
                                                color: const Color(0xFF5283C1),
                                              ),
                                            ],
                                          ),
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
                      Positioned(
                        left: 0,
                        top: 0,
                        child: Container(
                          width: 115,
                          height: 115,
                          child: Stack(
                            children: [
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 115,
                                  height: 115,
                                  decoration: const ShapeDecoration(
                                    color: Color(0x7F0D1A34),
                                    shape: OvalBorder(),
                                  ),
                                ),
                              ),
                              Positioned(
                                left: 0,
                                top: 0,
                                child: Container(
                                  width: 115,
                                  height: 115,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: const Color(0x77333333),
                                      width: 1.0,
                                    ),
                                  ),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        image: NetworkImage(
                                          getImagePath(
                                              kulaniciBilgisi['companylogo']
                                                  .toString()),
                                        ),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
