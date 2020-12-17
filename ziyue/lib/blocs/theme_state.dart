import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ziyue/globals/app_themes.dart';

abstract class ThemeState extends Equatable {

  const ThemeState();

  @override
  List<Object> get props => [];
}

class ThemeInitialState extends ThemeState {
  final ThemeData themeData = appThemeData[AppTheme.BlueLight];

  @override
  List<Object> get props => [themeData];
}

class ThemeChangedState extends ThemeState {
  final ThemeData themeData;

  ThemeChangedState({@required this.themeData});

  @override
  List<Object> get props => [themeData];
}