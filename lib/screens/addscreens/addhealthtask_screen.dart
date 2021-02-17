import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/components/importAll.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:reminder_app/screens/importAll.dart';
import 'package:reminder_app/services/importAll.dart';
import 'package:reminder_app/modals/health_modal.dart';

class AddHealthTaskScreen extends StatefulWidget {
  static String route = "addHealth";

  final Health health;
  final int healthindex;

  AddHealthTaskScreen({
    this.health,
    this.healthindex,
  });

  @override
  _AddHealthTaskScreenState createState() => _AddHealthTaskScreenState();
}

class _AddHealthTaskScreenState extends State<AddHealthTaskScreen> {
  String Morlable = "Add Time";
  String Aftrlable = "Add Time";
  String Nytlable = "Add Time";
  String err;

  TimeOfDay timeselected1;
  TimeOfDay timeselected2;
  TimeOfDay timeselected3;

  DateTimeSelector dateTimeSelector;

  TextEditingController _medicineNameController;
  TextEditingController _medicineDescriptionController;

  @override
  void initState() {
    super.initState();

    dateTimeSelector = DateTimeSelector();
    _medicineNameController = TextEditingController();
    _medicineDescriptionController = TextEditingController();

    if (widget.health != null) {
      _medicineNameController.text = widget.health.medicine_name;
      _medicineDescriptionController.text = widget.health.medicine_description;
      Morlable =
          (widget.health.mor_time == " ") ? "Add Time" : widget.health.mor_time;
      Aftrlable =
          (widget.health.aft_time == " ") ? "Add Time" : widget.health.aft_time;
      Nytlable =
          (widget.health.nyt_time == " ") ? "Add Time" : widget.health.nyt_time;
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
                  icon: Image.asset("assets/images/pills.jpg"),
                  iconSize: 60,
                  onPressed: null),
              Text(
                "Add Health Reminder",
                style: TextStyle(
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        (widget.health != null)
            ? Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(CupertinoIcons.info),
                    Text(
                      "Time Shown is previously added time... \nPlease select Time Again",
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 20,
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
            controller: _medicineNameController,
            labelText: "Medicine Name",
            prefixIcon: Icon(
              CommunityMaterialIcons.medical_bag,
              size: 25,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: CustomTextField(
            controller: _medicineDescriptionController,
            labelText: "Medicine Description",
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
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  labelText: "Morning Time",
                  prefixIcon: Icon(
                    CommunityMaterialIcons.weather_sunset,
                    size: 30,
                  ),
                  enabled: false,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              MainActionButton(
                label: Morlable,
                onPressed: () async {
                  timeselected1 = await dateTimeSelector.selectTime(context);
                  if (timeselected1 != null) {
                    setState(() {
                      Morlable =
                          "${timeselected1.hour}:${timeselected1.minute}";
                    });
                  } else {
                    setState(() {
                      Morlable = "Add Time";
                    });
                  }
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  labelText: "Afternoon Time",
                  prefixIcon: Icon(
                    CommunityMaterialIcons.weather_sunny,
                    size: 30,
                  ),
                  enabled: false,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              MainActionButton(
                label: Aftrlable,
                onPressed: () async {
                  timeselected2 = await dateTimeSelector.selectTime(context);
                  if (timeselected2 != null) {
                    setState(() {
                      Aftrlable =
                          "${timeselected2.hour}:${timeselected2.minute}";
                    });
                  } else {
                    setState(() {
                      Aftrlable = "Add Time";
                    });
                  }
                },
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              Expanded(
                child: CustomTextField(
                  labelText: "Night Time",
                  prefixIcon: Icon(
                    CommunityMaterialIcons.moon_waning_crescent,
                    size: 30,
                  ),
                  enabled: false,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              MainActionButton(
                label: Nytlable,
                onPressed: () async {
                  timeselected3 = await dateTimeSelector.selectTime(context);
                  if (timeselected3 != null) {
                    setState(() {
                      Nytlable =
                          "${timeselected3.hour}:${timeselected3.minute}";
                    });
                  } else {
                    setState(() {
                      Nytlable = "Add Time";
                    });
                  }
                },
              ),
            ],
          ),
        ),
        widget.health == null
            ? MainActionButton(
                width: size.width,
                label: "Add Reminder",
                onPressed: () {
                  addHealthReminder();
                },
              )
            : MainActionButton(
                width: size.width,
                label: "Update Reminder",
                onPressed: () {
                  updateHealthReminder();
                },
              )
      ],
    );
  }

  addHealthReminder() async {
    try {
      print("addHealth try entred");
      if (_medicineNameController.text.isEmpty) throw ("name");
      if (timeselected1 == null &&
          timeselected2 == null &&
          timeselected3 == null) throw ("time");

      await DatabaseProvider.db.getId();

      Health health = Health(
        medicine_name: _medicineNameController.text,
        medicine_description: _medicineDescriptionController.text,
        mor_time: timeselected1 == null
            ? " "
            : "${timeselected1.hour}:${timeselected1.minute}",
        aft_time: timeselected2 == null
            ? " "
            : "${timeselected2.hour}:${timeselected2.minute}",
        nyt_time: timeselected3 == null
            ? " "
            : "${timeselected3.hour}:${timeselected3.minute}",
      );

      await DatabaseProvider.db.insertHealth(health);

      try {
        print("notiservice try entred ${health.health_id}");
        int id = health.health_id;
        notificationServices.repeatHealthNotficaiton(
            id, health, timeselected1, timeselected2, timeselected3);
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
              content: Text("Medicine Added Successfully!"),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                    // Navigator.pushReplacementNamed(context, TaskScreen.route);
                  },
                  child: Text(
                    "Main Screen",
                    style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                ),
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    // Navigator.pushReplacementNamed(context, AddTaskScreen.route);
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
        _medicineNameController.clear();
        Morlable = "Add Time";
        Aftrlable = "Add Time";
        Nytlable = "Add Time";
        timeselected1 = null;
        timeselected2 = null;
        timeselected3 = null;
      });
    } catch (e) {
      err = e;
      print(err);
      CustomAlertDialogHealth(
        context: context,
        e: err,
      ).AlertDialogDisplay();
    }
  }

  updateHealthReminder() async {
    try {
      if (_medicineNameController.text.isEmpty) throw ("name");
      if (timeselected1 == null &&
          timeselected2 == null &&
          timeselected3 == null) throw ("time");

      await DatabaseProvider.db.getId();

      Health health = Health(
        health_id: widget.health.health_id,
        medicine_name: _medicineNameController.text,
        medicine_description: _medicineDescriptionController.text,
        mor_time: timeselected1 == null
            ? Morlable
            : "${timeselected1.hour}:${timeselected1.minute}",
        aft_time: timeselected2 == null
            ? Aftrlable
            : "${timeselected2.hour}:${timeselected2.minute}",
        nyt_time: timeselected3 == null
            ? Nytlable
            : "${timeselected3.hour}:${timeselected3.minute}",
      );

      await DatabaseProvider.db.updateHealth(health);

      await notificationServices.deletehealthnotification(health.health_id);

      try {
        print("notiservice try entred ${health.health_id}");
        int id = health.health_id;
        notificationServices.repeatHealthNotficaiton(
            id, health, timeselected1, timeselected2, timeselected3);
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
              content: Text("Medicine Updated Successfully!"),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Main Screen",
                    style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1)),
                  ),
                ),
              ],
            );
          });

      setState(() {
        _medicineNameController.clear();
        Morlable = "Add Time";
        Aftrlable = "Add Time";
        Nytlable = "Add Time";
      });
    } catch (e) {
      CustomAlertDialogHealth(
        context: context,
        e: e,
      ).AlertDialogDisplay();
    }
  }
}
