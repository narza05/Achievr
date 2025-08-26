import 'dart:developer';

import 'package:achievr/src/constants/my_colors.dart';
import 'package:achievr/src/constants/my_styles.dart';
import 'package:achievr/src/constants/variables.dart';
import 'package:achievr/src/models/plan_models/plan_model.dart';
import 'package:achievr/src/providers/auth_provider.dart';
import 'package:achievr/src/ui/screens/goal_screens/create_goal.dart';
import 'package:achievr/src/ui/widgets/app_bars/my_app_bar.dart';
import 'package:achievr/src/ui/widgets/buttons/my_button.dart';
import 'package:achievr/src/ui/widgets/loading/circular_loading.dart';
import 'package:achievr/src/utils/methods.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:calendar_timeline/calendar_timeline.dart';

import '../../../providers/goal_provider.dart';

class GoalsDashboard extends StatefulWidget {
  const GoalsDashboard({super.key});

  @override
  State<GoalsDashboard> createState() => _GoalsDashboardState();
}

class _GoalsDashboardState extends State<GoalsDashboard> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      log('$userIdStatic');
      log('$userNameStatic');
      log('$userEmailStatic');
      init();
    });

    super.initState();
  }

  init() async {
    final goalProvider = Provider.of<GoalProvider>(context, listen: false);
    goalProvider.getAllPlans();
  }

  @override
  Widget build(BuildContext context) {
    final goalProvider = Provider.of<GoalProvider>(context);
    return Stack(
      children: [
        body(context, goalProvider),
        !goalProvider.isLoading ? const SizedBox() : const CircularLoading()
      ],
    );
  }

  Scaffold body(BuildContext context, GoalProvider goalProvider) {
    return Scaffold(
      appBar: MyAppBar(
        title: 'Achievr',
        actions: [
          // InkWell(
          //     onTap: () {
          //       goalProvider.scheduleAllGoalNotifications(
          //           goalProvider.currentGoalPlans[1]);
          //     },
          SizedBox(
            width: 20,
          ),
          InkWell(
              onTap: () {
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                authProvider.logout(context);
              },
              child: const Icon(Icons.logout_rounded)),
          const SizedBox(
            width: 20,
          )
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            // Expanded(
            //   child: MyButton(
            //       child: Text(
            //         'Get Plan',
            //         style: MyStyles.headline3Dark,
            //       ),
            //       function: () {
            //         // log(getFormattedDate());
            //         goalProvider.getAllPlans();
            //       }),
            // ),
            Expanded(
              child: MyButton(
                  child: Text(
                    'Add Plan',
                    style: MyStyles.headline3Dark,
                  ),
                  function: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CreateGoal();
                    }));
                  }),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CalendarTimeline(
              initialDate: goalProvider.selectedCalendarDate,
              firstDate: DateTime(2000, 1, 1),
              lastDate: DateTime(2100, 12, 31),
              onDateSelected: (date) {
                goalProvider.selectCalendarDate(date);
              },
              leftMargin: 20,
              monthColor: Colors.blueGrey,
              dayColor: Colors.teal[200],
              activeDayColor: Colors.white,
              activeBackgroundDayColor: MyColors.primary,
              selectableDayPredicate: (date) => date.day != 23,
              locale: 'en_ISO',
            ),
            ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: goalProvider.currentGoalPlans.length,
                itemBuilder: (context, position) {
                  final goal = goalProvider.currentGoalPlans[position];
                  return Column(
                    children: [
                      ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: goal.days
                              .firstWhere(
                                  (item) =>
                                      item.date ==
                                      getDateWithoutTime(
                                          date: goalProvider
                                              .selectedCalendarDate),
                                  orElse: () => DayPlan(
                                      date: DateTime.now(),
                                      dailyTasks: [],
                                      specialTasks: []))
                              .dailyTasks
                              .length,
                          itemBuilder: (context, position) {
                            final day = goal.days
                                .firstWhere((item) =>
                                    item.date ==
                                    getDateWithoutTime(
                                        date:
                                            goalProvider.selectedCalendarDate))
                                .dailyTasks[position];
                            return InkWell(
                              onTap: () {
                                goalProvider.goToPlan(goal, context);
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  position != 0
                                      ? SizedBox()
                                      : Container(
                                          margin: EdgeInsets.all(10),
                                          padding: EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                              color: MyColors.primary,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            goal.goal,
                                            style: MyStyles.headline3
                                                .copyWith(color: Colors.white),
                                          )),
                                  Container(
                                    margin: EdgeInsets.only(left: 10),
                                    decoration: BoxDecoration(
                                        // color: MyColors.lightGrey,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 5, vertical: 3),
                                          decoration: BoxDecoration(
                                              color: MyColors.grey,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          child: Text(
                                            day.time,
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
                                                day.title,
                                                style: MyStyles.headline3,
                                              ),
                                              Text(
                                                day.description,
                                                style: MyStyles.headline4,
                                              ),
                                            ],
                                          ),
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
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: goal.days
                              .firstWhere(
                                  (item) =>
                                      item.date ==
                                      getDateWithoutTime(
                                          date: goalProvider
                                              .selectedCalendarDate),
                                  orElse: () => DayPlan(
                                      date: DateTime.now(),
                                      dailyTasks: [],
                                      specialTasks: []))
                              .specialTasks
                              .length,
                          itemBuilder: (context, position) {
                            final day = goal.days
                                .firstWhere((item) =>
                                    item.date ==
                                    getDateWithoutTime(
                                        date:
                                            goalProvider.selectedCalendarDate))
                                .specialTasks[position];
                            return InkWell(
                              onTap: () {
                                goalProvider.goToPlan(goal, context);
                              },
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                decoration: BoxDecoration(
                                    // color: MyColors.lightGrey,
                                    borderRadius: BorderRadius.circular(10)),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                                      decoration: BoxDecoration(
                                          color: MyColors.lightGrey,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Text(
                                        day.time,
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
                                            style: MyStyles.headline4.copyWith(
                                                color: MyColors.primary),
                                          ),
                                          Text(
                                            day.title,
                                            style: MyStyles.headline3,
                                          ),
                                          Text(
                                            day.description,
                                            style: MyStyles.headline4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }
}
