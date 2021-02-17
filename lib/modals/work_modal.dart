import 'package:reminder_app/services/database_provider.dart';

class Work{

  int work_id;
  String work_title;
  String work_description;
  String str_date;
  String str_time;
  String stp_date;
  String stp_time;
  bool isStop;

  Work({
    this.work_id,
    this.work_title,
    this.work_description,
    this.str_date,
    this.str_time,
    this.stp_date,
    this.stp_time,
    this.isStop,
  });

  Map<String, dynamic> toMap(){
   var map = <String, dynamic> {
     DatabaseProvider.WORK_TITLE : work_title,
     DatabaseProvider.WORK_DESCRIPTION : work_description,
     DatabaseProvider.STR_DATE : str_date,
     DatabaseProvider.STR_TIME : str_time,
     DatabaseProvider.STP_DATE : stp_date,
     DatabaseProvider.STP_TIME : stp_time,
     DatabaseProvider.IS_STOP : isStop ? 1 : 0,
   };

   if(work_id != null){
     map[DatabaseProvider.WORK_PRIMARY_ID] = work_id;
   }

   return map;
  }

  Work.fromMap(Map<String, dynamic> map) {
    work_id = map[DatabaseProvider.WORK_PRIMARY_ID];
    work_title = map[DatabaseProvider.WORK_TITLE];
    work_description = map[DatabaseProvider.WORK_DESCRIPTION];
    isStop = map[DatabaseProvider.IS_STOP] == 1;
    str_date = map[DatabaseProvider.STR_DATE];
    str_time = map[DatabaseProvider.STR_TIME];
    stp_date = map[DatabaseProvider.STP_DATE];
    stp_time = map[DatabaseProvider.STP_TIME];
  }

}