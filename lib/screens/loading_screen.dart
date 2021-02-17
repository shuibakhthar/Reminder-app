import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:reminder_app/screens/importAll.dart';
import 'package:reminder_app/services/importAll.dart';

class LoadingScreen extends StatefulWidget {
  static String route = '/';

  @override
  _LoadingScreen createState() => _LoadingScreen();
}

class _LoadingScreen extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(seconds: 2),
      () async {
        Navigator.pushReplacementNamed(context, TaskScreen.route);
      },
    );

    // String res = "health+2";
    // int temp = int.parse(res.split("+")[1]);
    // print(temp);

    // NotificationServices().initState1();
    // NotificationServices().showHealthNotification1();

    notificationServices.setOnNotificationRecieve(onNotificationRecieve);
    notificationServices.setOnNotificationClick(onNotificationClick);
    // onNotificationClick("health_mor");

    DatabaseProvider.db.database;
    // DatabaseProvider.db.selectHealth(1);
    // DatabaseProvider.db.displayDatabase();
    // DatabaseProvider.db.deleteDatabasefile();
  }

  onNotificationRecieve(RecieveNotification notification) {
    print('Notification Recieved: ${notification.id}');
  }

  onNotificationClick(String payload) {
    var payload1 = payload.split("_");
    print('payload ${payload1[0]}');

    if (payload1[0] == 'health') {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return HealthTaskScreen();
      }));
    }

    if (payload1[0] == 'work') {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return WorkTaskScreen();
      }));
    }

    if (payload1[0] == 'date') {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return DateTaskScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.dark,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: size.width * .50,
                  width: size.width * .50,
                ),
              ),
              SizedBox(height: 10),
              Container(
                child: Text(
                  "Reminder",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
        child: Text(
          "From Shelby Developers",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
