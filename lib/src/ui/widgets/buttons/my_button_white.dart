import 'package:flutter/material.dart';

class MyButtonWhite extends StatelessWidget {
  Widget child;
  Function() function;
  BoxBorder? border;

  MyButtonWhite({required this.child, required this.function, this.border});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: double.maxFinite,
        height: 55,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            border: border ?? Border.all(color: Colors.black)),
        child: Center(child: child),
      ),
    );
  }
}
