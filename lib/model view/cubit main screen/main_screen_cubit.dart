import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'main_screen_state.dart';

class MainScreenCubit extends Cubit<MainScreenState> {
  MainScreenCubit() : super(MainScreenInitial());

  int animationCounter = 0; // 0 = Home , 1 = Gatgory , 2 = Favorite

  int changeNavBar({required int targetNumber}) {
    animationCounter = targetNumber;
    emit(ChangedNavBar(animationCounter));
    return targetNumber;
  }
}
