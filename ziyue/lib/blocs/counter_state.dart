part of 'counter_bloc.dart';

abstract class CounterState extends Equatable {
  const CounterState();
}

class CounterInitial extends CounterState {
  @override
  List<Object> get props => [0];
}

class CounterChangeState extends CounterState {
  final int numb;

  CounterChangeState({@required this.numb});

  @override
  List<Object> get props => [numb];
}