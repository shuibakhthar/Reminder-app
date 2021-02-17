import 'package:reminder_app/modals/work_modal.dart';
import 'work_event.dart';

class AddHealth extends WorkEvent{

  Work newWork;

  AddHealth(Work work) {
    newWork = work;
  }

}