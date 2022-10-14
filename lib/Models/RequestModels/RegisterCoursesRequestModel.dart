import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterCoursesRequestModel {
  String? registerCourseID;
  List<String>? courses=[];
  String? department;
  String? semester;
  String? status;

  RegisterCoursesRequestModel(
      {this.registerCourseID,
        this.courses,
        this.department,
        this.semester,
        this.status});

  RegisterCoursesRequestModel.fromSnapShot(DocumentSnapshot json) {
    registerCourseID = json.id;
    json['Courses'].forEach((data)=>{courses!.add(data.toString())});
    department = json['Department'];
    semester = json['Semester'];
    status = json['Status'];
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['  Courses'] = this.courses;
    data['Department'] = this.department;
    data['Semester'] = this.semester;
    data['Status'] = this.status;
    return data;
  }
}