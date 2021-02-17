import 'package:reminder_app/modals/health_modal.dart';
import 'health_event.dart';

class SetHealth extends HealthEvent{
  List<Health> healthlist;

  SetHealth(List<Health> healths) {
    healthlist = healths;
  }
}