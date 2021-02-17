import 'package:flutter/material.dart';
import 'package:reminder_app/screens/importAll.dart';
import 'database_provider.dart';
import 'package:reminder_app/modals/importAll.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'dart:io' show Platform;
import 'package:rxdart/subjects.dart';

// class NotificationServices extends StatefulWidget {
//
//   initState1() => createState().initState();
//
//   // showHealthNotification1() => createState().showHealthNotification();
//
//   @override
//   _NotificationServicesState createState() => _NotificationServicesState();
// }

class NotificationServices {
  var initializationSettings;
  int healthnotiid = 1000;
  int worknotiid = 2000;
  int datenotiid = 3000;

  BehaviorSubject<RecieveNotification> get didRecieveLocalNotificationSubject =>
      BehaviorSubject<RecieveNotification>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  NotificationServices.init() {
    try {
      if (Platform.isIOS) {
        requestIOSPermission();
      }
      initializePlatform();
    } catch (e) {
      print(e);
    }

    pendingnotification();

    // deleteallnotifications();
  }

  requestIOSPermission() {
    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        .requestPermissions(alert: true, badge: true, sound: true);
  }

  initializePlatform() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('mipmap/ic_launcher');
    var initializationSettingsIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          RecieveNotification notification = RecieveNotification(
              id: id, title: title, body: body, payload: payload);
          didRecieveLocalNotificationSubject.add(notification);
        });
    initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);
  }

  setOnNotificationRecieve(Function onNotificationRecieve) {
    didRecieveLocalNotificationSubject.listen((notification) {
      onNotificationRecieve(notification);
    });
  }

  setOnNotificationClick(Function onNotificationClick) async {
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
      onNotificationClick(payload);
    });
  }

  Future<void> showHealthNotficaiton(Health health) async {
    var androidChannel = new AndroidNotificationDetails(
        'channel id', 'channel NAME', 'CHANNEL DESCRIPTION',
        priority: Priority.High, importance: Importance.Max, playSound: true);
    var iosChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(androidChannel, iosChannel);
    await flutterLocalNotificationsPlugin.show(
        DatabaseProvider.health_primary_key,
        health.medicine_name,
        health.medicine_description,
        platformChannel,
        payload: 'health');
  }

  Future<void> repeatHealthNotficaiton(int id, Health health, TimeOfDay time1,
      TimeOfDay time2, TimeOfDay time3) async {
    // if (id == null) {
    //   id = 1;
    // }
    print("inside add noti ${id}");
    // print(DatabaseProvider.health_primary_key);
    if (time1 != " ") {
      var time11 = Time(time1.hour, time1.minute, 0);
      try {
        var androidChannelmor = new AndroidNotificationDetails(
            'channel id 1', 'channel NAME 1', 'CHANNEL DESCRIPTION 1',
            priority: Priority.High,
            importance: Importance.Max,
            playSound: true);
        var iosChannelmor = IOSNotificationDetails();
        var platformChannelmor =
            NotificationDetails(androidChannelmor, iosChannelmor);
        await flutterLocalNotificationsPlugin.showDailyAtTime(
            healthnotiid + id,
            health.medicine_name,
            health.medicine_description,
            time11,
            platformChannelmor,
            payload: 'health_mor');
      } catch (e) {
        print("mor ${e}");
      }
    }

    if (time2 != " ") {
      var time22 = Time(time2.hour, time2.minute, 0);
      try {
        var androidChannelnoon = new AndroidNotificationDetails(
            'channel id 2', 'channel NAME 2', 'CHANNEL DESCRIPTION 2',
            priority: Priority.High,
            importance: Importance.Max,
            playSound: true);
        var iosChannelnoon = IOSNotificationDetails();
        var platformChannelnoon =
            NotificationDetails(androidChannelnoon, iosChannelnoon);
        await flutterLocalNotificationsPlugin.showDailyAtTime(
            healthnotiid + id,
            health.medicine_name,
            health.medicine_description,
            time22,
            platformChannelnoon,
            payload: 'health_noon');
      } catch (e) {
        print("noon ${e}");
      }
    }

    if (time3 == " ") {
      var time33 = Time(time3.hour, time3.minute, 0);
      try {
        var androidChannelnyt = new AndroidNotificationDetails(
            'channel id 3', 'channel NAME 3', 'CHANNEL DESCRIPTION 3',
            priority: Priority.High,
            importance: Importance.Max,
            playSound: true);
        var iosChannelnyt = IOSNotificationDetails();
        var platformChannelnyt =
            NotificationDetails(androidChannelnyt, iosChannelnyt);
        await flutterLocalNotificationsPlugin.showDailyAtTime(
            healthnotiid + id,
            health.medicine_name,
            health.medicine_description,
            time33,
            platformChannelnyt,
            payload: 'health_night');
      } catch (e) {
        print("nyt ${e}");
      }
    }
  }

  Future deletehealthnotification(int id) async {
    var id1 = healthnotiid + id;
    print(id1);
    try {
      await flutterLocalNotificationsPlugin.cancel(id1);
      await flutterLocalNotificationsPlugin.cancel(id1);
      await flutterLocalNotificationsPlugin.cancel(id1);
    } catch (e) {
      print("health delete noti inside ${e}");
    }
  }

  Future<void> scheduleworknotification(int id, Work work, DateTime datetime1,
      TimeOfDay time1, DateTime datetime2, TimeOfDay time2) async {
    var scheduledatetime =
        datetime1.add(Duration(hours: time1.hour, minutes: time1.minute));
    var androidChannel = new AndroidNotificationDetails(
        'channel id 31', 'channel NAME 31', 'CHANNEL DESCRIPTION 31',
        priority: Priority.High, importance: Importance.Max, playSound: true);
    var iosChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(androidChannel, iosChannel);
    await flutterLocalNotificationsPlugin.schedule(
        worknotiid + id,
        work.work_title,
        work.work_description,
        scheduledatetime,
        platformChannel,
        payload: 'work');
  }

  Future deleteworknotification(int id) async {
    var id2 = worknotiid + id;
    print(id2);
    try {
      await flutterLocalNotificationsPlugin.cancel(id2);
      await flutterLocalNotificationsPlugin.cancel(id2);
      await flutterLocalNotificationsPlugin.cancel(id2);
    } catch (e) {
      print("work delete noti inside ${e}");
    }
  }

  Future<void> scheduledatenotification(
      int id, Date1 date, DateTime datetime, TimeOfDay time) async {
    var scheduledatetime =
        datetime.add(Duration(hours: time.hour, minutes: time.minute));
    var androidChannel = new AndroidNotificationDetails(
        'channel id 31', 'channel NAME 31', 'CHANNEL DESCRIPTION 31',
        priority: Priority.High, importance: Importance.Max, playSound: true);
    var iosChannel = IOSNotificationDetails();
    var platformChannel = NotificationDetails(androidChannel, iosChannel);
    await flutterLocalNotificationsPlugin.schedule(
        datenotiid + id,
        date.date_title,
        date.date_description,
        scheduledatetime,
        platformChannel,
        payload: 'date');
  }

  Future deletedatenotification(int id) async {
    var id3 = datenotiid + id;
    print(id3);
    try {
      await flutterLocalNotificationsPlugin.cancel(id3);
      await flutterLocalNotificationsPlugin.cancel(id3);
      await flutterLocalNotificationsPlugin.cancel(id3);
    } catch (e) {
      print("date delete noti inside ${e}");
    }
  }

  Future deleteallnotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();
  }

  Future pendingnotification() async {
    final List<PendingNotificationRequest> pendingNotificationRequests =
        await flutterLocalNotificationsPlugin.pendingNotificationRequests();
    print(pendingNotificationRequests);
    for (PendingNotificationRequest pnrs in pendingNotificationRequests) {
      print(pnrs.id);
      print(pnrs.title);
      print(pnrs.body);
      print(pnrs.payload);
    }
  }
}

NotificationServices notificationServices = NotificationServices.init();

class RecieveNotification {
  final int id;
  final String title;
  final String body;
  final String payload;
  RecieveNotification(
      {@required this.id,
      @required this.title,
      @required this.body,
      @required this.payload});
}
