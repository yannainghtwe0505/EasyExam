// To parse this JSON data, do
//
//     final testModel = testModelFromJson(jsonString);

import 'dart:convert';

List<TestModel> testModelFromJson(String str) => List<TestModel>.from(json.decode(str).map((x) => TestModel.fromJson(x)));

String testModelToJson(List<TestModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TestModel {
    TestModel({
        required this.id,
        required this.title,
        required this.startDate,
        required this.endDate,
        required this.imageUrl,
        required this.status,
    });

    int id;
    String title;
    String startDate;
    String endDate;
    String imageUrl;
    int status;

    factory TestModel.fromJson(Map<String, dynamic> json) => TestModel(
        id: json["id"],
        title: json["title"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        imageUrl: json["imageUrl"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "startDate": startDate,
        "endDate": endDate,
        "imageUrl": imageUrl,
        "status": status,
    };
}
