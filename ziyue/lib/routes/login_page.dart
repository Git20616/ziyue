import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ziyue/blocs/login_bloc.dart';
import 'package:ziyue/blocs/login_event.dart';
import 'package:ziyue/blocs/login_state.dart';
import 'package:ziyue/home_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _name = "";
  String _pwd = "";
  final GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginInitialState) {
            return Container(
              height: 300,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      nameTF(),
                      pwdTF(),
                      Row(
                        children: [
                          Expanded(child: loginBtn(context)),
                          Expanded(child: registerBtn()),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          if (state is LoginProgressState) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LoginSuccessState) {
            return SuccessDialog();
          }
          if (state is LoginFailureState) {
            final currentState = state;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    currentState.errMsg,
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  RaisedButton(
                    onPressed: () {
                      setState(() {
                        BlocProvider.of<LoginBloc>(context)
                            .add(LoginInitialEvent());
                      });
                    },
                    color: Theme.of(context).accentColor,
                    child: Text(
                      '返回登陆',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }

  Widget nameTF() {
    return TextFormField(
      autofocus: true,
      decoration: InputDecoration(
        labelText: "用户名",
        hintText: "用户名或邮箱",
        icon: Icon(Icons.person),
      ),
      onSaved: (v) {
        _name = v;
      },
      // 校验用户名
      validator: (v) {
        return v.trim().length > 0 ? null : "用户名不能为空";
      },
    );
  }

  Widget pwdTF() {
    return TextFormField(
      obscureText: true,
      onSaved: (v) {
        _pwd = v;
      },
      decoration: InputDecoration(
        labelText: "密码",
        hintText: "您的登陆密码",
        icon: Icon(Icons.lock),
      ),
      // 校验密码
      validator: (v) {
        return v.trim().length > 5 ? null : "密码不能少于6位";
      },
    );
  }

  Widget loginBtn(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.all(15.0),
      child: Text("登录"),
      color: Theme.of(context).primaryColor,
      textColor: Colors.white,
      onPressed: () {
        FormState _state = _formKey.currentState as FormState;
        if (_state.validate()) {
          _state.save();
          BlocProvider.of<LoginBloc>(context).add(LoginPressEvent(_name, _pwd));
        }
      },
    );
  }

  Widget registerBtn() {
    return RaisedButton(
      padding: EdgeInsets.all(15.0),
      child: Text("注册"),
      onPressed: () {},
    );
  }
}

class SuccessDialog extends StatefulWidget {
  @override
  _SuccessDialogState createState() => _SuccessDialogState();
}

class _SuccessDialogState extends State<SuccessDialog> {
  Future<void> waitFuture() async {
    await Future.delayed(const Duration(milliseconds: 500));
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => MyHomePage()));
  }

  @override
  void initState() {
    super.initState();
    waitFuture();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "登陆成功",
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          RaisedButton(
            onPressed: () {
              setState(() {
                BlocProvider.of<LoginBloc>(context).add(LoginInitialEvent());
              });
            },
            color: Theme.of(context).accentColor,
            child: Text(
              '返回登陆',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
