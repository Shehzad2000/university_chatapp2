import 'package:cloud_firestore/cloud_firestore.dart';

class PositionRequestModel {
  String? positionID;
  String? positionName;
  int? positionStatus;

  PositionRequestModel(
      {this.positionID, this.positionName, this.positionStatus});

  PositionRequestModel.fromSnapShot(DocumentSnapshot json) {
    positionID = json.id;
    positionName = json['PositionName'];
    positionStatus = json['PositionStatus'];
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PositionName'] = this.positionName;
    data['PositionStatus'] = this.positionStatus;
    return data;
  }
}