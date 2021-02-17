import 'package:reminder_app/modals/work_modal.dart';
import 'work_event.dart';

class SetWork extends WorkEvent{
  List<Work> worklist;

  SetWork(List<Work> works) {
    worklist = works;
  }
}