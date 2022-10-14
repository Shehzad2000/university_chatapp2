import 'package:cloud_firestore/cloud_firestore.dart';

class TeacherRequestModel {
  String? teacherID;
  String? adminID;
  String? departmentID;
  String? positionID;
  String? posName;
  String? registrationDate;
  String? teacherContact;
  String? teacherEmail;
  String? depName;
  String? teacherGender;
  String? teacherImage;
  String? teacherName;
  String? teacherPassword;
  int? teacherStatus;

  TeacherRequestModel(
      {this.teacherID,
        this.adminID,
        this.departmentID,
        this.positionID,
        this.registrationDate,
        this.teacherContact,
        this.teacherEmail,
        this.depName,
        this.posName,
        this.teacherGender,
        this.teacherImage,
        this.teacherName,
        this.teacherPassword,
        this.teacherStatus});

  TeacherRequestModel.fromSnapShot(DocumentSnapshot json) {
    teacherID = json.id;
    adminID = json['AdminID'];
    departmentID = json['DepartmentID'];
    positionID = json['PositionID'];
    registrationDate = json['RegistrationDate'];
    teacherContact = json['TeacherContact'];
    teacherEmail = json['TeacherEmail'];
    teacherGender = json['TeacherGender'];
    teacherImage = json['TeacherImage'];
    teacherName = json['TeacherName'];
    teacherPassword = json['TeacherPassword'];
    teacherStatus = json['TeacherStatus'];
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['AdminID'] = this.adminID;
    data['DepartmentID'] = this.departmentID;
    data['PositionID'] = this.positionID;
    data['RegistrationDate'] = this.registrationDate;
    data['TeacherContact'] = this.teacherContact;
    data['TeacherEmail'] = this.teacherEmail;
    data['TeacherGender'] = this.teacherGender;
    data['TeacherImage'] = this.teacherImage;
    data['TeacherName'] = this.teacherName;
    data['TeacherPassword'] = this.teacherPassword;
    data['TeacherStatus'] = this.teacherStatus;
    return data;
  }
}