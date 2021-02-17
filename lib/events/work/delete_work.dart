import 'package:reminder_app/modals/importAll.dart';

import 'work_event.dart';

class DeleteWork extends WorkEvent{
  int workindex;

  DeleteWork(int index){
    workindex = index;
  }
}