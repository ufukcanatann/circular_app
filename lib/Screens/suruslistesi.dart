// ignore_for_file: sized_box_for_whitespace, unused_local_variable, prefer_const_constructors

import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Services/get_services.dart';
import '../Services/post_services.dart';
import 'function2/card_widget.dart';
import 'functions/widget.dart';

class SurusListesi extends StatefulWidget {
  const SurusListesi({super.key});

  @override
  State<SurusListesi> createState() => _SurusListesiState();
}

final TextEditingController textEditingController = TextEditingController();

class _SurusListesiState extends State<SurusListesi> {
  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  var semtler = [];
  bool isLoading = true;
  String? nereden;
  String? nereye;
  String? filtre;
  final TextEditingController textEditingController = TextEditingController();

  List<String> semtlist = [];
  var yolculuklar = [];
  @override
  void initState() {
    super.initState();
    semtlistesi();
  }

  Future<dynamic> semtlistesi() async {
    var response = await GetServices.getStateList();
    setState(() {
      var ara = json.decode(response.body);
      semtler = ara['data'];
      yolculuklistesinigetir("", "", "");
      semtlist.add("Tümü");
      for (var i = 0; i < semtler.length; i++) {
        semtlist.add(semtler[i]['name']);
      }
      isLoading = false;
    });
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
    });
    return ara['data'];
  }

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
        } else {
          SystemChrome.setPreferredOrientations([]);
        }

        if (isLoading) {
          return loadingbar();
        }

        return Scaffold(
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    child: aramaEkrani(),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.675,
                    child: yolculuklar.isNotEmpty
                        ? ListView(
                            children: List.generate(
                              yolculuklar.length,
                              (index) => Container(
                                color: Colors.white,
                                padding: const EdgeInsets.only(
                                  left: 10,
                                  right: 10,
                                ),
                                child: AracKart(context, yolculuklar[index]),
                              ),
                            ),
                          )
                        : (!isLoading)
                            ? Center(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0),
                                  child: Text(
                                    'Üzgünüz, aradığınız kriterlere uygun yolculuk bulunamadı.',
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.black87),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                            : Container(),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  aramaEkrani() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10),
        const Text(
          'Nereye Gitmek İstersiniz?',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  'Nereden',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: semtlist
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: nereden,
                onChanged: (value) {
                  setState(() {
                    nereden = value;
                    nereden = value;
                    var yolculuklar =
                        yolculuklistesinigetir(nereden, nereye, "");
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 150,
                ),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 250,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: textEditingController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'İlçe Arayın',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return item.value.toString().contains(searchValue);
                  },
                ),
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    textEditingController.clear();
                  }
                },
              ),
            ),
            DropdownButtonHideUnderline(
              child: DropdownButton2<String>(
                isExpanded: true,
                hint: Text(
                  'Nereye',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).hintColor,
                  ),
                ),
                items: semtlist
                    .map((item) => DropdownMenuItem(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                            ),
                          ),
                        ))
                    .toList(),
                value: nereye,
                onChanged: (value) {
                  setState(() {
                    nereye = value;
                    nereye = value;
                    var yolculuklar =
                        yolculuklistesinigetir(nereden, nereye, "");
                  });
                },
                buttonStyleData: const ButtonStyleData(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  height: 40,
                  width: 150,
                ),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 250,
                ),
                menuItemStyleData: const MenuItemStyleData(
                  height: 40,
                ),
                dropdownSearchData: DropdownSearchData(
                  searchController: textEditingController,
                  searchInnerWidgetHeight: 50,
                  searchInnerWidget: Container(
                    height: 50,
                    padding: const EdgeInsets.only(
                      top: 8,
                      bottom: 4,
                      right: 8,
                      left: 8,
                    ),
                    child: TextFormField(
                      expands: true,
                      maxLines: null,
                      controller: textEditingController,
                      decoration: InputDecoration(
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 8,
                        ),
                        hintText: 'İlçe Arayın',
                        hintStyle: const TextStyle(fontSize: 12),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  searchMatchFn: (item, searchValue) {
                    return item.value.toString().contains(searchValue);
                  },
                ),
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    textEditingController.clear();
                  }
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
