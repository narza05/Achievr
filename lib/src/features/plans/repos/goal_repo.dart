import 'dart:convert';
import 'dart:developer';
import 'package:achievr/src/core/constants/my_urls.dart';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/plan_model.dart';

class GoalRepo {
  final firestore = FirebaseFirestore.instance;

  Future<dynamic> getAIResponse(String prompt) async {
    final response = await http.post(
      Uri.parse(createPlanUrl),
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

  Future<void> insertPlan({required GoalPlanModel plan}) async {
    final docRef = FirebaseFirestore.instance.collection('plans').doc();

    await docRef.set(plan.toJson());
  }

  Future<List<GoalPlanModel>?> getAllPlans(String userId) async {
    final doc = await FirebaseFirestore.instance
        .collection('plans')
        .where('user_id', isEqualTo: userId)
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
