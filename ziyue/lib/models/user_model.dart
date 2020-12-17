import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

// Equatable 这个库会将我们暴露出来的对象进行比较，如果发生了变化，他就会指导bloc进行重构，反之。。。

class UserModel extends Equatable {
  final String name;
  final String pwd;

  UserModel({Key key, @required this.name, @required this.pwd})
      : assert(name != null, pwd != null);

  factory UserModel.init() {
    return UserModel(name: "", pwd: "");
  }

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
