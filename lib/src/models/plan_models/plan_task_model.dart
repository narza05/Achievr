class PlanTask {
  final String title;
  final String description;
  final String time;
  final bool isRecurring;

  PlanTask({
    required this.title,
    required this.description,
    required this.time,
    this.isRecurring = false,
  });
}
