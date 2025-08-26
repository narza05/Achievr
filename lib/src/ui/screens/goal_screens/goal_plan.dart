import 'dart:developer';

import 'package:achievr/src/constants/my_colors.dart';
import 'package:achievr/src/constants/my_styles.dart';
import 'package:achievr/src/providers/goal_provider.dart';
import 'package:achievr/src/ui/widgets/buttons/my_button.dart';
import 'package:achievr/src/utils/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../widgets/app_bars/my_app_bar.dart';
import '../../widgets/loading/circular_loading.dart';

class GoalPlan extends StatefulWidget {
  const GoalPlan({super.key});

  @override
  State<GoalPlan> createState() => _GoalPlanState();
}

class _GoalPlanState extends State<GoalPlan> {
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
      appBar: MyAppBar(
        title: 'Plan',
        actions: [
          InkWell(
            onTap: () {
              goalProvider.pickStartDate(context);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  getFormattedDate(date: goalProvider.planStartDate),
                  style: MyStyles.headline3.copyWith(color: MyColors.primary),
                ),
                Row(
                  children: [
                    Text(
                      'Start Date',
                      style: MyStyles.headline4,
                    ),
                    SizedBox(
                      width: 3,
                    ),
                    Icon(
                      Icons.calendar_month_outlined,
                      color: MyColors.grey,
                      size: 15,
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      bottomNavigationBar: goalProvider.goalPlan!.userId != null
          ? SizedBox()
          : Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: MyButton(
                        child: Text(
                          'Add',
                          style: MyStyles.headline3Dark,
                        ),
                        function: () {
                          goalProvider.insertPlan(context);
                        }),
                  ),
                ],
              ),
            ),
      body: SingleChildScrollView(
        child: ListView.builder(
            shrinkWrap: true,
            padding: EdgeInsets.symmetric(horizontal: 10),
            physics: NeverScrollableScrollPhysics(),
            itemCount: goalProvider.goalPlan!.days.length,
            itemBuilder: (context, position) {
              final day = goalProvider.goalPlan!.days[position];
              return Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: MyColors.primary,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          getFormattedDate(date: day.date),
                          style:
                              MyStyles.headline3.copyWith(color: Colors.white),
                        )),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: day.dailyTasks.length,
                        itemBuilder: (context, position) {
                          final task = day.dailyTasks[position];
                          return Container(
                            margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                // color: MyColors.lightGrey,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: MyColors.grey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    task.time,
                                    style: MyStyles.headline3.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        task.title,
                                        style: MyStyles.headline3,
                                      ),
                                      Text(
                                        task.description,
                                        style: MyStyles.headline4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }),
                    SizedBox(
                      height: 20,
                    ),
                    ListView.builder(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: day.specialTasks.length,
                        itemBuilder: (context, position) {
                          final task = day.specialTasks[position];
                          return Container(
                            // margin: EdgeInsets.only(left: 10),
                            decoration: BoxDecoration(
                                // color: MyColors.lightGrey,
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 3),
                                  decoration: BoxDecoration(
                                      color: MyColors.lightGrey,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Text(
                                    task.time,
                                    style: MyStyles.headline3.copyWith(
                                        // color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'SPECIAL TASK',
                                        style: MyStyles.headline4
                                            .copyWith(color: MyColors.primary),
                                      ),
                                      Text(
                                        task.title,
                                        style: MyStyles.headline3,
                                      ),
                                      Text(
                                        task.description,
                                        style: MyStyles.headline4,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        })
                  ],
                ),
              );
            }),
      ),
    );
  }
}
