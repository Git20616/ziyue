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
  final nameCtrl = new TextEditingController();
  final pwdCtrl = new TextEditingController();

  @override
  void initState() {
    super.initState();
    nameCtrl.addListener(() {
      print("${nameCtrl.text}");
    });
    pwdCtrl.addListener(() {
      print("${pwdCtrl.text}");
    });
  }

  @override
  void dispose() {
    super.dispose();
    // TODO 养成好习惯
    nameCtrl?.removeListener(() {});
    nameCtrl?.dispose();
    pwdCtrl?.removeListener(() {});
    pwdCtrl?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录"),
      ),
      body: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          if (state is LoginInitialState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                nameTF(),
                pwdTF(),
                loginBtn(context, () {
                  BlocProvider.of<LoginBloc>(context).add(LoginPressEvent(
                      nameCtrl.text.trim(), pwdCtrl.text.trim()));
                }),
              ],
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
          return Container();
        },
      ),
    );
  }

  Widget nameTF() {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 50),
      width: double.infinity,
      child: TextField(
        controller: nameCtrl,
        decoration: InputDecoration(
          fillColor: Color(0x30cccccc),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x00FF0000)),
              borderRadius: BorderRadius.circular(100)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x00FF0000)),
              borderRadius: BorderRadius.circular(100)),
          hintText: "请输入用户名",
        ),
      ),
    );
  }

  Widget pwdTF() {
    return Container(
      height: 60,
      margin: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      width: double.infinity,
      child: TextField(
        controller: pwdCtrl,
        decoration: InputDecoration(
          fillColor: Color(0x30cccccc),
          filled: true,
          enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x00FF0000)),
              borderRadius: BorderRadius.circular(100)),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Color(0x00FF0000)),
              borderRadius: BorderRadius.circular(100)),
          hintText: '请输入密码',
        ),
        obscureText: true,
      ),
    );
  }

  Widget loginBtn(BuildContext context, void Function() onPressed) {
    return Container(
      height: 50,
      margin: EdgeInsets.symmetric(horizontal: 50),
      width: double.infinity,
      child: RaisedButton(
        child: Text(
          '登录',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
        color: Theme.of(context).accentColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        onPressed: onPressed,
      ),
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
