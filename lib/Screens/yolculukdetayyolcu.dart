import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:circularmindapp/Screens/functions/widget.dart';
import 'package:intl/intl.dart';

import '../Services/get_services.dart';
import '../Services/post_services.dart';
import 'mydrives.dart';

class YolculukYolcuDetayPage extends StatefulWidget {
  int rideid;

  YolculukYolcuDetayPage({super.key, required this.rideid});

  @override
  State<YolculukYolcuDetayPage> createState() =>
      _YolculukYolcuDetayPageState(rideid: rideid);
}

class _YolculukYolcuDetayPageState extends State<YolculukYolcuDetayPage> {
  int rideid;
  _YolculukYolcuDetayPageState({required this.rideid});

  TextEditingController _textFieldController = TextEditingController();
  String comment = '';

  late Map<String, dynamic> aracBilgisi;
  late Map<String, dynamic> yolculukBilgisi;
  late Map<String, dynamic> usersList;
  late Map<String, dynamic> veriHaritasi;
  var girisyapankullaniciid;
  double Userrating = 0;
  bool isLoading = true;

  Future<dynamic> yolcuclukBilgilerinigetir() async {
    var response =
        await GetServices.yolculukBilgileriniGetir(widget.rideid.toString());

    setState(() {
      veriHaritasi = json.decode(response.body);
      aracBilgisi = veriHaritasi["carInfo"];
      yolculukBilgisi = veriHaritasi["rideInfo"];
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    yolcuclukBilgilerinigetir();
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return loadingbar();
    } else {
      return Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyDrivesPage()),
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
                size: 30,
              ),
            ),
          ),
          title: const Padding(
            padding: EdgeInsets.only(bottom: 10),
            child: Text(
              "Yolculuk Detayları",
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          backgroundColor: const Color(0xFF5283C1),
          toolbarHeight: 80,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            child: GestureDetector(
              onTap: () {
                if (FocusScope.of(context).hasFocus) {
                  FocusScope.of(context).unfocus();
                }
              },
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Center(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: Color(0xffF5F5F5),
                          borderRadius:
                              BorderRadius.all(Radius.circular(15.0))),
                      width: MediaQuery.of(context).size.width - 30,
                      height: 450,
                      child: Column(
                        children: [
                          Column(
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: const Text(
                                        "Plaka",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                    Container(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: const Text(
                                        "Güzergah",
                                        style: TextStyle(
                                            color: Color(0xFF5283c1),
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ]),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: Text(
                                      aracBilgisi['plaka'].toString(),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      yolculukBilgisi['nereye'].toString() +
                                          " - " +
                                          yolculukBilgisi['nereden'].toString(),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(10),
                                child: const Divider(
                                  height: 5,
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: const Text("Başlangıç Saati",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      "${DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(veriHaritasi["users"][0]['baslamasaati']))}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: const Text("Bitiş Saati",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      "${DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(veriHaritasi["users"][0]['bitissaati']))}",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: const Text("Süre",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      veriHaritasi["users"][0]['sure_dakika']
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.only(left: 10),
                                    child: const Text("Puan",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: Text(
                                      veriHaritasi["users"][0]['point']
                                              .toString() +
                                          "/" +
                                          "5",
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(20),
                                child: const Divider(
                                  height: 5,
                                  color: Colors.grey,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: const Text("Puan",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400))),
                                  Container(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: RatingBar.builder(
                                      initialRating: Userrating,
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      itemBuilder: (context, _) => const Icon(
                                        Icons.star,
                                        color: Colors.amber,
                                      ),
                                      onRatingUpdate: (rating) {
                                        setState(() {
                                          Userrating = rating;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10.0, left: 10.0),
                                  child: TextField(
                                    keyboardType: TextInputType.multiline,
                                    maxLines: 4,
                                    decoration: const InputDecoration(
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                      ),
                                      labelStyle: TextStyle(
                                        color: Colors.red,
                                      ),
                                      hintText:
                                          "Yolculuk hakkında görüşlerinizi yazınız",
                                      hintStyle: TextStyle(
                                          fontSize: 14, color: Colors.black45),
                                    ),
                                    style: TextStyle(color: Colors.black),
                                    onChanged: (value) {
                                      setState(() {
                                        comment = value;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Center(
                                //Kaydet Butonu
                                child: ElevatedButton(
                                  onPressed: () async {
                                    var ayid = veriHaritasi["users"][0]['id']
                                        .toString();

                                    var response =
                                        await PostServices.surucuyeyildizver(
                                            ayid, comment, Userrating);
                                    var ara = json.decode(response.body);
                                    notification(context, ara['mesaj']);

                                    if (ara['status'].toString() == "1") {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MyDrivesPage()),
                                      );
                                    }
                                  },
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Color(0xFF5283C1)),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                      "Kaydet",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
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
}
