import 'package:achievr/src/ui/screens/auth_screens/login.dart';
import 'package:achievr/src/ui/screens/goal_screens/create_goal.dart';
import 'package:achievr/src/ui/screens/goal_screens/goal_plan.dart';
import 'package:achievr/src/ui/screens/goal_screens/goals_dashboard.dart';
import 'package:achievr/src/ui/screens/loading_screen.dart';
import 'package:flutter/material.dart';

import '../constants/strings.dart';

class Routes {
  Route? onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case "/$loadingScreen":
        return MaterialPageRoute(builder: (context) {
          return const LoadingScreen();
        });
      case "/$loginScreen":
        return MaterialPageRoute(builder: (context) {
          return const Login();
        });
      case "/$goalDashboardScreen":
        return MaterialPageRoute(builder: (context) {
          return const GoalsDashboard();
        });
      case "/$createGoalScreen":
        return MaterialPageRoute(builder: (context) {
          return const CreateGoal();
        });
      case "/$goalPlanScreen":
        return MaterialPageRoute(builder: (context) {
          return const GoalPlan();
        });
    }
  }
}
