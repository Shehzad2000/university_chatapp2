import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:university_chatapp2/Models/RequestModels/DepartmentRequestModel.dart';
import 'package:university_chatapp2/Models/RequestModels/PositionRequestModel.dart';
import 'package:university_chatapp2/Models/RequestModels/TeacherRequestModel.dart';

class TeacherFireBase{
  FirebaseFirestore firestore=FirebaseFirestore.instance;
  DocumentSnapshot? documentSnapshot;
  FirebaseStorage? firebaseStorage=FirebaseStorage.instance;
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  Future<int> RegisterTeacher(TeacherRequestModel teacherRequestModel) async{
    try{
      await firestore.collection("tbl_Teacher").doc().set(teacherRequestModel.toSnapShot());
      return 200;
    }on FirebaseException catch(e){
      return 400;
    }
  }
  Future<List<TeacherRequestModel>> GetAllTeachers() async{
    QuerySnapshot querySnapshot=await firestore.collection("tbl_Teacher").get();
    return querySnapshot.docs.map((e) => TeacherRequestModel.fromSnapShot(e)).toList();
  }
  void UpdateTeacherRecord(TeacherRequestModel requestModel) async{
   await firestore.collection('tbl_Teacher').doc(requestModel.teacherID).update(requestModel.toSnapShot());
  }
  void DeleteTeacherRecord(String? ID) async{
    firestore.collection('tbl_Teacher').doc(ID).delete();
  }
  Future<TeacherRequestModel> GetTeacherRecord(String? ID) async{
    documentSnapshot=await firestore.collection('tbl_Teacher').doc(ID).get();
    return TeacherRequestModel.fromSnapShot(documentSnapshot!);
  }
  Future<List<TeacherRequestModel>> GetTeacherRecordsByDepID(String? departmentID) async{
    List<TeacherRequestModel> list;
    QuerySnapshot querySnapshot=await firestore.collection('tbl_Teacher').where("DepartmentID",isEqualTo: departmentID).get();
    list=querySnapshot.docs.map((data) =>TeacherRequestModel.fromSnapShot(data)).toList();
    return list;
  }
  Future<List<TeacherRequestModel>> GetTeachers() async{
    List<TeacherRequestModel> list = [];
    try {
      QuerySnapshot querySnapshot = await firestore.collection('tbl_Teacher')
          .get();
       list = querySnapshot.docs.map((data) =>
          TeacherRequestModel.fromSnapShot(data)).toList();
      for (var items in list) {
        documentSnapshot = await firestore.collection("tbl_Department").doc(items.departmentID).get();
        DepartmentRequestModel model = DepartmentRequestModel.fromSnapShot(
            documentSnapshot!);
        items.depName = model.departmentName;
        documentSnapshot=await firestore.collection('tbl_Position').doc(items.positionID).get();
        PositionRequestModel requestModel=PositionRequestModel.fromSnapShot(documentSnapshot!);
        items.posName=requestModel.positionName;
      }
    }catch(e){}
    return  list;
  }
  Future<int> TeacherLogin(TeacherRequestModel requestModel) async{
  try{
    QuerySnapshot res=await firestore.collection('tbl_Teacher').where("TeacherEmail",isEqualTo:requestModel.teacherEmail!.trim())
        .where("TeacherPassword",isEqualTo: requestModel.teacherPassword!.trim()).get();
    if (res.docs.length > 0) {
      firebaseAuth.signInWithEmailAndPassword(
          email: requestModel.teacherEmail!,
          password: requestModel.teacherPassword!);
    }
    return 200;
  }on FirebaseAuthException catch(e){
    return 400;
  }

  }
}