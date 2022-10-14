import 'package:cloud_firestore/cloud_firestore.dart';

class GroupMemberRequestModel {
  String? groupMemberID;
  String? groupID;
  int? status;
  String? studentID;
  String? teacherID;

  GroupMemberRequestModel(
      {this.groupMemberID,this.groupID, this.status, this.studentID, this.teacherID});

  GroupMemberRequestModel.fromSnapShot(DocumentSnapshot json) {
    groupMemberID=json.id;
    groupID = json['GroupID'];
    status = json['Status'];
    studentID = json['StudentID'];
    teacherID = json['TeacherID'];
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GroupID'] = this.groupID;
    data['Status'] = this.status;
    data['StudentID'] = this.studentID;
    data['TeacherID'] = this.teacherID;
    return data;
  }
}