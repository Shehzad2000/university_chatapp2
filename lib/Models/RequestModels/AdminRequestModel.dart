import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university_chatapp2/Repo/AdminRepo.dart';

class AdminRequestModel {
  String? adminID;
  String? adminContact;
  String? adminEmail;
  String? adminGender;
  var adminImage;
  String? adminName;
  String? adminPassword;
  int? adminStatus;
  String? registrationDate;

  AdminRequestModel(
      {this.adminID,
        this.adminContact,
        this.adminEmail,
        this.adminGender,
        this.adminImage,
        this.adminName,
        this.adminPassword,
        this.adminStatus,
        this.registrationDate});

  AdminRequestModel.fromSnapShot(DocumentSnapshot json) {
    adminID = json.id;
    adminContact = json['AdminContact'];
    adminEmail = json['AdminEmail'];
    adminGender = json['AdminGender'];
    adminImage = AdminFireBase.getImageUrl(json['AdminImage']);
    adminName = json['AdminName'];
    adminPassword = json['AdminPassword'];
    adminStatus = json['AdminStatus'];
    registrationDate = json['RegistrationDate'];
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AdminID'] = this.adminID;
    data['AdminContact'] = this.adminContact;
    data['AdminEmail'] = this.adminEmail;
    data['AdminGender'] = this.adminGender;
    data['AdminImage'] ="gs://universitychatapp-bbdd7.appspot.com/Admin/${adminEmail}-image";
    data['AdminName'] = this.adminName;
    data['AdminPassword'] = this.adminPassword;
    data['AdminStatus'] = this.adminStatus;
    data['RegistrationDate'] = this.registrationDate;
    return data;
  }
}