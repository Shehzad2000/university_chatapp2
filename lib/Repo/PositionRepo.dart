// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university_chatapp2/Models/RequestModels/PositionRequestModel.dart';
import 'package:university_chatapp2/Models/RequestModels/StudentRequestModel.dart';

class PositionRepo{
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  DocumentSnapshot? documentSnapshot;
  Future<int> RegisterPositionData(PositionRequestModel? positionRequestModel) async{
    try{
      await firebaseFirestore
          .collection('tbl_Department')
          .doc()
          .set(positionRequestModel!.toSnapShot());
      return 200;
    }on FirebaseException catch(e){
      return 400;
    }
  }

  void UpdatePositionData(PositionRequestModel positionRequestModel) async{
    await firebaseFirestore.collection('tbl_Semester').doc(positionRequestModel.positionID).update(positionRequestModel.toSnapShot());
  }
  Future<List<PositionRequestModel>> GetPositions() async{
    QuerySnapshot querySnapshot=await firebaseFirestore.collection("tbl_Position").get();
    return querySnapshot.docs.map((e) => PositionRequestModel.fromSnapShot(e)).toList();
  }
  void RemovePosition(String? ID) async{
   await firebaseFirestore.collection('tbl_Position').doc(ID).delete();
  }
  Future<PositionRequestModel> GetPositionRecord(String? ID) async{
   documentSnapshot=await firebaseFirestore.collection('tbl_Position').doc(ID).get();
  return PositionRequestModel.fromSnapShot(documentSnapshot!);
  }
}