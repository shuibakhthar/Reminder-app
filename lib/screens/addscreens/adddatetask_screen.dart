import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/components/importAll.dart';
import 'package:reminder_app/services/importAll.dart';
import 'package:reminder_app/modals/importAll.dart';
import 'package:reminder_app/screens/importAll.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:community_material_icon/community_material_icon.dart';

class AddDateTaskScreen extends StatefulWidget {
  static String route = "addDate";

  final Date1 date;
  final int dateindex;

  AddDateTaskScreen({this.date, this.dateindex});

  @override
  _AddDateTaskScreenState createState() => _AddDateTaskScreenState();
}

class _AddDateTaskScreenState extends State<AddDateTaskScreen> {
  bool isStop = false;

  String Timelable = "Add Time";
  String Datelable = "Add Date";

  DateTime dateselected;
  TimeOfDay timeselected;

  TextEditingController _dateTitleController;
  TextEditingController _dateDescriptionController;

  DateTimeSelector dateTimeSelector;

  @override
  void initState() {
    super.initState();
    _dateTitleController = TextEditingController();
    _dateDescriptionController = TextEditingController();
    dateTimeSelector = DateTimeSelector();

    if (widget.date != null) {
      _dateTitleController.text = widget.date.date_title;
      _dateDescriptionController.text = widget.date.date_description;
      Datelable = (widget.date.date_ == " ") ? "Add Time" : widget.date.date_;
      Timelable = (widget.date.time_ == " ") ? "Add Time" : widget.date.time_;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return ListView(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      children: [
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                  icon: Image.asset("assets/images/date.png"),
                  iconSize: 45,
                  onPressed: null),
              Text(
                "Add Date Reminder",
                style: TextStyle(
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        (widget.date != null)
            ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.info),
                    Text(
                      "Date & Time Shown is previously added time... \nPlease select Date & Time Again",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 15,
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            : Center(),
        SizedBox(
          height: size.height * .01,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: CustomTextField(
            controller: _dateTitleController,
            labelText: "Date Title",
            prefixIcon: Icon(
              CommunityMaterialIcons.calendar_alert,
              size: 25,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: CustomTextField(
            controller: _dateDescriptionController,
            labelText: "Date Description",
            prefixIcon: Icon(
              CommunityMaterialIcons.note_text_outline,
              size: 25,
            ),
          ),
        ),
        SizedBox(
          height: size.height * .01,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: CustomTextField(
            labelText: "Date & Reminder Time",
            prefixIcon: Icon(
              CommunityMaterialIcons.calendar_today,
              size: 30,
            ),
            enabled: false,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          child: Row(
            children: [
              Expanded(
                child: MainActionButton(
                  label: Datelable,
                  onPressed: () async {
                    dateselected = await dateTimeSelector.selectDate(context);
                    print(dateselected);
                    if (dateselected != null) {
                      setState(() {
                        Datelable =
                            "${DateFormat("dd-MM-yyyy").format(dateselected)}";
                      });
                    } else {
                      setState(() {
                        Datelable = "Add Date";
                      });
                    }
                  },
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: MainActionButton(
                  label: Timelable,
                  onPressed: () async {
                    timeselected = await dateTimeSelector.selectTime(context);
                    print(timeselected);
                    if (timeselected != null) {
                      setState(() {
                        Timelable =
                            "${timeselected.hour}:${timeselected.minute}";
                      });
                    } else {
                      setState(() {
                        Timelable = "Add Time";
                      });
                    }
                    ;
                  },
                ),
              ),
            ],
          ),
        ),
        widget.date == null
            ? MainActionButton(
                width: size.width,
                label: "Add Reminder",
                onPressed: () {
                  addDateReminder();
                },
              )
            : MainActionButton(
                width: size.width,
                label: "Update Reminder",
                onPressed: () {
                  updateDateReminder();
                },
              ),
      ],
    );
  }

  addDateReminder() async {
    try {
      print("adddate try entred");
      if (_dateTitleController.text.isEmpty) throw ("name");
      if (_dateDescriptionController.text.isEmpty) throw ("invalid");
      if (dateselected == null || timeselected == null) throw ("invalid");

      await DatabaseProvider.db.getId();

      Date1 date1 = Date1(
        date_title: _dateTitleController.text,
        date_description: _dateDescriptionController.text,
        date_: dateselected.toString(),
        time_: "${timeselected.hour}:${timeselected.minute}",
      );

      await DatabaseProvider.db.insertDate(date1);

      try {
        print("date noti service try entred");
        int id = date1.date_id;
        notificationServices.scheduledatenotification(
            id, date1, dateselected, timeselected);
      } catch (e) {
        print(e);
      }

      // DatabaseProvider.db.insertDate(
      //   date_title: _dateTitleController.text,
      //   date_: dateselected.toString(),
      //   time_: "${timeselected.hour}:${timeselected.minute}",
      // );
      await DatabaseProvider.db.displayDatabase();

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.blue,
              title: Text("Success"),
              content: Text("Date Updated Successfully!"),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    // Navigator.of(context).pop();
                  },
                  child: Text(
                    "Main Screen",
                    style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Add More",
                    style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                ),
              ],
            );
          });

      setState(() {
        _dateTitleController.clear();
        _dateDescriptionController.clear();
        Datelable = "Add Date";
        Timelable = "Add Time";
        dateselected = null;
        timeselected = null;
      });
    } catch (e) {
      String err = e;
      CustomAlertDialogDate(context: context, e: err).AlertDialogDisplay();
    }
  }

  updateDateReminder() async {
    try {
      print("update date try enterred");
      if (_dateTitleController.text.isEmpty) throw ("name");
      if (_dateDescriptionController.text.isEmpty) throw ("invalid");
      if (dateselected == null || timeselected == null) throw ("invalid");

      await DatabaseProvider.db.getId();

      Date1 date1 = Date1(
        date_id: widget.date.date_id,
        date_title: _dateTitleController.text,
        date_description: _dateDescriptionController.text,
        date_: dateselected.toString(),
        time_: "${timeselected.hour}:${timeselected.minute}",
      );
      // print("id is ${date1.date_id}");

      await DatabaseProvider.db.updateDate(date1);

      await notificationServices.deletedatenotification(date1.date_id);

      try {
        print("date noti service try entred");
        int id = date1.date_id;
        notificationServices.scheduledatenotification(
            id, date1, dateselected, timeselected);
      } catch (e) {
        print(e);
      }

      await DatabaseProvider.db.displayDatabase();

      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              backgroundColor: Colors.blue,
              title: Text("Success"),
              content: Text("Date Updated Successfully!"),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    // Navigator.of(context).pop();
                  },
                  child: Text(
                    "Main Screen",
                    style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                ),
                // FlatButton(
                //   onPressed: (){
                //     Navigator.of(context).pop();
                //   },
                //   child: Text(
                //     "Add More",
                //     style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                //   ),
                // ),
              ],
            );
          });

      setState(() {
        _dateTitleController.clear();
        _dateDescriptionController.clear();
        Datelable = "Add Date";
        Timelable = "Add Time";
        dateselected = null;
        timeselected = null;
      });
    } catch (e) {
      String err = e;
      CustomAlertDialogDate(context: context, e: err).AlertDialogDisplay();
    }
  }
}
