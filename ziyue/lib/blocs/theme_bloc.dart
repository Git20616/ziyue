import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziyue/blocs/theme_event.dart';
import 'package:ziyue/blocs/theme_state.dart';
import 'package:ziyue/globals/app_themes.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc(ThemeState initialState) : super(initialState);

  @override
  Stream<ThemeState> mapEventToState(ThemeEvent event) async* {
    if(event is ThemeChangedEvent) {
      yield ThemeChangedState(themeData: appThemeData[event.theme]);
    }
  }
  
}