import 'dart:convert';

import 'package:ziyue/chapter11/simple_user.dart';

void jsonToModel() {
  //一个JSON格式的用户列表字符串
  String jsonStr = '[{"name":"Jack"},{"name":"Rose"}]';
  //将JSON字符串转为Dart对象(此处是List)
  List items = json.decode(jsonStr);
  print("${items[0]["name"]}");

  String jsonStr2 = '{"name":"John Smith","email":"John@example.com"}';
  Map<String, dynamic> user = json.decode(jsonStr2);
  print('Howdy, ${user['name']}!');
  print('We sent the verification link to ${user['email']}.');

  // 使用模板类
  Map userMap = json.decode(jsonStr2);
  SimpleUser sUser = SimpleUser.fromJson(userMap);
  print("Howdy, ${sUser.name}, I will send greeting card to ${sUser.email}");
}
