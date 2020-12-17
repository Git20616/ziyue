// login_repository是我们的数据层
// login_repositor是与网络交互的数据层，这里我是模拟了一下过程。

import 'package:ziyue/models/user_model.dart';

class LoginRepository {
  static Future login(String name, String pwd) async {
    if(name.length >= 6 && pwd.length >= 6) {
      await Future.delayed(const Duration(seconds: 2));
      return UserModel(name: name, pwd: pwd);
    } else {
      throw Exception("登录失败，请检查账号密码");
    }
  }
}