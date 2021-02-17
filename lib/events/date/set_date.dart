import 'package:reminder_app/modals/date_modal.dart';
import 'date_event.dart';

class SetDate extends DateEvent{
  List<Date1> datelist;

  SetDate(List<Date1> dates) {
    datelist = dates;
  }
}