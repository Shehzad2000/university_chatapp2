import 'package:cloud_firestore/cloud_firestore.dart';

class SemesterRequestModel {
  String? semesterID;
  String? semesterName;
  int? semesterStatus;

  SemesterRequestModel(
      {this.semesterID, this.semesterName, this.semesterStatus});

  SemesterRequestModel.fromSnapShot(DocumentSnapshot json) {
    semesterID = json.id;
    semesterName = json['SemesterName'];
    semesterStatus = json['SemesterStatus'];
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['SemesterName'] = this.semesterName;
    data['SemesterStatus'] = this.semesterStatus;
    return data;
  }
}