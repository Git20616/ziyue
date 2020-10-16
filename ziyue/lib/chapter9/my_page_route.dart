import 'package:flutter/material.dart';

class MyPageRoute extends PageRoute {
  final WidgetBuilder builder1;

  final Duration transitionDuration1;

  final bool opaque1;

  final bool barrierDismissible1;

  final Color barrierColor1;

  final String barrierLabel1;

  final bool maintainState1;

  MyPageRoute({
    @required this.builder1,
    this.transitionDuration1 = const Duration(milliseconds: 300),
    this.opaque1 = true,
    this.barrierDismissible1 = false,
    this.barrierColor1,
    this.barrierLabel1,
    this.maintainState1 = true,
  });

  @override
  Color get barrierColor => barrierColor1;

  @override
  String get barrierLabel => barrierLabel1;

  @override
  Widget buildPage(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation) {
    return builder1(context);
  }

  // 实际使用时应优先考虑使用PageRouteBuilder
  // 在应用过渡动画时我们需要读取当前路由的一些属性，这时就只能通过继承PageRoute的方式了
  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation, Widget child) {
    if(isActive) {
      return FadeTransition(
        opacity: animation,
        child: builder1(context),
      );
    } else {
      return Padding(padding: EdgeInsets.zero,);
    }

  }

  @override
  bool get maintainState => maintainState1;

  @override
  Duration get transitionDuration => transitionDuration1;
}
