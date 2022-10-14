import 'package:cloud_firestore/cloud_firestore.dart';

class DepartmentRequestModel {
  String? departmentID;
  String? departmentName;
  int? departmentStatus;

  DepartmentRequestModel(
      {this.departmentID, this.departmentName, this.departmentStatus});

  DepartmentRequestModel.fromSnapShot(DocumentSnapshot json) {
    departmentID = json.id;
    departmentName = json['DepartmentName'];
    departmentStatus = json['DepartmentStatus'];
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['DepartmentName'] = this.departmentName;
    data['DepartmentStatus'] = this.departmentStatus;
    return data;
  }
}