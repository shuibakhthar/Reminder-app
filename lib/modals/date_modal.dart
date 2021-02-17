import 'package:reminder_app/services/database_provider.dart';

class Date1 {
  int date_id;
  String date_title;
  String date_description;
  String date_;
  String time_;

  Date1({
    this.date_id,
    this.date_title,
    this.date_description,
    this.date_,
    this.time_,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.DATE_TITLE: date_title,
      DatabaseProvider.DATE_DESCRIPTION: date_description,
      DatabaseProvider.DATE_: date_,
      DatabaseProvider.TIME_: time_,
    };

    if (date_id != null) {
      map[DatabaseProvider.DATE_PRIMARY_ID] = date_id;
    }
    return map;
  }

  Date1.fromMap(Map<String, dynamic> map) {
    date_id = map[DatabaseProvider.DATE_PRIMARY_ID];
    date_title = map[DatabaseProvider.DATE_TITLE];
    date_description = map[DatabaseProvider.DATE_DESCRIPTION];
    date_ = map[DatabaseProvider.DATE_];
    time_ = map[DatabaseProvider.TIME_];
  }
}
