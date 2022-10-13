import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  CounterCubit() : super(CounterInitial());

  int counter = 0;
  int counter2 = 0;

  int incress() {
    counter++;
    emit(IncressCounter(counter));
    return counter;
  }

  int decress() {
    counter--;
    emit(DecressCounter(counter));
    return counter;
  }
}
