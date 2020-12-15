// login_bloc是我们组装的bloc的用法
// login_bloc组合login_state和login_event

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziyue/bloc/login_event.dart';
import 'package:ziyue/bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    try {

    } catch(e) {
      yield LoginFailureState(e.toString());
    }
  }
  
}