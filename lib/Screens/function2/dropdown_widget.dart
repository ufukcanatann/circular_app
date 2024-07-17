import 'dart:convert';

import 'package:flutter/material.dart';

import '../../Services/get_services.dart';

class DropdownWidget extends StatefulWidget {
  String? title;
  String? hintext;
  final Function(String)? onItemSelected;

  DropdownWidget({Key? key, this.hintext, this.title, this.onItemSelected})
      : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  bool isLoading = true;

  final List<String> semtList = [];
  Future<dynamic> getStateList() async {
    var response = await GetServices.getStateList();
    setState(() {
      var ara = json.decode(response.body);
      ara = ara['data'];
      for (var i = 0; i < ara.length; i++) {
        semtList.add(ara[i]['name']);
      }

      isLoading = false;
    });
  }

  void initState() {
    super.initState();
    getStateList();
  }

  String? _chosenModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title.toString()),
          const SizedBox(
            height: 5,
          ),
          Center(
            child: Container(
              width: MediaQuery.of(context).size.width * 0.90,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                    10), // Burada kenar yuvarlaklığı ayarlıyoruz
              ),
              child: Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.03,
                ),
                child: DropdownButton<String>(
                  menuMaxHeight: MediaQuery.of(context).size.height * 0.3,
                  underline: Container(),
                  value: _chosenModel,
                  items: semtList.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _chosenModel = newValue;
                    });

                    if (widget.onItemSelected != null) {
                      widget.onItemSelected!(newValue!);
                    }
                  },
                  hint: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: widget.hintext.toString(),
                          style: TextStyle(
                            color: Color(0xFF999999),
                            fontSize: 14,
                          ),
                        ),
                        WidgetSpan(
                          alignment: PlaceholderAlignment.middle,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.58,
                          ),
                        ),
                      ],
                    ),
                  ),
                  elevation: 1,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
