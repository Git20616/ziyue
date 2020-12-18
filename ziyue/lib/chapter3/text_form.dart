import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class TextAndFormTest extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TextAndFormTestState();
  }
}

class TextAndFormTestState extends State<TextAndFormTest> {
  String _uname;
  String _pword;
  Color _underlineColor = Colors.grey[400];
  // 获取输入内容 ②
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwordController = TextEditingController();
  TextEditingController _selectionController = TextEditingController();
  // 焦点控制
  // 默认情况下，焦点由FocusScope来管理，它代表焦点控制范围
  // 可以在这个范围内可以通过FocusScopeNode在输入框之间移动焦点、设置默认焦点等
  // 通过FocusScope.of(context) 来获取Widget树中默认的FocusScopeNode
  FocusNode _focusNode1 = new FocusNode();
  FocusNode _focusNode2 = new FocusNode();
  FocusNode _focusNode3 = new FocusNode();
  FocusScopeNode _focusScopeNode;
  // FormState为Form的State类，可以通过Form.of()或GlobalKey获得。
  GlobalKey _formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // 监听文本变化 ②
    _pwordController.addListener(() {
      print("onchange: ${_pwordController.text}");
    });
    _unameController.addListener(() {
      print(_unameController.text);
    });
    // 监听焦点状态改变
    _focusNode1.addListener(() {
      print("_focusNode1: ${_focusNode1.hasFocus}");
    });
    _focusNode2.addListener(() {
      print("_focusNode2: ${_focusNode2.hasFocus}");
    });
    _focusNode3.addListener(() {
      setState(() {
        _underlineColor = _focusNode3.hasFocus ? Colors.blue : Colors.grey[400];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // 设置文本默认值
    _selectionController.text = "hello world!";
    // 选择文本
    _selectionController.selection = TextSelection(
      baseOffset: 2,
      extentOffset: _selectionController.text.length,
    );

    // TODO: implement build
    return Theme(
      data: ThemeData(
        fontFamily: "peony",
        // TextField在绘制提示文本时使用主题色里的hintColor
        // 不过，TextField的decoration中可以设置hintStyle，可覆盖hintColor
        // 以实际情况为准
        hintColor: Color(0xFF41D992),
        // Theme中可以通过inputDecorationTheme来设置输入框默认的decoration
        inputDecorationTheme: InputDecorationTheme(
//          labelStyle: TextStyle(color: Color(0xFFEA3323)), //定义label字体样式
          hintStyle: TextStyle(color: Color(0xFFFC7603)), //定义提示文本字体样式
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text("输入框与表单"),
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(8),
          child: Column(
            children: <Widget>[
              TextField(
                autofocus: false,
                decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "用户名或邮箱",
                  prefixIcon: Icon(Icons.person),
                ),
                onChanged: (v) {
                  // 监听文本变化
                  print("onchange: $v");
                },
                controller: _unameController,
              ),
              TextField(
                controller: _pwordController,
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "您的登录密码",
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              TextField(
                controller: _selectionController,
              ),
              TextField(
                autofocus: true,
                focusNode: _focusNode1,
                decoration: InputDecoration(
                  labelText: "输入框1",
                ),
              ),
              TextField(
                autofocus: false,
                focusNode: _focusNode2,
                decoration: InputDecoration(
                  labelText: "输入框2",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  RaisedButton(
                    child: Text("移动焦点"),
                    onPressed: () {
                      // 这是一种写法 FocusScope.of(context).requestFocus(focusNode2);
                      // 第二种写法
                      if (null == _focusScopeNode) {
                        _focusScopeNode = FocusScope.of(context);
                      }
                      _focusScopeNode.requestFocus(_focusNode2);
                    },
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                  RaisedButton(
                    child: Text("隐藏键盘"),
                    onPressed: () {
                      // 当所有输入框都失去焦点时，键盘就会收起
                      _focusNode1.unfocus();
                      _focusNode2.unfocus();
                    },
                    color: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ],
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: "自定义输入框",
                  hintText: "提示文字",
                  prefixIcon: Icon(Icons.pets),
                  // 未获得焦点时，下划线设置为橙色
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange),
                  ),
                  // 获得焦点时，下划线设置为绿色
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.green),
                  ),
                  // 如何在不使用enabledBorder和focusedBorder的情况下来自定义下滑线颜色呢？
                  // 答案在Theme中↑↑
                ),
              ),
              // 可以隐藏掉TextField本身的下划线，然后通过Container去嵌套定义样式
              Container(
                child: TextField(
                  focusNode: _focusNode3,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "电子邮件地址",
                    prefixIcon: Icon(Icons.email),
                    border: InputBorder.none, //隐藏下划线
                  ),
                ),
                decoration: BoxDecoration(
                  // 下划线浅灰色，宽度1像素
//                border: Border(bottom: BorderSide(color: Colors.grey[200], width: 1.0)),
                  // 定义圆角框
                  border: Border.all(color: _underlineColor, width: 1.0),
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                ),
                margin: EdgeInsets.all(5.0),
              ),
              // TODO Form
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
                child: Form(
                  key: _formKey, //设置GlobalKey，用于后面获取FormState
                  autovalidate: false, //是否开启自动校验
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        autofocus: false,
                        onSaved: (v) {
                          _uname = v;
                        },
                        decoration: InputDecoration(
                          labelText: "用户名",
                          hintText: "用户名或邮箱",
                          icon: Icon(Icons.person),
                        ),
                        // 校验用户名
                        validator: (v) {
                          return v.trim().length > 0 ? null : "用户名不能为空";
                        },
                      ),
                      TextFormField(
                        obscureText: true,
                        onSaved: (v) {
                          _pword = v;
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
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: RaisedButton(
                              padding: EdgeInsets.all(15.0),
                              child: Text("登录"),
                              color: Theme.of(context).primaryColor,
                              textColor: Colors.white,
                              onPressed: () {
                                // 这里不能通过Form.of(context)获取FormState
                                // 原因是，此处的context为TextAndFormTest的context，
                                // 而Form.of(context)是根据所指定context向根去查找，
                                // 而FormState是在FormTestRoute的子树中，所以不行。
                                // 正确的做法是通过Builder来构建登录按钮，Builder会将widget节点的context作为回调参数
//                              print(Form.of(context)); //null

                                // 但是，这里可以通过_formKey.currentState 获取FormState
                                FormState _state =
                                _formKey.currentState as FormState;
                                if (_state.validate()) {
                                  // 验证通过，提交数据
                                  _state.save();
                                  print("u: $_uname, p: $_pword");
                                }
                              },
                            ),
                          ),
                          Expanded(
                            // 通过Builder来获取RaisedButton所在widget树的真正context(Element)
                            child: Builder(
                              builder: (context) {
                                return RaisedButton(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text("登录二"),
                                  onPressed: () {
                                    if (Form.of(context).validate()) {}
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
