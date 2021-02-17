import 'health_event.dart';

class DeleteHealth extends HealthEvent{
  int healthindex;

  DeleteHealth(int index){
    healthindex = index;
  }
}