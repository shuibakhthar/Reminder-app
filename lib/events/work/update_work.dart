import 'package:reminder_app/modals/work_modal.dart';
import 'work_event.dart';

class UpdateWork extends WorkEvent {

  Work newWork;
  int workindex;

  UpdateWork(int index, Work work){
    newWork = work;
    workindex = index;
  }
}