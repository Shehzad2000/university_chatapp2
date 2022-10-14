import 'package:cloud_firestore/cloud_firestore.dart';

class StudentRequestModel {
  String? studentID;
  String? adminID;
  String? departmentID;
  String? registrationDate;
  String? semesterID;
  String? studentContact;
  String? studentEmail;
  String? studentGender;
  String? studentImage;
  String? studentName;
  String? studentPassword;
  int? studentStatus;

  StudentRequestModel(
      {this.adminID,
        this.studentID,
        this.departmentID,
        this.registrationDate,
        this.semesterID,
        this.studentContact,
        this.studentEmail,
        this.studentGender,
        this.studentImage,
        this.studentName,
        this.studentPassword,
        this.studentStatus});

  StudentRequestModel.fromSnapShot(DocumentSnapshot json) {
    studentID=json.id;
    adminID = json['AdminID'];
    departmentID = json['DepartmentID'];
    registrationDate = json['RegistrationDate'];
    semesterID = json['SemesterID'];
    studentContact = json['StudentContact'];
    studentEmail = json['StudentEmail'];
    studentGender = json['StudentGender'];
    studentImage = json['StudentImage'];
    studentName = json['StudentName'];
    studentPassword = json['StudentPassword'];
    studentStatus = json['StudentStatus'];
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AdminID'] = this.adminID;
    data['DepartmentID'] = this.departmentID;
    data['RegistrationDate'] = this.registrationDate;
    data['SemesterID'] = this.semesterID;
    data['StudentContact'] = this.studentContact;
    data['StudentEmail'] = this.studentEmail;
    data['StudentGender'] = this.studentGender;
    data['StudentImage'] = this.studentImage;
    data['StudentName'] = this.studentName;
    data['StudentPassword'] = this.studentPassword;
    data['StudentStatus'] = this.studentStatus;
    return data;
  }
}