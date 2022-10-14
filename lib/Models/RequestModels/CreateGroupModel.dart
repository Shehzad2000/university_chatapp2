class CreateGroupModel {
  String? groupId;
  String? groupName;
  String? departmentID;
  String? semesterID;
  String? batchID;
  String? groupDescription;
  List<String>? userIds = [];
  String? groupStatus;
  String? groupImage;

  CreateGroupModel(
      {this.groupId,
      this.groupName,
      this.userIds,
        this.groupDescription,
        this.departmentID,
        this.semesterID,
        this.batchID,
      this.groupStatus,
      this.groupImage});

  CreateGroupModel.fromJson(json) {
    groupId = json.id;
    groupName = json['GroupName'];
    json['UserIds'].forEach((v) {
      userIds!.add(v.toString());
    });
    groupDescription=json['GroupDescription'];
    departmentID=json['DepartmentID'];
    semesterID=json['SemesterID'];
    batchID=json['BatchID'];
    groupStatus = json['GroupStatus'];
    groupImage = json['GroupImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['GroupId'] = this.groupId;
    data['GroupName'] = this.groupName;
    data['UserIds'] = this.userIds;
    data['DepartmentID'] = this.departmentID;
    data['GroupDescription']=this.groupDescription;
    data['SemesterID'] = this.semesterID;
    data['batchID'] = this.batchID;
    data['GroupStatus'] = this.groupStatus;
    data['GroupImage'] = this.groupImage;
    return data;
  }
}
