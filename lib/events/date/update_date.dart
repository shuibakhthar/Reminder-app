import 'package:reminder_app/modals/date_modal.dart';
import 'date_event.dart';

class UpdateDate extends DateEvent {

  Date1 newDate;
  int dateindex;

  UpdateDate(int index, Date1 date){
    newDate = date;
    dateindex = index;
  }
}