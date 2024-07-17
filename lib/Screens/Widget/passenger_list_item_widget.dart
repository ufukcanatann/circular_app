import 'dart:convert';

import 'package:flutter/material.dart';

import '../../Services/post_services.dart';
import '../functions/mapfunctions.dart';
import '../functions/widget copy.dart';
import '../yolculukdetaysurucu.dart';

Widget PassengerListItemWidget(context, item) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
    child: Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              width: 50,
              height: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.blue,
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    item['name'].toString(),
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 14,
                    ),
                  ),
                ),
                if (item['status'].toString() == "0")
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                          height: 30,
                          width: 50,
                          margin: const EdgeInsets.only(right: 5),
                          child: GestureDetector(
                            onTap: () async {
                              var response =
                                  await PostServices.yolcudurumdegistirme(
                                      item['rideid'].toString(), "-1", "0", "0",
                                      userid: item['userid'].toString());

                              var ara = json.decode(response.body);

                              if (ara['status'].toString() == "0") {
                                notification(context, ara['mesaj'].toString());
                              } else {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          YolculukSurcuDetayPage(
                                            rideid: item['rideid'],
                                          )),
                                );
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFF5283C1),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: const Center(
                                child: Text(
                                  "Reddet",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          )),
                      GestureDetector(
                        onTap: () async {
                          var response =
                              await PostServices.yolcudurumdegistirme(
                                  item['rideid'].toString(), "1", "0", "0",
                                  userid: item['userid'].toString());

                          var ara = json.decode(response.body);
                          if (ara['status'].toString() == "0") {
                            notification(context, ara['mesaj'].toString());
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => YolculukSurcuDetayPage(
                                        rideid: item['rideid'],
                                      )),
                            );
                          }
                        },
                        child: Container(
                          height: 30,
                          width: 60,
                          margin: const EdgeInsets.only(left: 5, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color(0xff333F48),
                              borderRadius: BorderRadius.circular(3),
                            ),
                            child: const Center(
                              child: Text(
                                "Kabul Et",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                if (item['status'].toString() == "-1")
                  Container(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: const Text("Reddedildi")),
                if (item['status'].toString() == "1")
                  Container(
                    height: 30,
                    width: 80,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: const Color(0xff333F48),
                          borderRadius: BorderRadius.circular(3),
                        ),
                        child: Center(
                          child: GestureDetector(
                            onTap: () async {
                              double enlem = 0;
                              double boylam = 0;
                              var deger = await getUserLocation();
                              if (deger.runtimeType.toString() == "Position") {
                                enlem = (deger.latitude);
                                boylam = (deger.longitude);

                                var response =
                                    await PostServices.yolcudurumdegistirme(
                                        item['rideid'].toString(),
                                        "2",
                                        enlem.toString(),
                                        boylam.toString(),
                                        userid: item['userid'].toString());

                                var ara = json.decode(response.body);
                                if (ara['status'].toString() == "0") {
                                  notification(
                                      context, ara['mesaj'].toString());
                                } else {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            YolculukSurcuDetayPage(
                                              rideid: item['rideid'],
                                            )),
                                  );
                                }
                              }
                            },
                            child: RichText(
                              text: const TextSpan(
                                text: "Başlat",
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (item['status'].toString() == "2")
                  Container(
                    height: 30,
                    width: 80,
                    child: GestureDetector(
                      onTap: () async {
                        double enlem = 0;
                        double boylam = 0;
                        var deger = await getUserLocation();
                        if (deger.runtimeType.toString() == "Position") {
                          enlem = (deger.latitude);
                          boylam = (deger.longitude);

                          var response =
                              await PostServices.yolcudurumdegistirme(
                                  item['rideid'].toString(),
                                  "3",
                                  enlem.toString(),
                                  boylam.toString(),
                                  userid: item['userid'].toString());

                          var ara = json.decode(response.body);
                          if (ara['status'].toString() == "0") {
                            notification(context, ara['mesaj'].toString());
                          } else {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => YolculukSurcuDetayPage(
                                        rideid: item['rideid'],
                                      )),
                            );
                          }
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF5283C1),
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: const Center(
                            child: Text(
                              "Bitir",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (item['status'].toString() == "3")
                  Container(
                      child: const Padding(
                    padding: EdgeInsets.only(right: 10.0),
                    child: Text("Tamamlandı"),
                  ))
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
