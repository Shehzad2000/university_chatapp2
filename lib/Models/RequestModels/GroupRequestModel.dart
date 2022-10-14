import 'package:cloud_firestore/cloud_firestore.dart';

class GroupRequestModel {
  String? groupID;
  String? adminID;
  String? groupImage;
  String? groupName;
  int? groupStatus;
  String? registerationDate;

  GroupRequestModel(
      {this.groupID,
        this.adminID,
        this.groupImage,
        this.groupName,
        this.groupStatus,
        this.registerationDate});

  GroupRequestModel.fromSnapShot(DocumentSnapshot json) {
    groupID = json.id;
    adminID = json['AdminID'];
    groupImage = json['GroupImage'];
    groupName = json['GroupName'];
    groupStatus = json['GroupStatus'];
    registerationDate = json['RegisterationDate'];
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['AdminID'] = this.adminID;
    data['GroupImage'] = this.groupImage;
    data['GroupName'] = this.groupName;
    data['GroupStatus'] = this.groupStatus;
    data['RegisterationDate'] = this.registerationDate;
    return data;
  }
}