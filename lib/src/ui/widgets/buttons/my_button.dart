import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../constants/my_colors.dart';

class MyButton extends StatelessWidget {
  Widget child;
  Function() function;

  MyButton({required this.child, required this.function});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: function,
      child: Container(
        width: double.maxFinite,
        height: 55,
        decoration: BoxDecoration(
          color: MyColors.primary,
          borderRadius: BorderRadius.circular(15),
/*            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade400,
                  offset: Offset(0, 2.5),
                  blurRadius: 5,
                  spreadRadius: 0.3)
            ]*/
        ),
        child: Center(child: child),
      ),
    );
  }
}
