import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university_chatapp2/Models/RequestModels/ChatRequestModel.dart';

class ChatRepo {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  Future<int> AddChatToDB(ChatRequestModel requestModel) async {
    try {
      await firebaseFirestore
          .collection('tbl_Chat')
          .doc()
          .set(requestModel.toJson());
      return 200;
    } on FirebaseException catch (e) {
      return 400;
    }
  }

  Stream<List<ChatRequestModel>> getMessagesInRealTime(List<String> userIds) {
    // ignore: close_sinks
    Function eq = const ListEquality().equals;
    final StreamController<List<ChatRequestModel>> _chatMessages =
        StreamController<List<ChatRequestModel>>.broadcast();
    Query<Map<String, dynamic>> messageQuerySnapshot = firebaseFirestore
        .collection('tbl_Chat')
        .orderBy('TimeSpan', descending: false);

    messageQuerySnapshot.snapshots().listen((messageEvent) {
      if (messageEvent.docs.isNotEmpty) {
        var messages = messageEvent.docs
            .map((item) => ChatRequestModel.fromJson(item))
            .where((element) => eq(element.userIdsList, userIds))
            .toList();

        _chatMessages.add(messages);
      }
    });
    return _chatMessages.stream;
  }
}
