import 'package:achievr/src/constants/my_colors.dart';
import 'package:achievr/src/constants/my_styles.dart';
import 'package:achievr/src/ui/widgets/buttons/my_button.dart';
import 'package:achievr/src/ui/widgets/text_fields/my_textformfield.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../providers/goal_provider.dart';
import '../../widgets/app_bars/my_app_bar.dart';
import '../../widgets/loading/circular_loading.dart';

class CreateGoal extends StatefulWidget {
  const CreateGoal({super.key});

  @override
  State<CreateGoal> createState() => _CreateGoalState();
}

class _CreateGoalState extends State<CreateGoal> {
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
              controller: goalProvider.goalTextController,
            ),
            const SizedBox(
              height: 10,
            ),
            MyTextFormField(
              label: 'Describe your current condition...',
              icon: Icons.golf_course_rounded,
              controller: goalProvider.conditionTextController,
            ),
            SizedBox(
              height: 10,
            ),
            MyButton(
              function: () {
                goalProvider.generatePlan(context);
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
