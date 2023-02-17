// To parse this JSON data, do
//
//     final questionModel = questionModelFromJson(jsonString);

import 'dart:convert';

QuestionModel questionModelFromJson(String str) => QuestionModel.fromJson(json.decode(str));

String questionModelToJson(QuestionModel data) => json.encode(data.toJson());

class QuestionModel {
    QuestionModel({
        required this.id,
        required this.questionNo,
        required this.choice1,
        required this.choice2,
        required this.choice3,
        required this.choice4,
    });

    int id;
    int questionNo;
    String choice1;
    String choice2;
    String choice3;
    String choice4;

    factory QuestionModel.fromJson(Map<String, dynamic> json) => QuestionModel(
        id: json["id"],
        questionNo: json["questionNo"],
        choice1: json["choice1"],
        choice2: json["choice2"],
        choice3: json["choice3"],
        choice4: json["choice4"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "questionNo": questionNo,
        "choice1": choice1,
        "choice2": choice2,
        "choice3": choice3,
        "choice4": choice4,
    };
}
