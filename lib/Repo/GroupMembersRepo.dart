import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:university_chatapp2/Models/RequestModels/GroupMemberRequestModel.dart';

class GroupMemberRepo{
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  DocumentSnapshot? documentSnapshot;
  void AddGroupMember(GroupMemberRequestModel groupMemberRequestModel) async{
    await firebaseFirestore.collection("tbl_GroupMember").doc().set(groupMemberRequestModel.toSnapShot());
  }
  void UpdateGroupMember(GroupMemberRequestModel requestModel) async{
    await firebaseFirestore.collection('tbl_GroupMember').doc(requestModel.groupMemberID).update(requestModel.toSnapShot());
  }
  void RemoveGroupMember(String? ID) async{
    await firebaseFirestore.collection('tbl_GroupMember').doc(ID).delete();
  }
  Future<GroupMemberRequestModel> GetGroupMemberRecord(String? ID) async{
    return GroupMemberRequestModel.fromSnapShot(await firebaseFirestore.collection('tbl_GroupMember').doc(ID).get());
  }
  Future<List<GroupMemberRequestModel>> GetAllGroupMembers() async{
    QuerySnapshot querySnapshot=await firebaseFirestore.collection("tbl_GroupMember").get();
    return querySnapshot.docs.map((groupmember) => GroupMemberRequestModel.fromSnapShot(groupmember)).toList();
  }
}