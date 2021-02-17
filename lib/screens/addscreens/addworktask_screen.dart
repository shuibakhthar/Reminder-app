import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:reminder_app/components/importAll.dart';
import 'package:reminder_app/modals/importAll.dart';
import 'package:reminder_app/screens/importAll.dart';
import 'package:reminder_app/services/importAll.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class AddWorkTaskScreen extends StatefulWidget {
  static String route = "addwork";

  final Work work;
  int workindex;

  AddWorkTaskScreen({this.work, this.workindex});

  @override
  _AddWorkTaskScreenState createState() => _AddWorkTaskScreenState();
}

class _AddWorkTaskScreenState extends State<AddWorkTaskScreen> {
  bool isStop = false;

  String err;
  String StrTimelable = "Add Time";
  String StrDatelable = "Add Date";
  String StpTimelable = "Add Time";
  String StpDatelable = "Add Date";

  DateTime dateselected1;
  TimeOfDay timeselected1;

  DateTime dateselected2;
  TimeOfDay timeselected2;

  TextEditingController _workTitleController;
  TextEditingController _workDescriptionController;

  DateTimeSelector dateTimeSelector;

  @override
  void initState() {
    super.initState();
    _workTitleController = TextEditingController();
    _workDescriptionController = TextEditingController();
    dateTimeSelector = DateTimeSelector();

    if (widget.work != null) {
      _workTitleController.text = widget.work.work_title;
      _workDescriptionController.text = widget.work.work_description;
      StrDatelable =
          (widget.work.str_date == " ") ? "Add Time" : widget.work.str_date;
      StrTimelable =
          (widget.work.str_time == " ") ? "Add Time" : widget.work.str_time;
      StpDatelable =
          (widget.work.stp_date == " ") ? "Add Time" : widget.work.stp_date;
      StpTimelable =
          (widget.work.stp_time == " ") ? "Add Time" : widget.work.stp_time;
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
                  icon: Image.asset("assets/images/task.png"),
                  iconSize: 45,
                  onPressed: null),
              Text(
                "Add Work Reminder",
                style: TextStyle(
                  fontSize: 30,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
        (widget.work != null)
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
            controller: _workTitleController,
            labelText: "Work Title",
            prefixIcon: Icon(
              CommunityMaterialIcons.clipboard_list_outline,
              size: 25,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: CustomTextField(
            controller: _workDescriptionController,
            labelText: "Work Description",
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
            labelText: "Start Date & Time",
            prefixIcon: Icon(
              CommunityMaterialIcons.ray_start,
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
                  label: StrDatelable,
                  onPressed: () async {
                    dateselected1 = await dateTimeSelector.selectDate(context);
                    if (dateselected1 != null) {
                      setState(() {
                        StrDatelable =
                            "${DateFormat("dd-MM-yyyy").format(dateselected1)}";
                      });
                    } else {
                      setState(() {
                        StrDatelable = "Add Date";
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
                  label: StrTimelable,
                  onPressed: () async {
                    timeselected1 = await dateTimeSelector.selectTime(context);
                    if (timeselected1 != null) {
                      setState(() {
                        StrTimelable =
                            "${timeselected1.hour}:${timeselected1.minute}";
                      });
                    } else {
                      setState(() {
                        StrTimelable = "Add Time";
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
        CheckboxListTile(
          secondary: Icon(CommunityMaterialIcons.reminder),
          title: Text(
            "Remind me until I finish the work",
            style: TextStyle(fontSize: 17),
          ),
          subtitle: Text(
            "Reminds every 15 min",
          ),
          value: this.isStop,
          onChanged: (value) {
            setState(() {
              this.StpTimelable = "Add Time";
              this.StpDatelable = "Add Date";
              this.isStop = value;
            });
          },
        ),
        Column(
          children: (isStop)
              ? [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: CustomTextField(
                      labelText: "End Date & Time",
                      prefixIcon: Icon(
                        CommunityMaterialIcons.stop_circle,
                        size: 30,
                      ),
                      enabled: false,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: MainActionButton(
                            label: StpDatelable,
                            onPressed: () async {
                              dateselected2 =
                                  await dateTimeSelector.selectDate(context);
                              if (dateselected2 != null) {
                                setState(() {
                                  StpDatelable =
                                      "${DateFormat("dd-MM-yyyy").format(dateselected2)}";
                                });
                              } else {
                                setState(() {
                                  StpDatelable = "Add Date";
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
                            label: StpTimelable,
                            onPressed: () async {
                              timeselected2 =
                                  await dateTimeSelector.selectTime(context);
                              if (timeselected2 != null) {
                                setState(() {
                                  StpTimelable =
                                      "${timeselected2.hour}:${timeselected2.minute}";
                                });
                              } else {
                                setState(() {
                                  StpTimelable = "Add Time";
                                });
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ]
              : [],
        ),
        widget.work == null
            ? MainActionButton(
                width: size.width,
                label: "Add Reminder",
                onPressed: () {
                  addWorkReminder(context);
                },
              )
            : MainActionButton(
                width: size.width,
                label: "Add Reminder",
                onPressed: () {
                  updateWorkReminder(context);
                },
              )
      ],
    );
  }

  void addWorkReminder(BuildContext context) async {
    try {
      if (_workTitleController.text.isEmpty) throw ("name");
      if (dateselected1 == null || timeselected1 == null) throw ("invalid");
      if (isStop &&
          (dateselected1 == null ||
              timeselected1 == null ||
              dateselected2 == null ||
              timeselected2 == null)) throw ("invalid");

      await DatabaseProvider.db.getId();

      Work work = Work(
        work_title: _workTitleController.text,
        work_description: _workDescriptionController.text,
        str_date: dateselected1.toString(),
        str_time: "${timeselected1.hour}:${timeselected1.minute}",
        stp_date: dateselected2.toString(),
        stp_time: timeselected2 == null
            ? " "
            : "${timeselected2.hour}:${timeselected2.minute}",
        isStop: isStop,
      );

      await DatabaseProvider.db.insertWork(work);

      try {
        print("notiservice try entred ${work.work_id}");
        int id = work.work_id;
        notificationServices.scheduleworknotification(id, work, dateselected1,
            timeselected1, dateselected2, timeselected2);
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
              content: Text("Work Added Successfully!"),
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
        _workTitleController.clear();
        _workDescriptionController.clear();
        StrDatelable = "Add Date";
        StrTimelable = "Add Time";
        StpDatelable = "Add Date";
        StpTimelable = "Add Time";
        isStop = false;
        dateselected1 = null;
        dateselected2 = null;
        timeselected1 = null;
        timeselected2 = null;
      });
    } catch (e) {
      err = e;
      CustomAlertDialogWork(context: context, e: err).AlertDialogDisplay();
    }

    // String res = "${timeselected1.hour}:${timeselected1.minute}";
    // print(res);
    //todo here is the conversion
    // TimeOfDay  res2 = TimeOfDay(hour:int.parse(res.split(":")[0]),minute: int.parse(res.split(":")[1].split(" ")[0]));
    // print(res2);
  }

  void updateWorkReminder(BuildContext context) async {
    try {
      if (_workTitleController.text.isEmpty) throw ("name");
      if (dateselected1 == null || timeselected1 == null) throw ("invalid");
      if (isStop &&
          (dateselected1 == null ||
              timeselected1 == null ||
              dateselected2 == null ||
              timeselected2 == null)) throw ("invalid");

      await DatabaseProvider.db.getId();

      Work work = Work(
        work_id: widget.work.work_id,
        work_title: _workTitleController.text,
        work_description: _workDescriptionController.text,
        str_date:
            dateselected1 == null ? StrDatelable : dateselected1.toString(),
        str_time: timeselected1 == null
            ? StrTimelable
            : "${timeselected1.hour}:${timeselected1.minute}",
        stp_date:
            dateselected2 == null ? StpDatelable : dateselected2.toString(),
        stp_time: timeselected2 == null
            ? StpTimelable
            : "${timeselected2.hour}:${timeselected2.minute}",
        isStop: isStop,
      );

      await DatabaseProvider.db.updateWork(work);

      await notificationServices.deleteworknotification(work.work_id);

      try {
        print("notiservice try entred ${work.work_id}");
        int id = work.work_id;
        notificationServices.scheduleworknotification(id, work, dateselected1,
            timeselected1, dateselected2, timeselected2);
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
              content: Text("Work Updated Successfully!"),
              actions: [
                FlatButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "Back",
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
        _workTitleController.clear();
        StrDatelable = "Add Date";
        StrTimelable = "Add Time";
        StpDatelable = "Add Date";
        StpTimelable = "Add Time";
        isStop = false;
      });
    } catch (e) {
      err = e;
      CustomAlertDialogWork(context: context, e: err).AlertDialogDisplay();
    }
  }
}
