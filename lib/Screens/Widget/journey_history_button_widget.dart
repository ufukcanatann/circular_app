// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers

import 'dart:convert';

import 'package:flutter/material.dart';

import '../../Services/post_services.dart';
import '../functions/mapfunctions.dart';
import '../functions/widget copy.dart';
import '../mydrives.dart';
import '../yolculukdetaysurucu.dart';

@override
journeyButtonWidget(context, item, loginid) {
  // String formattedDate = item['yolcularbaslamasaati'];
  // var split_string = formattedDate.split(' ');
  // formattedDate = split_string[0];
  // String formattedtime = split_string[1];

  String formattedDate = item['yolcularbaslamasaati'];
  String formattedTime = item['yolcularbaslamasaati'];
  var splitDateTime = formattedDate.split(' ');
  var splitDate = splitDateTime[0].split('-');
  var splitTime = splitDateTime[1].split(':');
  formattedDate = '${splitDate[2]}.${splitDate[1]}.${splitDate[0]}';
  formattedTime = '${splitTime[0]}:${splitTime[1]}';

  double screenWidth = MediaQuery.of(context).size.width;
  var type = 0;
  var isSurucu = 0;

  if (item['aystatus'] == 0) {
    type = -1;
  }
  if (item['aystatus'] == 1) {
    type = 2;
  }
  if (item['aystatus'] == 2) {
    type = 3;
  }

  if (item['driverid'].toString() == loginid.toString() &&
      item['rstatus'].toString() == "1") {
    type = 0;
  }

  if (item['driverid'].toString() == loginid.toString()) {
    isSurucu = 1;
  }

  return Container(
    height: 150,
    child: Padding(
      padding: const EdgeInsets.only(top: 10, bottom: 10),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(20)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              formattedDate,
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              formattedTime,
                              style:
                                  TextStyle(fontSize: 16, color: Colors.grey),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth * 0.035),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: const Text(
                              "Güzergah",
                              style: TextStyle(fontSize: 18),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Container(
                            alignment: Alignment.center,
                            child: Text(
                              item['nereye'] + " - " + item['nereden'],
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF5283c1),
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(
              color: Color.fromARGB(32, 0, 0, 34),
            ),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10.0),
                      child: Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            isSurucu == 0 && item['aystatus'] != 0
                                ? Container()
                                : Container(
                                    child: Container(
                                      //-1=> kırmızı 0=>siyah 1=>yeşil
                                      height: screenWidth * 0.08,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.horizontal(
                                          left: Radius.circular(
                                              screenWidth * 0.02),
                                          right: Radius.circular(
                                              screenWidth * 0.02),
                                        ),
                                        gradient: buttonColor(item, loginid),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          GestureDetector(
                                            onTap: () async {
                                              double enlem = 0;
                                              double boylam = 0;
                                              if (type == 3 || type == 2) {
                                                var deger =
                                                    await getUserLocation();
                                                if (deger.runtimeType
                                                        .toString() ==
                                                    "Position") {
                                                  enlem = (deger.latitude);
                                                  boylam = (deger.longitude);

                                                  var response =
                                                      await PostServices
                                                          .yolcudurumdegistirme(
                                                              item['id'],
                                                              type.toString(),
                                                              enlem.toString(),
                                                              boylam
                                                                  .toString());
                                                  var ara = json
                                                      .decode(response.body);
                                                  if (ara['status']
                                                          .toString() ==
                                                      "0") {
                                                    notification(
                                                        context,
                                                        ara['mesaj']
                                                            .toString());
                                                  } else {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              const MyDrivesPage()),
                                                    );
                                                  }
                                                } else {
                                                  notification(context,
                                                      "Konum Alınamadı");
                                                }
                                              } else {
                                                var response =
                                                    await PostServices
                                                        .yolcudurumdegistirme(
                                                            item['id'],
                                                            type.toString(),
                                                            enlem.toString(),
                                                            boylam.toString());

                                                var ara =
                                                    json.decode(response.body);
                                                if (ara['status'].toString() ==
                                                    "0") {
                                                  notification(context,
                                                      ara['mesaj'].toString());
                                                } else {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const MyDrivesPage()),
                                                  );
                                                }
                                              }
                                            },
                                            child: Container(
                                              child: Center(
                                                child: Text(
                                                  buttonText(item, loginid),
                                                  style: const TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.035,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Container(
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    if (item['driverid'].toString() ==
                                        loginid.toString()) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                YolculukSurcuDetayPage(
                                                    rideid: item['id'])),
                                      );
                                    }
                                  },
                                  child: const Text(
                                    "Detay",
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xFF000000),
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_right,
                                  size: 16,
                                  color: Colors.black,
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
          ],
        ),
      ),
    ),
  );
}

buttonColor(item, loginid) {
  if (loginid.toString() == item['driverid'].toString() &&
      item['rstatus'].toString() == "1") {
    return const LinearGradient(
      colors: [Color(0xFF5283C1), Color(0xFF5283C1)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }

  if (item['aystatus'] == 0 || item['aystatus'] == 2) {
    return const LinearGradient(
      colors: [Color(0xFF5283C1), Color(0xFF5283C1)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
  if (item['aystatus'] == 1) {
    return const LinearGradient(
      colors: [Color(0xff1d1d1b), Color(0xff333f48)],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
}

buttonText(item, loginid) {
  if (loginid.toString() == item['driverid'].toString() &&
      item['rstatus'].toString() == "1") {
    return "İptal et";
  } else if (item['aystatus'] == 0) {
    return "Talebi İptal Et";
  } else if (item['aystatus'] == 1) {
    return "Yolculuğu Başlat";
  } else if (item['aystatus'] == 2) {
    return "Yolculuğu Bitir";
  }
}
