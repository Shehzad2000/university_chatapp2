import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:university_chatapp2/Models/RequestModels/RegisterCoursesRequestModel.dart';

class RegisterCourseRepo{
  FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
  Future<int> MainRegisterCourse(RegisterCoursesRequestModel requestModel) async{
    try{
    await  firebaseFirestore.collection('tbl_RegisterCourses').doc().set(requestModel.toSnapShot());
    return 200;
    }on FirebaseException catch(e){
      return 400;
    }
  }
  Future<int> RemoveMainCourseData(String? id) async{
    try{
      await firebaseFirestore.collection('tbl_RegisterCourses').doc(id).delete();
      return 200;
    }on FirebaseException catch(e){
      return 400;
    }
  }
}