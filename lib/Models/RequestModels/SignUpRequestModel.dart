import 'package:cloud_firestore/cloud_firestore.dart';

class SignUpRequestModel {
  String? adminID;
  String? adminContact;
  String? adminEmail;
  String? adminGender;
  String? adminImage;
  String? adminName;
  String? adminPassword;
  int? adminStatus;
  String? registrationDate;

  SignUpRequestModel(
      {this.adminContact,
        this.adminEmail,
        this.adminGender,
        this.adminID,
        this.adminImage,
        this.adminName,
        this.adminPassword,
        this.adminStatus,
        this.registrationDate});

  SignUpRequestModel.fromSnapShot(DocumentSnapshot json) {
    adminContact = json['AdminContact'];
    adminEmail = json['AdminEmail'];
    adminGender = json['AdminGender'];
    adminID = json.id;
    adminImage = json['AdminImage'];
    adminName = json['AdminName'];
    adminPassword = json['AdminPassword'];
    adminStatus = json['AdminStatus'];
    registrationDate = json['RegistrationDate'];
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AdminContact'] = this.adminContact;
    data['AdminEmail'] = this.adminEmail;
    data['AdminGender'] = this.adminGender;
    data['AdminID'] = this.adminID;
    data['AdminImage'] = this.adminImage;
    data['AdminName'] = this.adminName;
    data['AdminPassword'] = this.adminPassword;
    data['AdminStatus'] = this.adminStatus;
    data['RegistrationDate'] = this.registrationDate;
    return data;
  }
}