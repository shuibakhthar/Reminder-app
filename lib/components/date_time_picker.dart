import 'package:flutter/material.dart';

class DateTimeSelector {

  DateTime d;
  TimeOfDay t;

  Future selectDate(BuildContext context) async {
    return  d =  await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(3000)
    );
  }

  Future selectTime(BuildContext context) async{
    return t = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
    );
  }

}