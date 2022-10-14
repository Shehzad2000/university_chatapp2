import 'package:cloud_firestore/cloud_firestore.dart';

class CourseRequestModel {
  String? courseId;
  int? courseCode;
  String? totalCreditHours;
  String? courseName;

  String? status;

  CourseRequestModel(
      {this.courseId,this.courseCode, this.courseName,this.totalCreditHours, this.status});

  CourseRequestModel.fromSnapShot(DocumentSnapshot json) {
    courseId=json.id;
    courseCode = json['CourseCode'];
    courseName = json['CourseName'];
    totalCreditHours = json['TotalCreditHours'];
    status = json['Status'];
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['CourseCode'] = this.courseCode;
    data['CourseName'] = this.courseName;
    data['TotalCreditHours'] = this.totalCreditHours;
    data['Status'] = this.status;
    return data;
  }
}