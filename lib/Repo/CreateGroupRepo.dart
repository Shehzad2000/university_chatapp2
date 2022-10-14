import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:university_chatapp2/Screens/Groups/RegisterGroup.dart';

import '../Models/RequestModels/CreateGroupModel.dart';

class CreateGroupRepo {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  DocumentSnapshot? documentSnapshot;
  Future<int> CreateGroup(CreateGroupModel requestModel) async {
    try {
      await firebaseFirestore
          .collection('tbl_Group')
          .doc()
          .set(requestModel.toJson());
      return 200;
    } on FirebaseException catch (e) {
      return 400;
    }
  }

  Future<List<CreateGroupModel>> GetData(String currentuserId) async {
    addStringToSF(currentuserId);
    QuerySnapshot querySnapshot =
        await firebaseFirestore.collection("tbl_Group").get();
    List<CreateGroupModel> res = querySnapshot.docs
        .map((group) => CreateGroupModel.fromJson(group))
        .toList();
    // for(var item in res) {
    // filteredList =   res!.where((element) {var istrue =  element.userIds!.indexOf(currentuserId; return istr })).toList();

    return res;
  }
  Future<List<CreateGroupModel>> GetDataByDepSemAndBatchID(String? depID,String? SemID,String? BatchID) async{
    QuerySnapshot querySnapshot=await firebaseFirestore.collection('tbl_Group').get();
    List<CreateGroupModel> list=querySnapshot.docs.map((e) => CreateGroupModel.fromJson(e)).toList();
    return list;
  }
  Future<List<CreateGroupModel>> GetGroupsByStudentID(String? studentID) async{
    QuerySnapshot querySnapshot=await firebaseFirestore.collection('tbl_Group').where('UserIds',arrayContains: studentID).get();
    List<CreateGroupModel> list=querySnapshot.docs.map((e)=>CreateGroupModel.fromJson(e)).toList();
    return list;
  }
  Future<List<CreateGroupModel>> GetGroupsByTeacherID(String? teacherID) async{
    QuerySnapshot querySnapshot=await firebaseFirestore.collection('tbl_Group').where('UserIds',arrayContains: teacherID).get();
    List<CreateGroupModel> list=querySnapshot.docs.map((e)=>CreateGroupModel.fromJson(e)).toList();
    return list;
  }
}


addStringToSF(String userID) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString('CurrentUserID', userID);
}
