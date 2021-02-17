import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reminder_app/screens/importAll.dart';
import 'package:reminder_app/modals/importAll.dart';
import 'package:reminder_app/services/importAll.dart';

class TaskScreen extends StatefulWidget {
  static String route = "task";

  String screen;
  int primkey;

  TaskScreen({this.screen, this.primkey});

  @override
  _TaskScreenState createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> with TickerProviderStateMixin {
  BuildContext context1;
  TabController controller;

  @override
  void initState() {
    super.initState();
    if (widget.screen == "health") {
      print("1");
      healthnoti();
    } else if (widget.screen == "work") {
      print("2");
      worknoti();
    } else if (widget.screen == "date") {
      print("3");
      datenoti();
    } else {
      print("4");
      controller = new TabController(length: 3, vsync: this);
    }
  }

  healthnoti() async {
    try {
      Health health = await DatabaseProvider.db.selectHealth(widget.primkey);
      controller = new TabController(initialIndex: 0, length: 3, vsync: this);
      HealthTaskScreen().showdialog1(context, health, widget.primkey);
    } catch (e) {
      print(e);
    }
  }

  worknoti() async {
    try {
      Work work = await DatabaseProvider.db.selectWork(widget.primkey);
      controller = new TabController(initialIndex: 1, length: 3, vsync: this);
      WorkTaskScreen().showdialog1(context, work, widget.primkey);
    } catch (e) {
      print(e);
    }
  }

  datenoti() async {
    try {
      Date1 date = await DatabaseProvider.db.selectDate(widget.primkey);
      controller = new TabController(initialIndex: 2, length: 3, vsync: this);
      DateTaskScreen().showdialog1(context, date, widget.primkey);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(icon: Image.asset("assets/images/logo.png")),
          title: Text(
            "Reminder",
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.italic,
            ),
          ),
          backgroundColor: Colors.blue,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                  child: Icon(
                    Icons.refresh,
                    size: 28,
                  ),
                  onTap: () {
                    Navigator.pushReplacementNamed(context, TaskScreen.route);
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: PopupMenuButton<String>(
                icon: Icon(
                  Icons.more_vert,
                  size: 28,
                ),
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    child: Text("About us"),
                  ),
                ],
              ),
            ),
          ],
          bottom: TabBar(controller: controller, tabs: <Tab>[
            new Tab(
              child: Row(
                children: [
                  Icon(
                    Icons.local_hospital,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    "Health",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            new Tab(
              child: Row(
                children: [
                  Icon(
                    Icons.work,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Work",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
            new Tab(
              child: Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Dates",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ]),
        ),
        body: TabBarView(
          controller: controller,
          children: [
            // BlocProvider.value(
            //   value: context.bloc<HealthBloc>(),
            //   child: HealthTaskScreen(),
            // ) ,
            HealthTaskScreen(),
            WorkTaskScreen(),
            DateTaskScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            // Navigator.pushNamed(context, AddTaskScreen.route);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(
                  TabControl: controller.index,
                ), //AddHealthTaskScreen(health: health, healthindex: index),
              ),
            );
          },
          label: Text(
            "Add",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontSize: 20,
            ),
          ),
          icon: Icon(
            Icons.add_circle,
            size: 25,
          ),
        ),
      ),
    );
  }
}
// bottomNavigationBar: BottomNavigationBar(
//     items: const <BottomNavigationBarItem>[
//       BottomNavigationBarItem(
//         icon: Icon(Icons.home),
//         title: Text('Home'),
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.arrow_back),
//         title: Text('Back'),
//       ),
//     ],
// ),
