part of 'counter_bloc.dart';

abstract class CounterEvent extends Equatable {
  const CounterEvent();

  @override
  List<Object> get props => [];
}
// 开始
class CounterStartedEvent extends CounterEvent {}
// 递增
class CounterIncrementedEvent extends CounterEvent {}
// 递减
class CounterDecrementedEvent extends CounterEvent {}
// 重试
class CounterRetriedEvent extends CounterEvent {}