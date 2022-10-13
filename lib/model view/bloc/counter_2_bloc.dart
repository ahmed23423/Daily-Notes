import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'counter_2_event.dart';
part 'counter_2_state.dart';

class Counter_2Bloc extends Bloc<Counter_2Event, Counter_2State> {
  Counter_2Bloc() : super(Counter_2Initial()) {
    on<Counter_2Event>((event, emit) {
      // TODO: implement event handler
    });
  }
}
