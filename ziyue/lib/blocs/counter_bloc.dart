import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

part 'counter_event.dart';
part 'counter_state.dart';

class CounterBloc extends Bloc<CounterEvent, CounterState> {
  int numb = 0;

  CounterBloc() : super(CounterInitial());

  @override
  Stream<CounterState> mapEventToState(
    CounterEvent event,
  ) async* {
    // TODO: implement mapEventToState
    if(event is CounterIncrementedEvent) {
      ++numb;
      yield CounterChangeState(numb: numb);
    }
    if(event is CounterDecrementedEvent) {
      --numb;
      yield CounterChangeState(numb: numb);
    }
    if(event is CounterRetriedEvent) {
      numb = 0;
      yield CounterChangeState(numb: numb);
    }
  }
}
