import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:security_education/models/course_model.dart';

import '../Service/api_service.dart';
import '../models/question_model.dart';
import '../models/test_model.dart';

class TestAPI extends StatelessWidget {
  static const routeName = "test-api";
  const TestAPI({super.key});

  static List<CourseModel>? _courseModel = [];
  static List<TestModel>? _testModel = [];
  static QuestionModel? _questionModel;

  Future<List<CourseModel>?> _getData(BuildContext context) async {
    var apiServiceData = Provider.of<ApiService>(context);
    _courseModel = (await apiServiceData.getCourse());
    List<CourseModel> a =
        _courseModel!.where((element) => element.id == 1).toList();
    print(a[0].id);
    print("hrara");
    _testModel = (await apiServiceData.getTest());

    _questionModel = (await apiServiceData.getQuestion("1"));

    return _courseModel;
  }

  @override
  Widget build(BuildContext context) {
    _getData(context);
    return Scaffold(
      body: ListView.builder(
          itemCount: _courseModel!.length,
          itemBuilder: (context, index) {
            return Card(
              child: Column(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Course Section"),
                      Text(_courseModel![index].status.toString()),
                      Text(_courseModel![index].id.toString()),
                      Text(_courseModel![index].title.toString()),
                      Text(_courseModel![index].imageUrl),
                      Text(_courseModel![index].status.toString()),
                    ],
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Test Section"),
                      Text(_testModel![0].title),
                      Text(_testModel![0].startDate),
                      Text(_testModel![0].endDate),
                      Text(_testModel![0].imageUrl),
                    ],
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text("Question Section"),
                      Text(_questionModel!.id.toString()),
                      Text(_questionModel!.choice1),
                      Text(_questionModel!.choice2),
                      Text(_questionModel!.choice3),
                      Text(_questionModel!.choice4),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }
}
