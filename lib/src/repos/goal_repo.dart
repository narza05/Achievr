import 'dart:convert';
import 'dart:developer';
import 'package:achievr/src/constants/variables.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/plan_models/plan_model.dart';

class GoalRepo {
  final firestore = FirebaseFirestore.instance;

  Future<dynamic> getAIResponse(String prompt) async {
    final response = await http.post(
      Uri.parse(
          'https://personal-projects-backend.onrender.com/achievr/createplan'
          // 'http://192.168.0.196:3000/achievr/createplan'
          ),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({"userContent": prompt}),
    );
    if (response.statusCode == 200) {
      final content = jsonDecode(response.body)['response'];
      return content;
    } else {
      throw Exception('Failed to get response: ${response.body}');
    }
  }

  //   Future<dynamic> getAIResponse(String prompt ) async {
//     log('message');
//     const apiKey =
//         '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';
//     const endpoint = 'https://api.openai.com/v1/chat/completions';
//
//     final response = await http.post(
//       Uri.parse(endpoint),
//       headers: {
//         'Content-Type': 'application/json',
//         'Authorization': 'Bearer $apiKey',
//       },
//       body: jsonEncode({
//         "model": "gpt-3.5-turbo",
//         "messages": [
//           {
//             "role": "system",
//             "content":
//                 """You are an AI generating wellness plans in JSON format.
//
// Rules:
// 1. Use the following JSON structure exactly:
// {
//   "duration": 7,
//   "isRecurring": true,
//   "days": [
//     {
//       "dailyTasks": [
//         {
//           "title": "Task Title",
//           "description": "Task description here",
//           "time": "hh:mm 00 AM",
//           "isRecurring": false
//         },
//       ],
//       "specialTasks": [
//         {
//           "title": "Special Task Title",
//           "description": "Special task description here",
//           "time": "hh:mm PM"
//         },
//       ]
//     }
//   ]
// }
// 2. The plan must include at least one entry for each day in the duration – no skipped days.
// 3. Output must be valid JSON only – no comments, notes, or explanations.
// """
//           },
//           {"role": "user", "content": prompt}
//         ],
//         "temperature": 0.7
//       }),
//     );
//     // log(response.body);
//     if (response.statusCode == 200) {
//       final content =
//           jsonDecode(response.body)['choices'][0]['message']['content'];
//       return jsonDecode(content);
//     } else {
//       throw Exception('Failed to get response: ${response.body}');
//     }
//   }

  Future<void> insertPlan({required GoalPlanModel plan}) async {
    final docRef = FirebaseFirestore.instance.collection('plans').doc();

    await docRef.set(plan.toJson());
  }

  Future<List<GoalPlanModel>?> getAllPlans() async {
    final doc = await FirebaseFirestore.instance
        .collection('plans')
        .where('user_id', isEqualTo: userIdStatic)
        .get();

    final snapshot = doc;
    if (snapshot.docs.isEmpty) {
      return null;
    }
    List<GoalPlanModel> list = [];
    for (var item in snapshot.docs) {
      log('${item.data()}');
      list.add(GoalPlanModel.fromJson(item.data(), item.id));
    }
    return list;
  }
}
