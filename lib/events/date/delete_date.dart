import 'date_event.dart';

class DeleteDate extends DateEvent{
  int dateindex;

  DeleteDate(int index){
    dateindex = index;
  }
}