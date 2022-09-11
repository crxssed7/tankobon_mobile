import 'package:flutter/material.dart';

class GradientAppBar extends StatelessWidget with PreferredSizeWidget {
  static const _defaultHeight = 100.0;

  final Gradient gradient;
  final Widget? title;
  final Widget leading;
  final double barHeight;
  final List<Widget>? actions;

  GradientAppBar(
      {super.key,
      this.gradient = const LinearGradient(colors: [
        Color.fromARGB(255, 82, 185, 185),
        Color.fromARGB(255, 82, 218, 171)
      ]),
      this.actions,
      this.title,
      required this.leading,
      this.barHeight = _defaultHeight});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: barHeight,
      decoration: BoxDecoration(
        gradient: gradient,
      ),
      child: AppBar(
        leading: leading,
        title: title,
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        toolbarHeight: barHeight,
        actions: actions,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(barHeight);
}
