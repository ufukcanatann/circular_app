// ignore_for_file: prefer_const_constructors, unused_local_variable

import 'dart:convert';
import 'package:flutter/material.dart';
import '../Services/get_services.dart';
import 'HomePage.dart';
import 'Widget/journey_history_button_widget.dart';
import 'Widget/journey_history_widget.dart';
import 'functions/data.dart';

import 'functions/widget.dart';

class MyDrivesPage extends StatefulWidget {
  const MyDrivesPage({super.key});
  @override
  State<MyDrivesPage> createState() => _MyDrivesPageState();
}

class _MyDrivesPageState extends State<MyDrivesPage> {
  var type = 0;

  var selected;
  List? selectedList;
  List listToSearch = [
    {'name': 'Amir', 'class': 12},
    {'name': 'Raza', 'class': 11},
    {'name': 'Praksh', 'class': 10},
    {'name': 'Nikhil', 'class': 9},
    {'name': 'Sandeep', 'class': 8},
    {'name': 'Tazeem', 'class': 7},
    {'name': 'Najaf', 'class': 6},
    {'name': 'Izhar', 'class': 5},
  ];

  List<dynamic> yolcuoldugusurusler = [];
  List<dynamic> surucuoldugunsurusler = [];

  bool isLoading = true;
  int selectedRating = 0;
  Map<int, int> caridRatings = {};
  var girisyapankullaniciid;
  var userData;
  Future<dynamic> getmydrives() async {
    var response = await GetServices.getmydrives();
    var loginid = await getUserId();

    setState(() {
      var ara = json.decode(response.body);
      yolcuoldugusurusler = ara['yolcuoldugusurusler'];
      surucuoldugunsurusler = ara['surucuoldugunsurusler'];

      girisyapankullaniciid = ara['userid'];

      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    getmydrives();
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const HomePage(),
                ),
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
          title: const Text(
            "Yolculuk Geçmişi",
            style: TextStyle(
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
          backgroundColor: const Color(0xFF5283C1),
          toolbarHeight: 80,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      //_showCustomOverlay(context);
                    },
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: const Text(
                          "Yakınlığa göre sırala",
                          style: TextStyle(fontSize: 12),
                        )),
                  ),
                  const Icon(Icons.arrow_drop_down)
                ],
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.8,
                child: (yolcuoldugusurusler.isEmpty &&
                        surucuoldugunsurusler.isEmpty)
                    ? Center(
                        child: Text("Yolculuğunuz bulunmamaktadır."),
                      )
                    : ListView.builder(
                        itemBuilder: (BuildContext context, int index) {
                          if (index < yolcuoldugusurusler.length) {
                            // İlk liste için
                            if (yolcuoldugusurusler[index]['aystatus']
                                        .toString() ==
                                    "3" ||
                                yolcuoldugusurusler[index]['aystatus']
                                        .toString() ==
                                    "-1") {
                              return Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: JourneyHistoryWidget(
                                    context,
                                    yolcuoldugusurusler[index],
                                    girisyapankullaniciid),
                              );
                            } else {
                              return Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: journeyButtonWidget(
                                    context,
                                    yolcuoldugusurusler[index],
                                    girisyapankullaniciid),
                              );
                            }
                          } else {
                            // İkinci liste için
                            int newIndex = index - yolcuoldugusurusler.length;
                            if (surucuoldugunsurusler[newIndex]['aystatus']
                                        .toString() ==
                                    "3" ||
                                surucuoldugunsurusler[newIndex]['aystatus']
                                        .toString() ==
                                    "-1") {
                              return Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: JourneyHistoryWidget(
                                    context,
                                    surucuoldugunsurusler[newIndex],
                                    girisyapankullaniciid),
                              );
                            } else {
                              return Container(
                                padding:
                                    const EdgeInsets.only(left: 10, right: 10),
                                child: journeyButtonWidget(
                                    context,
                                    surucuoldugunsurusler[newIndex],
                                    girisyapankullaniciid),
                              );
                            }
                          }
                        },
                        itemCount: yolcuoldugusurusler.length +
                            surucuoldugunsurusler.length,
                      ),
              )
            ],
          ),
        ),
      );
    }
  }
}
