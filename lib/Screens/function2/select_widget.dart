
import 'package:flutter/material.dart';
class SingleChoiceDialog extends StatefulWidget {
  const SingleChoiceDialog({Key? key}) : super(key: key);

  @override
  SingleChoiceDialogState createState() => SingleChoiceDialogState();
}

class SingleChoiceDialogState extends State<SingleChoiceDialog> {

  
  List<String> cities = ["İstanbul", "Ankara", "İzmir", "Elazığ", "Urfa",
  "Maraş","Malatya","Diyarbakır","Isparta","Mardin","Kayseri","Kastamonu"
  
  
  ];
  String selectedCity = "İstanbul";

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      contentPadding: const EdgeInsets.fromLTRB(15, 15, 15, 0),
      content: Column(
        children: cities.map((c) => RadioListTile<String>(
          title: Text(c),
          value: c,
          groupValue: selectedCity,
          onChanged: (value) {
            setState(() {
              selectedCity = value!;
            });
          },
        )).toList(),
      ),
      actions: <Widget>[
        InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Text(
            "Cancel",
            style: TextStyle(color: Colors.black),
          ),
        ),
        InkWell(
          onTap: () {
            // Handle the selected city (selectedCity)
            Navigator.pop(context);
          },
          child: Text(
            "Ok",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
    );
  }
}