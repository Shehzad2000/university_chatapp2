import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:university_chatapp2/Models/RequestModels/GroupRequestModel.dart';

import '../Models/RequestModels/CreateGroupModel.dart';

class GroupRepo{
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  DocumentSnapshot? documentSnapshot;
  Future<int> addGroup(GroupRequestModel groupRequestModel) async{
    try {
      firebaseFirestore.collection("tbl_Group").doc().set(
          groupRequestModel.toSnapShot());
    return 200;
    }on FirebaseException catch(e){
      return 400;
    }
    }
  void updateGroup(GroupRequestModel requestModel) async{
    await firebaseFirestore.collection('tbl_Group').doc(requestModel.groupID).update(requestModel.toSnapShot());
  }
  void CreateGroup(CreateGroupModel requestModel) async{
    await firebaseFirestore.collection('tbl_ChatHead').doc().set(requestModel.toJson());
  }
  void RemoveGroup(String? ID) async{
    await firebaseFirestore.collection('tbl_Group').doc(ID).get();
  }
  Future<GroupRequestModel> GetSingleGroup(String? ID) async{
    documentSnapshot=await firebaseFirestore.collection('tbl_Group').doc(ID).get();
    GroupRequestModel model=GroupRequestModel.fromSnapShot(documentSnapshot!);
    return model;
  }
  Future<List<GroupRequestModel>> getGroups() async{
    QuerySnapshot querySnapshot=await firebaseFirestore.collection("tbl_Group").get();
    return querySnapshot.docs.map((group) => GroupRequestModel.fromSnapShot(group)).toList();
  }
}
