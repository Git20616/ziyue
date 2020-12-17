import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ziyue/globals/app_themes.dart';

abstract class ThemeEvent extends Equatable {
  const ThemeEvent();

  @override
  List<Object> get props => [];
}

class ThemeChangedEvent extends ThemeEvent {
  final AppTheme theme;

  ThemeChangedEvent({@required this.theme});

  @override
  List<Object> get props => [theme];
}