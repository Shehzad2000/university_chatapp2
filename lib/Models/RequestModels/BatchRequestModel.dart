import 'package:cloud_firestore/cloud_firestore.dart';

class BatchRequestModel {
  String? batchID;
  String? batchName;
  String? endDate;
  String? startDate;
  String? status;

  BatchRequestModel(
      {this.batchID,this.batchName, this.endDate, this.startDate, this.status});

  BatchRequestModel.fromSnapShot(DocumentSnapshot json) {
    batchID=json.id;
    batchName = json['BatchName'];
    endDate = json['EndDate'];
    startDate = json['StartDate'];
    status = json['Status'];
  }

  Map<String, dynamic> toSnapShot() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['BatchID']=this.batchID;
    data['BatchName'] = this.batchName;
    data['EndDate'] = this.endDate;
    data['StartDate'] = this.startDate;
    data['Status'] = this.status;
    return data;
  }
}