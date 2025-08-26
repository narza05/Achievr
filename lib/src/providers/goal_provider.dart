import 'dart:convert';
import 'dart:developer';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:achievr/src/constants/strings.dart';
import 'package:intl/intl.dart';

import 'package:achievr/src/constants/variables.dart';
import 'package:achievr/src/models/plan_models/plan_day_model.dart';
import 'package:achievr/src/repos/goal_repo.dart';
import 'package:achievr/src/ui/screens/goal_screens/goal_plan.dart';
import 'package:achievr/src/utils/methods.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;

import '../../main.dart';
import '../models/plan_models/plan_model.dart';

class GoalProvider extends ChangeNotifier {
  bool _loading = false;

  get isLoading => _loading;

  set setIsLoading(bool value) {
    _loading = value;
    update();
  }

  GoalRepo goalRepo = GoalRepo();

  // CREATE GOAL PLAN
  TextEditingController goalTextController = TextEditingController();
  TextEditingController conditionTextController = TextEditingController();

  // GOAL PLAN
  GoalPlanModel? goalPlan;
  DateTime planStartDate = DateTime.now().add(const Duration(days: 1));

  // GOAL DASHBOARD
  List<GoalPlanModel> currentGoalPlans = [];
  DateTime selectedCalendarDate = DateTime.now();

  generatePlan(BuildContext context) async {
    setIsLoading = true;
    final parsed = await goalRepo.getAIResponse(
        'Goal: ${goalTextController.text}, Current condition: ${conditionTextController.text}');
    log('$parsed');
    goalPlan = GoalPlanModel(
      // userId: userIdStatic!,
      goal: goalTextController.text,
      condition: conditionTextController.text,
      startDate: planStartDate,
      duration: int.parse(parsed['duration'].toString()),
      isRecurring: parsed['isRecurring'],
      days: (parsed['days'] as List).map((e) => DayPlan.fromJson(e)).toList(),
    );
    for (int i = 0; i < goalPlan!.days.length; i++) {
      goalPlan!.days[i].date =
          getDateWithoutTime(date: planStartDate.add(Duration(days: i)));
    }
    setIsLoading = false;
    Navigator.pushNamed(context, '/$goalPlanScreen');
  }

  pickStartDate(BuildContext context) {
    return showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2000, 1, 1),
            lastDate: DateTime(2100, 1, 1))
        .then((date) {
      if (date != null) {
        planStartDate = getDateWithoutTime(date: date);
        update();
      }
    });
  }

  insertPlan(BuildContext context) async {
    setIsLoading = true;
    goalPlan!.startDate = planStartDate;
    goalPlan!.userId = userIdStatic;
    await goalRepo.insertPlan(plan: goalPlan!);
    await scheduleAllGoalNotifications(goalPlan!);
    setIsLoading = false;
    Navigator.pushNamedAndRemoveUntil(
        context, '/$goalDashboardScreen', (route) => false);
  }

  scheduleAllGoalNotifications(GoalPlanModel plan) async {
    for (final dayPlan in plan.days) {
      final date = dayPlan.date;

      for (final task in dayPlan.dailyTasks) {
        final taskTime = _parseTaskTime(task.time, date);
        if (taskTime != null && taskTime.isAfter(DateTime.now())) {
          await AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: createUniqueId(),
              channelKey: 'achievr_channel',
              title: task.title,
              body: task.description,
              notificationLayout: NotificationLayout.Default,
            ),
            schedule: NotificationCalendar(
              year: taskTime.year,
              month: taskTime.month,
              day: taskTime.day,
              hour: taskTime.hour,
              minute: taskTime.minute,
              second: 0,
              millisecond: 0,
              preciseAlarm: true,
            ),
          );
        }
      }

      for (final special in dayPlan.specialTasks) {
        final specialTime = _parseTaskTime(special.time, date);
        if (specialTime != null && specialTime.isAfter(DateTime.now())) {
          AwesomeNotifications().createNotification(
            content: NotificationContent(
              id: createUniqueId(),
              channelKey: 'achievr_channel',
              title: special.title,
              body: special.description,
              notificationLayout: NotificationLayout.Default,
            ),
            schedule: NotificationCalendar(
              year: specialTime.year,
              month: specialTime.month,
              day: specialTime.day,
              hour: specialTime.hour,
              minute: specialTime.minute,
              second: 0,
              millisecond: 0,
              preciseAlarm: true,
            ),
          );
        }
      }
    }
  }

  DateTime? _parseTaskTime(String timeString, DateTime date) {
    try {
      // Define a format for 12-hour time like "08:00 AM"
      final format = DateFormat('hh:mm a');
      final time = format.parse(timeString.trim());

      return DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    } catch (e) {
      print('Invalid time format: $timeString - Error: $e');
      return null;
    }
  }

  int createUniqueId() =>
      DateTime.now().millisecondsSinceEpoch.remainder(100000);

  getAllPlans() async {
    setIsLoading = true;
    await goalRepo.getAllPlans().then((result) {
      if (result != null) {
        currentGoalPlans = result;
      } else {}
    });
    log('${currentGoalPlans.length}');

    currentGoalPlans.forEach((item) {
      log('${item.days.length}');
    });
    setIsLoading = false;
    update();
  }

  selectCalendarDate(DateTime date) {
    selectedCalendarDate = date;
    log('$selectedCalendarDate');
    update();
  }

  goToPlan(GoalPlanModel selectedPlan, BuildContext context) {
    goalPlan = selectedPlan;
    planStartDate = selectedPlan.startDate;
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return const GoalPlan();
    }));
  }

  update() {
    notifyListeners();
  }
}
