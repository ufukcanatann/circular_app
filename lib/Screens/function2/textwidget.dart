import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Capality extends StatefulWidget {
  String? title;
  String? hintext;
  final Function(String)? kapasite;

  Capality({super.key, this.hintext, this.title, this.kapasite});

  @override
  State<Capality> createState() => _CapalityState();
}

class _CapalityState extends State<Capality> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.title.toString()),
          SizedBox(
            height: 3,
          ),
          Container(
            height: 40,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Center(
              child: TextField(
                controller: _textEditingController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  hintText: widget.hintext.toString(),
                  hintStyle: TextStyle(color: Color(0xFF999999), fontSize: 14),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter
                      .digitsOnly,
                ],
                onChanged: (newValue) {
                  setState(() {});
                  widget.kapasite!(newValue!);
                },
                style: TextStyle(height: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
