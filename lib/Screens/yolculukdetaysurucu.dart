// ignore_for_file: avoid_unnecessary_containers

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../Services/get_services.dart';
import '../Services/post_services.dart';
import 'Widget/passenger_list_item_widget.dart';
import 'functions/widget.dart';
import 'mydrives.dart';

class YolculukSurcuDetayPage extends StatefulWidget {
  int rideid;
  YolculukSurcuDetayPage({super.key, required this.rideid});
  @override
  State<YolculukSurcuDetayPage> createState() =>
      _YolculukDetayPageState(rideid: rideid);
}

class _YolculukDetayPageState extends State<YolculukSurcuDetayPage> {
  int rideid;
  _YolculukDetayPageState({required this.rideid});

  late Map<String, dynamic> aracBilgisi;
  late Map<String, dynamic> yolculukBilgisi;
  late Map<String, dynamic> usersList;
  late Map<String, dynamic> veriHaritasi;

  int girisyapankullaniciid = 0;
  double Userrating = 0;
  bool isLoading = true;

  Future<dynamic> yolcuclukBilgilerinigetir() async {
    var response =
        await GetServices.yolculukBilgileriniGetir(widget.rideid.toString());

    setState(() {
      veriHaritasi = json.decode(response.body);

      //aracBilgisi = veriHaritasi["carInfo"];
      //yolculukBilgisi = veriHaritasi["rideInfo"];
      //usersList = veriHaritasi["users"];

      //  yolculukBilgisi = ara['rideInfo'];

      //  usersList = ara['users'];
      // girisyapankullaniciid = ara['userid'].toString();
      isLoading = false;
    });
  }

  int selectedRating = 0;
  Map<int, int> caridRatings = {};

  @override
  void initState() {
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
            "Yolculuk Detayları",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xFF5283C1),
          toolbarHeight: 80,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Color(0xffF5F5F5),
                      borderRadius: BorderRadius.all(Radius.circular(15.0))),
                  width: MediaQuery.of(context).size.width - 20,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: const Text(
                                  "Plaka",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                  child: const Text(
                                    "Güzergah",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Color(0xFF5283c1),
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: Text(
                                  veriHaritasi["carInfo"]['plaka'].toString(),
                                  style: const TextStyle(
                                    color: Color(0xFF777777),
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                child: Text(
                                  veriHaritasi["rideInfo"]['nereye']
                                          .toString() +
                                      " - " +
                                      veriHaritasi["rideInfo"]['nereden']
                                          .toString(),
                                  style: const TextStyle(
                                    color: Color(0xFF777777),
                                    fontSize: 14,
                                  ),
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
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: const Text("Başlangıç Saati",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: Text(
                                  "${DateFormat('dd.MM.yyyy HH:mm').format(DateTime.parse(veriHaritasi["rideInfo"]['yolcularbaslamasaati']))}",
                                  style: const TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: const Text("Bitiş Saati",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: const Text(
                                  " - ",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: const Text("Süre",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400)),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(right: 10),
                                child: const Text(
                                  " - ",
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 14,
                                  ),
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
                        Container(
                          decoration: const BoxDecoration(
                            color: Color(0xffF5F5F5),
                            borderRadius:
                                BorderRadius.all(Radius.circular(15.0)),
                          ),
                          width: MediaQuery.of(context).size.width - 30,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Text(
                                  "Yolcu Listesi",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              const SizedBox(height: 10),
                              for (var passengerName in veriHaritasi['users'])
                                PassengerListItemWidget(context, passengerName),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 10,
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

  yildizver(context, driveid, oldstartCount) {
    int selectedRating = caridRatings[driveid] ?? 0;
    if (oldstartCount != -1) {
      selectedRating = oldstartCount;
    }
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (int i = 1; i <= 5; i++)
                InkWell(
                  onTap: () {
                    setState(() {
                      caridRatings[driveid] = i; // carid'e özgü puanı sakla
                    });
                  },
                  child: Icon(
                    i <= selectedRating ? Icons.star : Icons.star_border,
                    color: Colors.yellow,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          oldstartCount == -1
              ? ElevatedButton(
                  onPressed: () async {
                    int rating = caridRatings[driveid] ?? 0;
                    // carid'e özgü puanı al
                    if (rating == 0) {
                      // Kullanıcı puan vermediğinde uyarı ver
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Uyarı'),
                            content: const Text('Lütfen bir puan seçin.'),
                            actions: <Widget>[
                              TextButton(
                                child: const Text('Kapat'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      var response = await PostServices.surucuyeyildizver(
                          driveid, rating, "");
                      ;
                      Map<String, dynamic> responseMap =
                          jsonDecode(response.body);

                      if (response.statusCode == 200) {
                        if (responseMap['status'] == '1') {
                          notification(context, responseMap['mesaj']);
                        } else {
                          notification(context, responseMap['mesaj']);
                        }
                      } else {
                        notification(context, "Sunucu hatası veya ağ hatası!");
                      }
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Puan Ver',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  // detayBtn(surus, context)
  // {
  //   if (surus['status'].toString() == "0") {
  //     return Center(
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: <Widget>[
  //           const SizedBox(height: 20),
  //           ElevatedButton(
  //             onPressed: () async {
  //               var sonuc = await yolculuguBitir(surus['carid']);

  //               if (sonuc['status'].toString() == "0") {
  //                 notification(context, sonuc['mesaj']);
  //               } else if (sonuc['status'].toString() == "1") {
  //                 Navigator.of(context).pop();
  //                 notification(context, sonuc['mesaj']);
  //                 Navigator.pushReplacement(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => const MyDrivesPage()),
  //                 );
  //               }

  //               showDialog(
  //                 context: context,
  //                 builder: (BuildContext context) {
  //                   Future.delayed(const Duration(seconds: 1), () {
  //                     Navigator.of(context).pop();
  //                   });
  //                   return AlertDialog(
  //                     title: const Text('Yolculuk Tamamlandı'),
  //                     content: const Text('Yolculuk başarıyla sona erdi.'),
  //                     actions: <Widget>[
  //                       TextButton(
  //                         child: const Text('Kapat'),
  //                         onPressed: () {
  //                           Navigator.of(context).pop();
  //                         },
  //                       ),
  //                     ],
  //                   );
  //                 },
  //               );
  //             },
  //             style: ElevatedButton.styleFrom(
  //               backgroundColor: Colors.blue,
  //               padding:
  //                   const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
  //               shape: RoundedRectangleBorder(
  //                 borderRadius: BorderRadius.circular(10),
  //               ),
  //             ),
  //             child: const Text(
  //               'Yolculuğu Bitir',
  //               style: TextStyle(
  //                 fontSize: 18,
  //                 color: Colors.white, // Yazı rengi
  //               ),
  //             ),
  //           ),
  //         ],
  //       ),
  //     );
  //   } else {
  //     return Text(surus['zaman_farki'].toString());
  //   }
  // }

  eskisuruslerimCard(surus, context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 3, // Kartı yükseltmek için gölge ekler
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0), // Kenarları yuvarlar
        ),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      surus['plaka'],
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18, // Daha büyük boyut
                      ),
                    ),
                    const SizedBox(height: 8),
                    // detayBtn(surus, context),
                    // paylasbtnkontrol(girisyapankullaniciid, surus),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
