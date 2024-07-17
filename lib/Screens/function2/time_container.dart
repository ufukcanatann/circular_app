import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DropdownWidgetTime extends StatefulWidget {
  String? title;
  String? hintext;
  final Function(String)? selectdate;

  DropdownWidgetTime({super.key, this.title, this.hintext, this.selectdate});

  @override
  State<DropdownWidgetTime> createState() => _DropdownWidgetTimeState();
}

class _DropdownWidgetTimeState extends State<DropdownWidgetTime> {
  String choose = "Tarih Seç";
  DateFormat _dateTimeFormat = DateFormat('yyyy-MM-dd HH:mm');
  TextEditingController _dateTimeController = TextEditingController();

  TextEditingController _dateController = TextEditingController();

  Future<void> _showDateTimePicker(BuildContext context) async {
    DateTime selectedDateTime = DateTime.now();

    // Show date picker
    DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2022),
      lastDate: DateTime(2025),
      initialDate: DateTime.now(),
    );

    if (selectedDate != null) {
      // Show time picker
      TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDateTime),
      );

      if (selectedTime != null) {
        // Combine selected date and time
        selectedDateTime = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        // Update text field
        _dateTimeController.text = _dateTimeFormat.format(selectedDateTime);
        setState(() {
          choose = _dateTimeController.text.toString();
        });

        widget.selectdate!(_dateTimeController.text.toString()!);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        print("---");
        _showDateTimePicker(context);
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title.toString()),
            SizedBox(
              height: 5,
            ),
            Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  choose,
                  textAlign: TextAlign.start,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Color(0xFF999999),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/*
class DropdownWidgetTime extends StatelessWidget {
 
 String? title;
 String? hintext;

DropdownWidgetTime({this.title,this.hintext});
 

  @override
  Widget build(BuildContext context) {

    return  GestureDetector(
      onTap: () async{
     print("---");
_showDatePicker(context);
    
                
        
      },
      child: Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
children: [
  Text(title.toString()),
  SizedBox(height: 5,),
  Container(
  padding: EdgeInsets.only(top: 10),
  height: 50,
  width: 180
  ,
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(10)
  ),
  child: Text(hintext.toString()),
  )
          
          
        
      

  
],

      ),
    ),
    );
  }
}

 void _showDatePicker(BuildContext context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,

      firstDate: DateTime(2022),
      lastDate: DateTime(2025), 
      initialDate: DateTime.now(),
    );

    if (selectedDate != null) {
      
       DateTime selectedDateOnly = DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    print('Selected date: $selectedDateOnly');
    }
  }
*/