import 'package:reminder_app/modals/health_modal.dart';
import 'health_event.dart';

class AddHealth extends HealthEvent{

  Health newHealth;

  AddHealth(Health health) {
    newHealth = health;
  }

}