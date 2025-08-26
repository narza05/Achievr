import 'package:flutter/material.dart';

import '../../../constants/my_colors.dart';

class CircularLoading extends StatelessWidget {
  const CircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
        child: CircularProgressIndicator(
      color: MyColors.primary,
    ));
  }
}
