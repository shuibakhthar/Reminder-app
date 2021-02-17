import 'package:flutter/material.dart';
import 'package:reminder_app/services/importAll.dart';
import 'package:reminder_app/modals/importAll.dart';
import 'package:reminder_app/components/importAll.dart';
import 'package:reminder_app/screens/importAll.dart';

class DateTaskScreen extends StatefulWidget {
  static String route = "healthtask";

  showdialog1(BuildContext context, Date1 date, int index) =>
      createState().showDateDialog(context, date, index);

  @override
  _DateTaskScreenState createState() => _DateTaskScreenState();
}

class _DateTaskScreenState extends State<DateTaskScreen> {
  @override
  void initState() {
    super.initState();
  }

  getDateofnoti(String date, String time) {
    DateTime notidate = DateTime.parse(date);
    List<String> time1 = time.split(":");
    print(" ${int.parse(time1[0])}, ${int.parse(time1[1])}");
    int hour = int.parse(time1[0]);
    int minute = int.parse(time1[1]);
    notidate = notidate.add(Duration(hours: hour, minutes: minute));
    print(notidate);
    return notidate;
  }

  showDateDialog(BuildContext context, Date1 date, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(date.date_title),
        content: Text(
            "ID ${date.date_id} \nDesc: ${date.date_description} \nDate: ${date.date_} \nTime: ${date.time_}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              // Navigator.pushReplacementNamed(context, AddTaskScreen.route) ;
              // print(health.runtimeType);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskScreen(
                      date: date,
                      index:
                          index), //AddHealthTaskScreen(health: health, healthindex: index),
                ),
              );
            },
            child: Text("Update"),
          ),
          FlatButton(
            onPressed: () {
              DatabaseProvider.db.deleteDate(date.date_id);
              notificationServices.deletedatenotification(date.date_id);
              // Navigator.pushReplacementNamed(context, TaskScreen.route);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, TaskScreen.route);
            },
            child: Text("Delete"),
          ),
          FlatButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      child: FutureBuilder(
        future: DatabaseProvider.db.getDate(),
        builder: (context, AsyncSnapshot<List<Date1>> date) {
          var length = DatabaseProvider.db.getDatelength();
          if (date != null) {
            return ListView.builder(
              itemCount: length ?? 0,
              itemBuilder: (context, index) {
                if (date.data != null) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    // height: size.height*0.1,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(color: Colors.blue),
                      ),
                    ),
                    child: ListTile(
                      onTap: () {
                        showDateDialog(
                            context, date.data.elementAt(index), index);
                      },
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 5.0),
                        child: Text(
                          "${date.data.elementAt(index).date_id}",
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.blue,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 9.0),
                        child: Text("${date.data.elementAt(index).date_title}",
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600)),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5.0),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Text(
                              "${date.data.elementAt(index).date_description}",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: DateTime.now().isAfter(getDateofnoti(
                                          date.data.elementAt(index).date_,
                                          date.data.elementAt(index).time_)) ==
                                      true
                                  ? Text(
                                      "Date: ${date.data.elementAt(index).date_} \nTime: ${date.data.elementAt(index).time_} \nThe Notification Time is expired... \nHence no more notification will be\nshowed for this reminder \nDELETE or UPDATE this reminder",
                                      style: TextStyle(
                                          fontSize: 17, color: Colors.red),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  : Text(
                                      "Date: ${date.data.elementAt(index).date_} \nTime: ${date.data.elementAt(index).time_}",
                                      style: TextStyle(fontSize: 17),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            );
          } else {
            Container();
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
