part of 'main_screen_cubit.dart';


abstract class MainScreenState {}

class MainScreenInitial extends MainScreenState {}


class ChangedNavBar extends MainScreenState {
  int counter;
  ChangedNavBar(this.counter);
}
