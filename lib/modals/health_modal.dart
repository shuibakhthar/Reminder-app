import 'package:reminder_app/services/database_provider.dart';

class Health{

  int health_id;
  String medicine_name;
  String medicine_description;
  String mor_time;
  String aft_time;
  String nyt_time;

  Health({
    this.health_id,
    this.medicine_name,
    this.medicine_description,
    this.mor_time,
    this.aft_time,
    this.nyt_time,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      DatabaseProvider.MEDICINE_NAME: medicine_name,
      DatabaseProvider.MEDICINE_DESCRIPTION: medicine_description,
      DatabaseProvider.MOR_TIME: mor_time,
      DatabaseProvider.AFT_TIME: aft_time,
      DatabaseProvider.NYT_TIME: nyt_time
    };

    if(health_id != null){
      map[DatabaseProvider.HEALTH_PRIMARY_ID] = health_id;
    }
    return map;
  }

  Health.fromMap(Map<String, dynamic> map) {
    health_id = map[DatabaseProvider.HEALTH_PRIMARY_ID];
    medicine_name = map[DatabaseProvider.MEDICINE_NAME];
    medicine_description = map[DatabaseProvider.MEDICINE_DESCRIPTION];
    mor_time = map[DatabaseProvider.MOR_TIME];
    aft_time = map[DatabaseProvider.AFT_TIME];
    nyt_time = map[DatabaseProvider.NYT_TIME];
  }

}