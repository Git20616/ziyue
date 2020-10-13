import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ziyue/chapter7/dialog_checkbox.dart';

class SomeDialog extends StatelessWidget {
  // 自定义对话框打开动画及遮罩
  Future<T> customDialog<T>({
    @required BuildContext context,
    bool barrierDismissible = true,
    WidgetBuilder builder,
  }) {
    final ThemeData themeData = Theme.of(context, shadowThemeOnly: true);
    // showDialog方法是showGeneralDialog方法的封装
    return showGeneralDialog(
      context: context,
      //构建对话框内部UI
      pageBuilder: (BuildContext context, Animation<double> animation,
          Animation<double> secondaryAnimation) {
        final Widget pageChild = Builder(
          builder: builder,
        );
        return SafeArea(
          child: Builder(
            builder: (BuildContext context) {
              return themeData != null
                  ? Theme(
                      data: themeData,
                      child: pageChild,
                    )
                  : pageChild;
            },
          ),
        );
      },
      barrierDismissible: barrierDismissible, //点击遮罩是否关闭对话框
      barrierLabel: MaterialLocalizations.of(context)
          .modalBarrierDismissLabel, //语义化标签（用于读屏软件）
      barrierColor: Colors.black87, //自定义遮罩颜色
      transitionDuration: const Duration(milliseconds: 200),
      transitionBuilder: _buildMaterialDdialogTransitions, //对话框打开/关闭的动画
    );
  }

  // 构建转换动画，也可以直接用匿名方法
  Widget _buildMaterialDdialogTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    //使用缩放动画
    return ScaleTransition(
      scale: CurvedAnimation(
        curve: Curves.ease,
        parent: animation,
      ),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    // AlertDialog
    Future<bool> showDeleteConfirmDialog() {
      return showDialog(
        barrierDismissible: true, //点击对话框barrier(遮罩)时是否关闭它
        context: context,
        builder: (context) {
          // 注意：如果AlertDialog的内容过长，内容将会溢出，这在很多时候可能不是我们期望的，
          // 所以如果对话框内容过长时，可以用SingleChildScrollView将内容包裹起来。
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定要删除当前文件吗？"),
            actions: <Widget>[
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, false);
                },
                child: Text("取消"),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.pop(context, true);
                },
                child: Text("确认"),
              ),
            ],
          );
        },
      );
    }

    // SimpleDialog
    Future<void> changeLanguage() async {
      int i = await showDialog<int>(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: Text("请选择语言"),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 1);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: const Text("简体中文"),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 2);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: const Text("美式英语"),
                ),
              ),
            ],
          );
        },
      );
      if (i != null) {
        print("选择了： ${i == 1 ? "简体中文" : "美式英语"}");
      }
    }

    // AlertDialog和SimpleDialog中使用了IntrinsicWidth来尝试通过子组件的实际尺寸来调整自身尺寸，因此子组件不能是延迟加载模型的组件
    // 在Dialog中使用延迟加载模型的组件（如ListView、GridView 、 CustomScrollView等）
    Future<void> showListDialog() async {
      int index = await showDialog<int>(
        context: context,
        builder: (context) {
          var child = Column(
            children: <Widget>[
              ListTile(
                title: Text("请选择"),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("$index"),
                      onTap: () {
                        Navigator.pop(context, index);
                      },
                    );
                  },
                ),
              ),
            ],
          );
          // return Dialog(child: child,);
          // 也可以返回自定义对话框，如下
          return UnconstrainedBox(
            constrainedAxis: Axis.vertical,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 280),
              child: Material(
                child: child,
                type: MaterialType.card,
              ),
            ),
          );
        },
      );
      if (index != null) {
        print("点击了: $index");
      }
    }

    // 自定义打开对话框动画及遮罩
    Future<void> showCustomDialog() async {
      bool delete = await customDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Text("您确定要删除当前文件吗?"),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("删除"),
                onPressed: () {
                  // 执行删除操作
                  Navigator.of(context).pop(true);
                },
              ),
            ],
          );
        },
      );
      if (delete == null) {
        print("取消删除");
      } else {
        print("确认删除");
      }
    }

    // #1 单独抽离出StatefulWidget，这里指DialogCheckbox
    Future<int> showDialogCheckbox() {
      bool _value = false; //记录复选框选中状态
      return showDialog<int>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("您确定要删除当前文件吗？"),
                Row(
                  children: <Widget>[
                    Text("同时删除子目录？"),
                    DialogCheckbox(
                      value: _value,
                      onChanged: (bool v) {
                        _value = !_value; //更新选中状态
                      },
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () =>
                    Navigator.of(context).pop(_value ? 1 : 0), //01 00
              ),
              FlatButton(
                child: Text("删除"),
                onPressed: () {
                  // 将选中状态与按钮点击状态返回
                  Navigator.of(context).pop(_value ? 3 : 2); //11 10
                },
              ),
            ],
          );
        },
      );
    }

    // #2 使用StatefulBuilder方法
    Future<int> showDialogCheckbox2() {
      bool _value = false; //记录复选框选中状态
      return showDialog<int>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("您确定要删除当前文件吗？"),
                Row(
                  children: <Widget>[
                    Text("同时删除子目录？"),
                    //与#1不同的是，这里使用_StatefulBuilder来构建StatefulWidget上下文
                    _StatefulBuilder(
                      builder: (context, _setState) {
                        return Checkbox(
                          value: _value,
                          onChanged: (bool v) {
                            //_setState方法实际就是该StatefulWidget的setState方法，
                            //调用后builder方法会重新被调用
                            _setState(() {
                              _value = !_value;
                            });
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () =>
                    Navigator.of(context).pop(_value ? 1 : 0), //01 00
              ),
              FlatButton(
                child: Text("删除"),
                onPressed: () {
                  // 将选中状态与按钮点击状态返回
                  Navigator.of(context).pop(_value ? 3 : 2); //11 10
                },
              ),
            ],
          );
        },
      );
    }

    // #3 使用markNeedsBuild()标记需要更新的UI
    Future<int> showDialogCheckbox3() {
      bool _value = false; //记录复选框选中状态
      return showDialog<int>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Text("您确定要删除当前文件吗？"),
                Row(
                  children: <Widget>[
                    Text("同时删除子目录？"),
                    // Checkbox(
                    //   value: _value,
                    //   onChanged: (bool v) {
                    //     // 此时context为对话框UI的根Element，我们直接将对话框UI对应的Element标记为dirty
                    //     (context as Element).markNeedsBuild();
                    //     _value = !_value;
                    //   },
                    // ),
                    Builder(
                      builder: (context) {
                        return Checkbox(
                          value: _value,
                          onChanged: (bool v) {
                            // 这是最优解，将context的范围缩小，只标记Checkbox的Element
                            (context as Element).markNeedsBuild();
                            _value = !_value;
                          },
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("取消"),
                onPressed: () =>
                    Navigator.of(context).pop(_value ? 1 : 0), //01 00
              ),
              FlatButton(
                child: Text("删除"),
                onPressed: () {
                  // 将选中状态与按钮点击状态返回
                  Navigator.of(context).pop(_value ? 3 : 2); //11 10
                },
              ),
            ],
          );
        },
      );
    }

    // Material风格的底部菜单列表模态对话框
    Future<int> _showModalBottomSheet() {
      return showModalBottomSheet<int>(
        context: context,
        builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              ListTile(
                title: Text("showModalBottomSheet"),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("$index"),
                      onTap: () => Navigator.of(context).pop(index),
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    // showBottomSheet方法，返回的是一个controller
    // showBottomSheet和我们上面介绍的弹出对话框的方法原理不同：
    // showBottomSheet是调用widget树顶部的Scaffold组件的ScaffoldState的showBottomSheet同名方法实现，
    // 也就是说要调用showBottomSheet方法就必须得保证父级组件中有Scaffold。
    PersistentBottomSheetController<int> _controller;
    PersistentBottomSheetController<int> _showBottomSheet(
        BuildContext context) {
      return showBottomSheet<int>(
        context: context,
        builder: (BuildContext context) {
          return Column(
            children: <Widget>[
              ListTile(
                title: Text("showBottomSheet"),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: 30,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      title: Text("$index"),
                      onTap: () {
                        // do something
                        print("$index");
                        Navigator.of(context).pop(index);
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      );
    }

    // Loading框可以直接通过showDialog+AlertDialog
    void _showLoadingDialog() {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  CircularProgressIndicator(),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text("正在加载中，请稍后..."),
                  ),
                ],
              ),
            );
          });
    }

    // showDialog给对话框设置了宽度限制，可以使用UnconstrainedBox取消限制
    void _showLoadingDialog2() {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return UnconstrainedBox(
              constrainedAxis: Axis.vertical,
              child: SizedBox(
                width: 280,
                child: AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      CircularProgressIndicator(),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text("正在加载中，请稍后..."),
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    // Material风格的日历选择器
    Future<DateTime> _showDatePicker1() {
      var date = DateTime.now();
      return showDatePicker(
        context: context,
        initialDate: date,
        firstDate: date,
        lastDate: date.add(
          //未来30天可选
          Duration(days: 30),
        ),
      );
    }

    // iOS风格的日历选择器需要使用showCupertinoModalPopup方法和CupertinoDatePicker组件来实现：
    Future<DateTime> _showDatePicker2() {
      var date = DateTime.now();
      return showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            color: Color(0xFFFFFFFF),
            child: SizedBox(
              height: 200,
              child: CupertinoDatePicker(
                mode: CupertinoDatePickerMode.dateAndTime,
                minimumDate: date,
                maximumDate: date.add(Duration(days: 30)),
                maximumYear: date.year + 1,
                onDateTimeChanged: (DateTime value) {
                  print(value);
                },
              ),
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Some Dialog"),
      ),
      body: Builder(
        builder: (BuildContext context) {
          return Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                RaisedButton(
                  onPressed: () async {
                    //弹出对话框并等待其关闭
                    bool delete = await showDeleteConfirmDialog();
                    if (delete == null) {
                      print("取消操作");
                    } else {
                      if (delete) {
                        print("确认删除");
                        //执行删除操作
                      } else {
                        print("取消删除");
                      }
                    }
                  },
                  child: Text("AlertDialog"),
                ),
                RaisedButton(
                  onPressed: () => changeLanguage(),
                  child: Text("SimpleDialog"),
                ),
                RaisedButton(
                  onPressed: () => showListDialog(),
                  child: Text("ListDialog"),
                ),
                RaisedButton(
                  onPressed: () => showCustomDialog(),
                  child: Text("自定义弹出动画与遮罩"),
                ),
                RaisedButton(
                  onPressed: () async {
                    int _state = await showDialogCheckbox();
                    if (_state != null) {
                      print("$_state");
                    } else {
                      print("取消操作");
                    }
                  },
                  child: Text("#1单独抽离出StatefulWidget"),
                ),
                RaisedButton(
                  onPressed: () async {
                    int _state = await showDialogCheckbox2();
                    if (_state != null) {
                      print("$_state");
                    } else {
                      print("取消操作");
                    }
                  },
                  child: Text("#2自定义StatefulBuilder"),
                ),
                RaisedButton(
                  onPressed: () async {
                    int _state = await showDialogCheckbox3();
                    if (_state != null) {
                      print("$_state");
                    } else {
                      print("取消操作");
                    }
                  },
                  child: Text("#3对话框状态管理最优解"),
                ),
                RaisedButton(
                  onPressed: () async {
                    int type = await _showModalBottomSheet();
                    print(type);
                  },
                  child: Text("底部菜单列表1"),
                ),
                RaisedButton(
                  onPressed: () {
                    _controller = _showBottomSheet(context);
                    _controller.closed.then((v) {
                      // TODO 回调方法中，值为什么是null
                      print("$v");
                    });
                  },
                  child: Text("底部菜单列表2"),
                ),
                RaisedButton(
                  onPressed: () {
                    _showLoadingDialog();
                  },
                  child: Text("Loading框1"),
                ),
                RaisedButton(
                  onPressed: () {
                    _showLoadingDialog2();
                  },
                  child: Text("Loading框2"),
                ),
                RaisedButton(
                  onPressed: () {
                    _showDatePicker1();
                  },
                  child: Text("Material风格的日历选择器"),
                ),
                RaisedButton(
                  onPressed: () {
                    _showDatePicker2();
                  },
                  child: Text("iOS风格的日历选择器"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// 仿照Builder封装StatefulBuilder
class _StatefulBuilder extends StatefulWidget {
  final StatefulWidgetBuilder builder;

  const _StatefulBuilder({
    Key key,
    @required this.builder,
  })  : assert(builder != null),
        super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StatefulBuilderState();
  }
}

class _StatefulBuilderState extends State<_StatefulBuilder> {
  @override
  Widget build(BuildContext context) {
    return widget.builder(context, setState);
  }
}
