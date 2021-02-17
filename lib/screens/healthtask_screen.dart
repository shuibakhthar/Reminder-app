import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reminder_app/screens/importAll.dart';
import 'package:reminder_app/services/importAll.dart';
import 'package:reminder_app/modals/health_modal.dart';
import 'package:tuple/tuple.dart';

class HealthTaskScreen extends StatefulWidget {
  static String route = "healthtask";

  showdialog1(BuildContext context, Health health, int index) =>
      createState().showHealthDialog(context, health, index);

  @override
  _HealthTaskScreenState createState() => _HealthTaskScreenState();
}

class _HealthTaskScreenState extends State<HealthTaskScreen> {
  @override
  void initState() {
    super.initState();

    // Navigator.pushReplacementNamed(context, HealthTaskScreen.route);
    // health = DatabaseProvider.db.getHealth();
    // DatabaseProvider.db.getHealth().then((healthlist) {
    //   BlocProvider.of<HealthBloc>(context).add(SetHealth(healthlist));
    //   },
  }

  showHealthDialog(BuildContext context, Health health, int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(health.medicine_name),
        content: Text(
            "ID ${health.health_id} \nDesc: ${health.medicine_description} \nMorning Time: ${health.mor_time} \nAfternoon Time: ${health.aft_time} \nNight Time: ${health.nyt_time}"),
        actions: <Widget>[
          FlatButton(
            onPressed: () {
              // Navigator.pushReplacementNamed(context, AddTaskScreen.route) ;
              // print(health.runtimeType);
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTaskScreen(
                    health: health,
                    index: index,
                  ), //AddHealthTaskScreen(health: health, healthindex: index),
                ),
              );
            },
            child: Text("Update"),
          ),
          FlatButton(
            onPressed: () {
              // print(health.health_id);
              DatabaseProvider.db.deleteHealth(health.health_id);
              notificationServices.deletehealthnotification(health.health_id);

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
        //stream: DatabaseProvider.db.getHealth(),
        future: DatabaseProvider.db.getHealth(),
        builder: (context, AsyncSnapshot<List<Health>> health) {
          var length = DatabaseProvider.db.getHealthlength();
          if (health != null) {
            return ListView.builder(
              itemCount: length ?? 0,
              itemBuilder: (context, index) {
                if (health.data != null) {
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
                        showHealthDialog(
                            context, health.data.elementAt(index), index);
                      },
                      leading: Padding(
                        padding: const EdgeInsets.only(left: 5),
                        child: Text(
                          "${health.data.elementAt(index).health_id}",
                          style: TextStyle(
                              fontSize: 23,
                              color: Colors.blue,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top: 9),
                        child: Text(
                            "${health.data.elementAt(index).medicine_name}",
                            style: TextStyle(
                                fontSize: 23,
                                color: Colors.blue,
                                fontWeight: FontWeight.w600)),
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 5),
                        child: ListView(
                          shrinkWrap: true,
                          children: [
                            Text(
                              "${health.data.elementAt(index).medicine_description}",
                              style: TextStyle(
                                  fontSize: 20, color: Colors.black87),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                "MOR: ${health.data.elementAt(index).mor_time} \nAFT: ${health.data.elementAt(index).aft_time}\nNYT: ${health.data.elementAt(index).nyt_time}",
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
            return Container();
          }
          // return Center(child: CircularProgressIndicator(),);
        },
      ),
    );
  }
}
