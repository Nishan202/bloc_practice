import 'package:bloc_practice/state_management/counter_event.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CounterBloc extends Bloc<CounterEvent, int>{
  CounterBloc() : super(0){
    on<IncrementEvent>((event, emit){
      emit(state + 1);
    });

    on<DecrementEvent>((event, emit){
      if(state>0){
        emit(state - 1);
      }
    });
  }
}