import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:security_education/models/course_model.dart';
import 'package:security_education/models/test_model.dart';
import '../models/question_model.dart';

class ApiService with ChangeNotifier {
  final String? authToken;
  final String? userId;
  ApiService(this.authToken, this.userId);

  /*https://localhost:7001/api/Course */
  Future<List<CourseModel>?> getCourse() async {
    try {
      if (authToken != null) {
        final response = await http
            .get(Uri.parse("https://localhost:7001/api/Course"), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        });
        List<CourseModel> model = courseModelFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  /*https://localhost:7001/api/test */
  Future<List<TestModel>?> getTest() async {
    try {
      if (authToken != null) {
        final response = await http
            .get(Uri.parse("https://localhost:7001/api/test"), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $authToken',
        });
        List<TestModel> model = testModelFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  /*https://localhost:7001/api/test */
  Future<QuestionModel?> getQuestion(String testId) async {
    try {
      if (authToken != null) {
        final response = await http.get(
            Uri.parse("https://localhost:7001/api/Question/$testId"),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $authToken',
            });
        QuestionModel model = questionModelFromJson(response.body);
        return model;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
