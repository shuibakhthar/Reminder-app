import 'package:reminder_app/modals/health_modal.dart';
import 'health_event.dart';

class UpdateHealth extends HealthEvent {

  Health newHealth;
  int healthIndex;

  UpdateHealth(int index, Health health){
    newHealth = health;
    healthIndex = index;
  }
}