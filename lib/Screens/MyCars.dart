import 'dart:convert';

import 'package:flutter/material.dart';

import '../Classes/Users.dart';
import '../Services/get_services.dart';
import 'Widget/car_list_widget.dart';
import 'functions/data.dart';
import 'functions/widget.dart';

class MyCars extends StatefulWidget {
  const MyCars({super.key});

  @override
  State<MyCars> createState() => _MyCarsState();
}

class _MyCarsState extends State<MyCars> {
  int? userid = 0;
  Users? users;
  List<dynamic> araclistesi = [];
  bool isLoading = true;
  var userData;
  Future<dynamic> getMyCarList() async {
    var response = await GetServices.getCarList(1);
    setState(() {
      var ara = json.decode(response.body);
      araclistesi = ara['data'];
      isLoading = false;
    });
  }

  getuserdata() async {
    var sonuc = await getUserAllData();
    setState(() {
      userData = sonuc;
    });
  }

  @override
  void initState() {
    super.initState();
    getMyCarList();
    getuserdata();
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
              Navigator.pop(context);
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
            "Araçlarım",
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
              const SizedBox(
                height: 10,
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width * 0.04,
                      right: MediaQuery.of(context).size.width * 0.04),
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Color(0xffF5F5F5),
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    ),
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        if (araclistesi.isEmpty)
                          const Padding(
                            padding: EdgeInsets.all(20),
                            child: Text(
                              "Kayıtlı aracınız bulunmamaktadır",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          )
                        else
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 10,
                              ),
                              Container(
                                decoration: const BoxDecoration(
                                  color: Color(0xffF5F5F5),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    for (var parameters in araclistesi)
                                      CarListWidget(
                                        arac: parameters["marka"]! +
                                            " " +
                                            parameters["model"]!,
                                        plaka: parameters["plaka"]!,
                                        tip: parameters["status"].toString()!,
                                        id: parameters["id"]!,
                                      ),
                                    const SizedBox(height: 10),
                                  ],
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    }
  }
}
