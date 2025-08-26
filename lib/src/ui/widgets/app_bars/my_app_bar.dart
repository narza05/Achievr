import 'package:achievr/src/constants/my_styles.dart';
import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  MyAppBar({super.key, this.leading, required this.title, this.actions});

  Widget? leading;
  String title;
  List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: leading ?? Icon(Icons.arrow_back_ios_new_rounded)),
      centerTitle: true,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: MyStyles.headline2,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
