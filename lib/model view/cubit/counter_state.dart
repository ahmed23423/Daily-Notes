part of 'counter_cubit.dart';

@immutable
abstract class CounterState {}

class CounterInitial extends CounterState {}

class IncressCounter extends CounterState {
  int counter;
  IncressCounter(this.counter);
}

class DecressCounter extends CounterState {
  int counter;
  DecressCounter(this.counter);
}
