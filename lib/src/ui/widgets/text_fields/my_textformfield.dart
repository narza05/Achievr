import 'package:achievr/src/constants/my_styles.dart';
import 'package:achievr/src/constants/my_styles.dart';
import 'package:flutter/material.dart';

import '../../../constants/my_colors.dart';

class MyTextFormField extends StatefulWidget {
  String label;
  IconData icon;
  TextEditingController controller;
  bool readOnly;
  TextInputType? type;
  Function(Object?)? onChange;
  Function()? onIconTap;
  int? length;
  Widget? suffix;

  MyTextFormField(
      {required this.label,
      required this.icon,
      required this.controller,
      this.readOnly = false,
      this.type = TextInputType.text,
      this.onChange,
      this.length,
      this.suffix,
      this.onIconTap});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.length,
      onChanged: widget.onChange,
      keyboardType: widget.type,
      readOnly: widget.readOnly,
      controller: widget.controller,
      style: MyStyles.headline3
          .copyWith(color: widget.readOnly ? MyColors.grey : Colors.black),
      decoration: InputDecoration(
          counterText: '',
          labelText: widget.label,
          labelStyle: MyStyles.headline3.copyWith(color: MyColors.grey),
          prefixIcon: GestureDetector(
            onTap: widget.onIconTap,
            child: Icon(
              widget.icon,
              size: 20,
              color: widget.readOnly ? MyColors.grey : MyColors.black,
            ),
          ),
          suffixIcon: widget.suffix == null
              ? widget.readOnly
                  ? Icon(
                      Icons.remove_red_eye,
                      color: Colors.grey,
                    )
                  : null
              : widget.suffix,
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: widget.readOnly ? MyColors.lightGrey : Colors.black,
                  width: 1.5)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide(
                  color: widget.readOnly ? MyColors.lightGrey : Colors.black,
                  width: 1.5))),
    );
  }
}
