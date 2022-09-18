import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  final List<Widget> children;

  const Header({super.key, required this.children});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromARGB(255, 82, 185, 185),
            Color.fromARGB(255, 82, 218, 171)
          ],
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(75),
        child: Center(
          child: Column(
            children: children,
          ),
        ),
      ),
    );
  }
}