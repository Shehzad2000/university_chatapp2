import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university_chatapp2/Models/RequestModels/StudentRequestModel.dart';

class StudentRepo{
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  DocumentSnapshot? documentSnapShot;
  Future<int>AddStudent(StudentRequestModel studentRequestModel) async{
    try{
      await firebaseFirestore.collection("tbl_Student").doc().set(studentRequestModel.toSnapShot());
      return 200;
    }on FirebaseException catch(e){
      return 400;
    }
  }
  Future<List<StudentRequestModel>> GetAllStudents() async{
    QuerySnapshot querySnapshot=await firebaseFirestore.collection("tbl_Student").get();
    return querySnapshot.docs.map((e) => StudentRequestModel.fromSnapShot(e)).toList();
  }
  Future<List<StudentRequestModel>> getStudentByStudentBatch({String? batchId}) async{
    QuerySnapshot querySnapshot=await firebaseFirestore.collection("tbl_Student").where("Batch",isEqualTo: batchId).get();
    return querySnapshot.docs.map((e) => StudentRequestModel.fromSnapShot(e)).toList();
  }
  Future<List<StudentRequestModel>> getStudentBySemDepBatch({String? depID,String? semID,String? batch})async{
    QuerySnapshot snapshot=await firebaseFirestore.collection('tbl_Student').where("Batch",isEqualTo: batch).where('DepartmentID',isEqualTo: depID).
    where('SemesterID',isEqualTo: semID).get();
    return snapshot.docs.map((e) => StudentRequestModel.fromSnapShot(e)).toList();
  }
  void RemoveStudent(String? studentID) async{
    await firebaseFirestore.collection("tbl_Student").doc(studentID).delete();
  }
  Future<StudentRequestModel>  GetSingleStudent(String? ID) async {
  documentSnapShot=await firebaseFirestore.collection('tbl_Student').doc(ID).get();
  StudentRequestModel model=await StudentRequestModel.fromSnapShot(documentSnapShot!);
  return model;
  }
  void UpdateStudentRecord(StudentRequestModel requestModel) async{
    firebaseFirestore.collection('tbl_Student').doc(requestModel.studentID).update(requestModel.toSnapShot());
  }
  Future<int> StudentLogin(StudentRequestModel requestModel) async{
   try{
     QuerySnapshot querySnapshot=await firebaseFirestore.collection("tbl_Student").where("StudentEmail",isEqualTo: requestModel.studentEmail!.trim())
         .where("StudentPassword",isEqualTo: requestModel.studentPassword!.trim()).get();
   return 200;
   }on FirebaseException catch(e){
     return 400;
   }
  }
  
}