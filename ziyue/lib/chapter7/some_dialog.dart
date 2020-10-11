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

    // 单独抽离出StatefulWidget
    Future<bool> showDialogCheckbox() async {
      bool _value = false; //记录复选框选中状态
      return showDialog<bool>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("提示"),
            content: Column(
              mainAxisAlignment: MainAxisAlignment.start,
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
                onPressed: () => Navigator.of(context).pop(),
              ),
              FlatButton(
                child: Text("删除"),
                onPressed: () {
                  // 将选中状态返回
                  Navigator.of(context).pop(_value);
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Some Dialog"),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
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
              onPressed: () {},
              child: Text("单独抽离出StatefulWidget"),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("对话框状态管理2"),
            ),
            RaisedButton(
              onPressed: () {},
              child: Text("对话框状态管理3"),
            ),
          ],
        ),
      ),
    );
  }
}
