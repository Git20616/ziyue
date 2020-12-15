// login_state是我们每个操作返回的页面state状态
// login_state是记录我们页面的state状态，用它来判断我们页面的显示
import 'package:equatable/equatable.dart';
import 'package:ziyue/model/user_model.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitialState extends LoginState{}

class LoginProgressState extends LoginState{}

class LoginSuccessState extends LoginState{
  final UserModel userModel;

  LoginSuccessState(this.userModel);

  @override
  List<Object> get props => [userModel];
}

class LoginFailureState extends LoginState{
  final String errMsg;

  LoginFailureState(this.errMsg);

  @override
  List<Object> get props => [errMsg];
}