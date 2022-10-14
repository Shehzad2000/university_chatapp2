// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university_chatapp2/Models/RequestModels/SemesterRequestModel.dart';

class SemesterRepo{
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
DocumentSnapshot? documentSnapshot;
  Future<int> AddSemester(SemesterRequestModel? semesterRequestModel) async
  {
  try{
    await firebaseFirestore.collection("tbl_Semester").doc().set(semesterRequestModel!.toSnapShot());
    return 200;
  }on FirebaseException catch(e){
    return 400;
  }
  }
  void UpdateSemester(SemesterRequestModel requestModel) async{
    await firebaseFirestore.collection('tbl_Semester').doc(requestModel.semesterID).update(requestModel.toSnapShot());
  }
  void DeleteSemester(String? ID) async{
    await firebaseFirestore.collection('tbl_Semester').doc(ID).delete();
  }
  Future<SemesterRequestModel> GetSemester(String? ID) async{
    documentSnapshot=await firebaseFirestore.collection('tbl_Semester').doc(ID).get();
    return SemesterRequestModel.fromSnapShot(documentSnapshot!);
  }
  Future<List<SemesterRequestModel>> GetSemesters() async{
    QuerySnapshot querySnapshot=await firebaseFirestore.collection("tbl_Semester").get();
    return querySnapshot.docs.map((e) => SemesterRequestModel.fromSnapShot(e)).toList();
  }
}