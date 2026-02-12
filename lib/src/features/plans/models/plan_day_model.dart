import 'package:achievr/src/features/plans/models/plan_task_model.dart';

class PlanDay {
  final DateTime dayNumber;
  final List<PlanTask> dailyTasks;
  final List<PlanTask> specialTasks;

  PlanDay({
    required this.dayNumber,
    required this.dailyTasks,
    required this.specialTasks,
  });
}
