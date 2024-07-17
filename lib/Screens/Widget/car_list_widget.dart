import 'package:flutter/material.dart';

import '../yolculukPaylas.dart';

class CarListWidget extends StatelessWidget {
  final String arac;
  final String plaka;
  final String tip;
  final int id;

  CarListWidget(
      {required this.arac,
      required this.plaka,
      required this.tip,
      required this.id});

  double getWidgetHeight() {
    return 60;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
          vertical: MediaQuery.of(context).size.width * 0.015),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding:
                  EdgeInsets.all(MediaQuery.of(context).size.width * 0.025),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.12,
                height: MediaQuery.of(context).size.width * 0.12,
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
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    arac,
                    style: const TextStyle(
                      color: Color(0xFF1D1D1B),
                      fontSize: 18,
                    ),
                  ),
                  Text(
                    plaka,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            TextButton(
              onPressed: () {
                if (tip == "1") {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => YolculukPaylas(carid: id),
                    ),
                  );
                }
              },
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4, right: 4),
                    child: Text(
                      tip == "2" ? "Yolculuk Devam Ediyor" : "Yolculuğa Başla",
                      style: const TextStyle(
                        color: Color.fromARGB(100, 0, 0, 0),
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (tip == "1")
              const Padding(
                padding: EdgeInsets.only(right: 10),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Color.fromARGB(100, 0, 0, 0),
                  size: 22,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
