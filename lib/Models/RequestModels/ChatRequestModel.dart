class ChatRequestModel {
  String? chatId;
  String? senderId;
  String? fileUrl;
  String? groupImage;
  String? groupName;
  List<String>? userIdsList = [];
  bool? isFile;
  int? TimeSpan;
  var Date;
  String? MessageBody;
  ChatRequestModel(
      {this.chatId,
      this.TimeSpan,
      this.senderId,
      this.Date,
      this.MessageBody,
      this.fileUrl,
      this.groupImage,
      this.groupName,
      this.userIdsList,
      this.isFile});
  ChatRequestModel.fromJson(json) {
    chatId = json.id;
    Date = DateTime.parse(json['Date'].toDate().toString());
    senderId = json['senderId'];
    MessageBody = json['MessageBody'];
    TimeSpan = json['TimeSpan'];
    fileUrl = json['FileUrl'];
    groupImage = json['GroupImage'];
    groupName = json['GroupName'];
    json['UserIdsList'].forEach((v) {
      userIdsList!.add(v.toString());
    });
    isFile = json['isFile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Date'] = this.Date;
    data['FileUrl'] = this.fileUrl;
    data['TimeSpan'] = this.TimeSpan;
    data['senderId'] = this.senderId;
    data['MessageBody'] = this.MessageBody;
    data['GroupImage'] = this.groupImage;
    data['GroupName'] = this.groupName;
    data['UserIdsList'] = this.userIdsList;
    data['isFile'] = this.isFile;
    return data;
  }
}
