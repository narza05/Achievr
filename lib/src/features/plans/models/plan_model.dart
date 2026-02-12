class GoalPlanModel {
  String? userId;
  String? goalId;
  final String goal;
  final String condition;
  DateTime startDate;
  final int duration;
  final bool isRecurring;
  final List<DayPlan> days;

  GoalPlanModel({
    this.userId,
    this.goalId,
    required this.goal,
    required this.condition,
    required this.startDate,
    required this.duration,
    required this.isRecurring,
    required this.days,
  });

  factory GoalPlanModel.fromJson(Map<String, dynamic> json, String goalId) {
    return GoalPlanModel(
      userId: json['user_id'],
      goalId: goalId,
      goal: json['goal'],
      condition: json['condition'],
      startDate: DateTime.parse(json['start_date'].toDate().toString()),
      duration: json['duration'],
      isRecurring: json['isRecurring'],
      days: (json['days'] as List).map((e) => DayPlan.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'goal': goal,
      'condition': condition,
      'start_date': startDate,
      'duration': duration,
      'isRecurring': isRecurring,
      'days': days.map((e) => e.toJson()).toList(),
    };
  }
}

class DayPlan {
  DateTime date;
  final List<Task> dailyTasks;
  final List<SpecialTask> specialTasks;

  DayPlan({
    required this.date,
    required this.dailyTasks,
    required this.specialTasks,
  });

  factory DayPlan.fromJson(Map<String, dynamic> json) {
    return DayPlan(
      date: json['date'] == null
          ? DateTime.now()
          : DateTime.parse(json['date'].toDate().toString()),
      dailyTasks:
          (json['dailyTasks'] as List).map((e) => Task.fromJson(e)).toList(),
      specialTasks: (json['specialTasks'] as List)
          .map((e) => SpecialTask.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'dailyTasks': dailyTasks.map((e) => e.toJson()).toList(),
      'specialTasks': specialTasks.map((e) => e.toJson()).toList(),
    };
  }
}

class Task {
  final String title;
  final String description;
  final String time;
  final bool isRecurring;

  Task({
    required this.title,
    required this.description,
    required this.time,
    required this.isRecurring,
  });

  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      title: json['title'],
      description: json['description'],
      time: json['time'],
      isRecurring: json['isRecurring'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'time': time,
      'isRecurring': isRecurring,
    };
  }
}

class SpecialTask {
  final String title;
  final String description;
  final String time;

  SpecialTask({
    required this.title,
    required this.description,
    required this.time,
  });

  factory SpecialTask.fromJson(Map<String, dynamic> json) {
    return SpecialTask(
      title: json['title'],
      description: json['description'],
      time: json['time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'time': time,
    };
  }
}
