import 'package:flutter/material.dart';

// 单独封装一个内部管理选中状态的复选框组件
class DialogCheckbox extends StatefulWidget {
  DialogCheckbox({
    Key key,
    this.value,
    @required this.onChanged,
  });

  final bool value; //复选框状态
  final ValueChanged<bool> onChanged; //复选框状态改变时的回调

  @override
  State<StatefulWidget> createState() {
    return DialogCheckboxState();
  }
}

class DialogCheckboxState extends State<DialogCheckbox> {
  bool value;

  @override
  void initState() {
    value = widget.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      value: value,
      onChanged: (v) {
        // 将选中状态通过事件的形式抛出
        widget.onChanged(v);
        setState(() {
          value = v; //更新自身选中状态
        });
      },
    );
  }
}
