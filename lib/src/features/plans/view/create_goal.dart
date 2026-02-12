import 'package:achievr/src/core/constants/my_colors.dart';
import 'package:achievr/src/core/constants/my_styles.dart';
import 'package:achievr/src/features/shared/widgets/buttons/my_button.dart';
import 'package:achievr/src/features/shared/widgets/text_fields/my_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../view_models/goal_provider.dart';
import '../../shared/widgets/loading/circular_loading.dart';

class CreateGoal extends StatefulWidget {
  const CreateGoal({super.key});

  @override
  State<CreateGoal> createState() => _CreateGoalState();
}

class _CreateGoalState extends State<CreateGoal> {
  // CREATE GOAL PLAN
  TextEditingController goalTextController = TextEditingController();
  TextEditingController conditionTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final goalProvider = Provider.of<GoalProvider>(context);

    return Stack(
      children: [
        body(goalProvider, context),
        !goalProvider.isLoading ? const SizedBox() : const CircularLoading()
      ],
    );
  }

  Scaffold body(GoalProvider goalProvider, BuildContext context) {
    return Scaffold(
      // appBar: MyAppBar(title: 'Create goal'),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Create Your Personalized Wellness Plan',
              style: MyStyles.headline1,
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Set a goal and choose your current condition. We\'ll generate a day by day plan just for you.',
              style: MyStyles.headline4.copyWith(color: MyColors.primary),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            MyTextFormField(
              label: 'Describe your goal...',
              icon: Icons.golf_course_rounded,
              controller: goalTextController,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextFormField(
              label: 'Describe your current condition...',
              icon: Icons.golf_course_rounded,
              controller: conditionTextController,
            ),
            SizedBox(
              height: 10,
            ),
            MyButton(
              function: () {
                goalProvider.generatePlan(context, goalTextController.text,
                    conditionTextController.text);
              },
              child: const Text(
                'Get plan',
                style: MyStyles.headline3Dark,
              ),
            )
          ],
        ),
      ),
    );
  }
}
