import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziyue/blocs/login_event.dart';
import 'package:ziyue/blocs/login_repository.dart';
import 'package:ziyue/blocs/login_state.dart';
import 'package:ziyue/models/user_model.dart';

// login_bloc是我们组装的bloc的用法
// login_bloc组合login_state和login_event
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialState) : super(initialState);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    try {
      if(event is LoginInitialEvent) {
        yield LoginInitialState();
      }
      if(event is LoginPressEvent) {
        UserModel userModel = UserModel.init();
        yield LoginProgressState();
        final currentEvent = event;
        userModel = await LoginRepository.login(currentEvent.name.trim(), currentEvent.pwd.trim());
        yield LoginSuccessState(userModel);
      }
    } catch(e) {
      yield LoginFailureState(e.toString());
    }
  }
  
}