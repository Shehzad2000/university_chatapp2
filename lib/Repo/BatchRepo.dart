import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university_chatapp2/Models/RequestModels/BatchRequestModel.dart';

class BatchRepo{
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  DocumentSnapshot? documentSnapshot;
  Future<int> RegisterBatch(BatchRequestModel requestModel) async{
    try{
     await firebaseFirestore.collection('tbl_Batch').doc().set(requestModel.toSnapShot());
      return 200;
    }on FirebaseException catch(e){
      return 400;
    }
  }
  Future<int> UpdateBatch(BatchRequestModel requestModel) async{
    try{
      await firebaseFirestore.collection('tbl_Batch').doc(requestModel.batchID).update(requestModel.toSnapShot());
      return 200;
    }on FirebaseException catch(e){
      return 400;
    }
  }
  Future<BatchRequestModel?> GetBatchdetail(String? ID) async{
    try{
      documentSnapshot=await firebaseFirestore.collection('tbl_Batch').doc(ID).get();
      BatchRequestModel batchRequestModel=BatchRequestModel.fromSnapShot(documentSnapshot!);
      return batchRequestModel;
    }on FirebaseException catch(e){
      return null;
    }
  }
  Future<List<BatchRequestModel>?> GetAllBatches() async{
    List<BatchRequestModel>? list;
    try{
      QuerySnapshot querySnapshot=await firebaseFirestore.collection('tbl_Batch').get();
      list=querySnapshot.docs.map((e) => BatchRequestModel.fromSnapShot(e)).toList();
      return list;
    }catch(e){
     return null;
    }
  }
  Future<int> RemoveBatches(String? ID) async{
    try{
      await firebaseFirestore.collection('tbl_Batch').doc(ID).delete();
      return 200;
    }catch(e){
      return 400;
    }
  }
}