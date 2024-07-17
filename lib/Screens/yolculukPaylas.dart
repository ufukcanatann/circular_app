// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Services/post_services.dart';
import 'HomePage.dart';
import 'function2/dropdown_widget.dart';
import 'function2/textwidget.dart';
import 'function2/time_container.dart';
import 'functions/mapfunctions.dart';
import 'functions/widget.dart';
import 'mydrives.dart';

class YolculukPaylas extends StatelessWidget {
  int carid;
  YolculukPaylas({required this.carid});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      //theme: ThemeData(fontFamily: 'Roboto'),
      home: MyHomePage(carid: carid),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final int carid;
  MyHomePage({required this.carid});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _controller = TextEditingController();
  TextEditingController adrestarifi = TextEditingController();
  TextEditingController rota = TextEditingController();

  String selectedDate = "";
  String kapasite = "";
  bool isButtonEnabled = true;
  bool isLoading = false;
  var semtList = [];

  String searcToWhere = '';
  String searcFromWhere = '';

  void initState() {
    super.initState();
    // getStateList();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingbar();
    }
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const HomePage()),
            );
          },
          child: Padding(
            padding: EdgeInsets.only(left: 10.0),
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: 30,
            ),
          ),
        ),
        title: const Text(
          "Yolculuk Bilgileri",
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: const Color(0xFF5283C1),
        toolbarHeight: 80,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.05),
                  child: Center(
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: Color(0xffF5F5F5),
                          borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        ),
                        child: Column(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                DropdownWidget(
                                  title: "Nereden?",
                                  hintext: "İlçe seçiniz",
                                  onItemSelected: (selectedValue) {
                                    setState(() {
                                      searcToWhere = selectedValue;
                                    });
                                  },
                                ),
                                SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.02),
                                DropdownWidget(
                                  title: "Nereden?",
                                  hintext: "İlçe seçiniz",
                                  onItemSelected: (selectedValue) {
                                    setState(() {
                                      searcFromWhere = selectedValue;
                                    });
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    Container(
                                      width: 160,
                                      child: DropdownWidgetTime(
                                        title: "Tarih & Saat",
                                        hintext: "Tarih Seçiniz",
                                        selectdate: (selectedValue) {
                                          setState(() {
                                            selectedDate = selectedValue;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Column(
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: 160,
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Capality(
                                            hintext: "Sayı Girin",
                                            title: "Kapasite",
                                            kapasite: (selectedValue) {
                                              setState(() {
                                                kapasite = selectedValue;
                                              });
                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                              child: TextField(
                                controller: rota,
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText:
                                      "Yolculuk boyunca gideceğiniz rotayı yazınız",
                                  hintStyle: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF999999),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(10.0),
                                  )),
                              child: TextField(
                                controller: adrestarifi,
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none,
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  hintText:
                                      "Aracın bulunduğu açık adresi yazınız",
                                  hintStyle: TextStyle(
                                    fontSize: 14.0,
                                    color: Color(0xFF999999),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              onPressed: isButtonEnabled
                                  ? () async {
                                      setState(() {
                                        isButtonEnabled = false;
                                      });

                                      if (selectedDate != "" &&
                                          searcFromWhere != "" &&
                                          searcToWhere != "" &&
                                          kapasite != "" &&
                                          adrestarifi.text.isNotEmpty &&
                                          rota.text.isNotEmpty) {
                                        var deger = await getUserLocation();
                                        if (deger.runtimeType.toString() ==
                                            "Position") {
                                          var enlem = (deger.latitude);
                                          var boylam = (deger.longitude);
                                          http.Response response =
                                              await PostServices
                                                  .yolculukpaylaspost(
                                                      widget.carid,
                                                      enlem,
                                                      boylam,
                                                      adrestarifi.text,
                                                      searcFromWhere,
                                                      searcToWhere,
                                                      rota.text,
                                                      kapasite,
                                                      selectedDate);

                                          Map responseMap =
                                              jsonDecode(response.body);
                                          if (responseMap['status']
                                                  .toString() ==
                                              "1") {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    const MyDrivesPage(),
                                              ),
                                            );
                                          } else {
                                            notification(
                                                context, responseMap['mesaj']);
                                          }
                                        } else {
                                          notification(
                                              context, "Konum Alınamadı!");
                                        }
                                      } else {
                                        notification(context,
                                            "Lütfen tüm alanları doldurun!");
                                      }

                                      setState(() {
                                        isButtonEnabled = true;
                                      });
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xFF5283C1),
                              ),
                              child: Center(
                                child: const Text(
                                  "Kaydet",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ],
                        )),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
