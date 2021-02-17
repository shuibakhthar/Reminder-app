import 'package:flutter/material.dart';
import 'package:reminder_app/services/importAll.dart';
import 'package:reminder_app/screens/importAll.dart';
import 'package:reminder_app/modals/importAll.dart';

class WorkTaskScreen extends StatefulWidget {
  static String route = "worktask";

  showdialog1(BuildContext context, Work work, int index) =>
      createState().showWorkDialog(context, work, index);

  @override
  _WorkTaskScreenState createState() => _WorkTaskScreenState();
}

class _WorkTaskScreenState extends State<WorkTaskScreen> {
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

  showWorkDialog(BuildContext context, Work work, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(work.work_title),
        content: Text(
            "ID ${work.work_id} \nDesc: ${work.work_description} \nStart Date: ${work.str_date} \nStart Time: ${work.str_time} \nStop Date: ${work.stp_date} \nStop Time: ${work.stp_time} \nRemind Till End: ${work.isStop} "),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              // Navigator.pushReplacementNamed(context, AddTaskScreen.route) ;
              // print(health.runtimeType);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskScreen(
                      work: work,
                      index:
                          index), //AddHealthTaskScreen(health: health, healthindex: index),
                ),
              );
            },
            child: Text("Update"),
          ),
          FlatButton(
            onPressed: () {
              DatabaseProvider.db.deleteWork(work.work_id);
              notificationServices.deleteworknotification(work.work_id);
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
        // stream: DatabaseProvider.db.getHealth(),
        future: DatabaseProvider.db.getWork(),
        builder: (context, AsyncSnapshot<List<Work>> work) {
          var length = DatabaseProvider.db.getWorklength();
          if (work != null) {
            return ListView.builder(
              itemCount: length ?? 0,
              itemBuilder: (context, index) {
                if (work.data != null) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    // height: size.height*0.2,
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        side: BorderSide(color: Colors.blue),
                      ),
                    ),
                    child: ListTile(
                        onTap: () {
                          showWorkDialog(
                              context, work.data.elementAt(index), index);
                        },
                        leading: Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            "${work.data.elementAt(index).work_id}",
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                        title: Padding(
                          padding: const EdgeInsets.only(top: 9.0),
                          child: Text(
                              "${work.data.elementAt(index).work_title}",
                              style: TextStyle(
                                  fontSize: 23,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w600)),
                        ),
                        subtitle: (work.data.elementAt(index).isStop == true)
                            ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: ListView(
                                  shrinkWrap: true,
                                  children: [
                                    Text(
                                      "${work.data.elementAt(index).work_description} ",
                                      style: TextStyle(
                                          fontSize: 20, color: Colors.black87),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      "\nStart Date: ${work.data.elementAt(index).str_date.split(" ")[0]} \nStart Time: ${work.data.elementAt(index).str_time} \nStop Date: ${work.data.elementAt(index).stp_date.split(" ")[0]} \nStop Time: ${work.data.elementAt(index).stp_time}",
                                      style: TextStyle(fontSize: 17),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ))
                            : Padding(
                                padding: EdgeInsets.symmetric(vertical: 5),
                                child: DateTime.now().isAfter(getDateofnoti(
                                            work.data.elementAt(index).str_date,
                                            work.data
                                                .elementAt(index)
                                                .str_time)) ==
                                        true
                                    ? ListView(
                                        shrinkWrap: true,
                                        children: [
                                          Text(
                                            "${work.data.elementAt(index).work_description} ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black87),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "\nStart Date: ${work.data.elementAt(index).str_date.split(" ")[0]} \nStart Time: ${work.data.elementAt(index).str_time} \nThe Notification Time is expired... \nHence no more notification will be\nshowed for this reminder \nDELETE or UPDATE this reminder",
                                            style: TextStyle(
                                                fontSize: 17,
                                                color: Colors.red),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      )
                                    : ListView(
                                        shrinkWrap: true,
                                        children: [
                                          Text(
                                            "${work.data.elementAt(index).work_description} ",
                                            style: TextStyle(
                                                fontSize: 20,
                                                color: Colors.black87),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            "\nStart Date: ${work.data.elementAt(index).str_date.split(" ")[0]} \nStart Time: ${work.data.elementAt(index).str_time}",
                                            style: TextStyle(fontSize: 17),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ))),
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
