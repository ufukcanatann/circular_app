// ignore_for_file: sort_child_properties_last, avoid_print, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_new, prefer_const_constructors, non_constant_identifier_names, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:flutter/material.dart';
import '../../Services/post_services.dart';
import '../functions/data.dart';
import '../functions/widget.dart';
import '../map_page.dart';
import '../mydrives.dart';

AracKart(context, item) {
  // String formattedDate = item['yolcularbaslamasaati'];
  // String formattedTime = item['yolcularbaslamasaati'];
  // var split_string = formattedDate.split(' ');
  // formattedDate = split_string[0];
  // formattedTime = split_string[1];

  String formattedDate = item['yolcularbaslamasaati'];
  String formattedTime = item['yolcularbaslamasaati'];
  var splitDateTime = formattedDate.split(' ');
  var splitDate = splitDateTime[0].split('-');
  var splitTime = splitDateTime[1].split(':');
  formattedDate = '${splitDate[2]}.${splitDate[1]}.${splitDate[0]}';
  formattedTime = '${splitTime[0]}:${splitTime[1]}';

  return Container(
    color: Colors.white,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: CircleAvatar(
                          backgroundColor: Color(0xFF5283C1),
                          backgroundImage: NetworkImage(
                              getImagePath(item['image'].toString())),
                          radius: 30,
                        ),
                      ),
                      SizedBox(width: 8),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item['marka'] + " " + item['model'],
                              style: TextStyle(
                                  fontSize: 18, color: Color(0xFF1D1D1D)),
                            ),
                            // SizedBox(height: 2),
                            Container(
                              width: 100,
                              child: Text(
                                item['plaka'],
                                style: TextStyle(
                                    fontSize: 14, color: Color(0xFF6F6F6F)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  Container(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            var response =
                                await PostServices.yolculuktalebigonder(
                                    item['id']);
                            var ara = json.decode(response.body);
                            if (ara['status'] == 0) {
                              notification(context, ara['mesaj'].toString());
                            } else {
                              notification(context, ara['mesaj'].toString());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const MyDrivesPage(),
                                ),
                              );
                            }
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color(0xFF5283C1)),
                          ),
                          child: Container(
                            child: Text(
                              "Talep Et",
                              style: TextStyle(color: Color(0xFFFFFFFF)),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Divider(
              color: Color.fromARGB(70, 217, 217, 217),
              thickness: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        child: Text(
                          formattedDate,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          formattedTime,
                          style: TextStyle(color: Color(0xFF777777)),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => MapScreen(
                                    enlem: double.parse(item['enlembas']),
                                    boylam: double.parse(item['boylambas']),
                                    rideid: item['id'].toString(),
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Text(
                                  "Güzergah",
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color(0xFF5283c1)
                                    
                                  ),
                                ),
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 18,
                                  color: Color(0xFF5283c1)
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        child: Text(
                          item['nereden'] + " - " + item['nereye'],
                          style: const TextStyle(color: Color(0xFF5283c1), fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        child: const Text(
                          "Puan",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          item['aracpuani'].toString(),
                          style: const TextStyle(color: Color(0xFF777777)),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Container(
                        child: const Text(
                          "Kapasite",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Text(
                        item['kapasite'].toString(),
                        style: const TextStyle(color: Color(0xFF777777)),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: const Offset(2, 2),
            ),
          ],
        ),
      ),
    ),
    // height: 150,
  );
}
