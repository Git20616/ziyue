import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziyue/blocs/login_bloc.dart';
import 'package:ziyue/blocs/login_state.dart';
import 'package:ziyue/blocs/theme_state.dart';
import 'package:ziyue/routes/login_page.dart';

import 'blocs/theme_bloc.dart';
import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget{
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeBloc>(create: (context) => ThemeBloc(ThemeInitialState())),
        BlocProvider<LoginBloc>(create: (context) => LoginBloc(LoginInitialState())),
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          ThemeData _theme;
          if (state is ThemeInitialState) {
            _theme = state.themeData;
          } else if (state is ThemeChangedState) {
            _theme = state.themeData;
          }
          return MaterialApp(
            title: "Flutter Ziyue",
            theme: _theme,
            home: LoginPage(),
          );
        },
      ),
    );
  }
}
