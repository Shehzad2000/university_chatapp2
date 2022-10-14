import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/RequestModels/CourseRequestModel.dart';

class CourseRepo{
FirebaseFirestore firebaseFirestore=FirebaseFirestore.instance;
Future<int> RegisterCourse(CourseRequestModel requestModel) async{
  try{
    await firebaseFirestore.collection('tbl_Courses').doc().set(requestModel.toSnapShot());
    return 200;
  }on FirebaseException catch(e){
    return 400;
  }
}
Future<int> UpdateCourseDetail(CourseRequestModel requestModel) async{
  try{
    await firebaseFirestore.collection('tbl_Courses').doc(requestModel.courseId).set(requestModel.toSnapShot());
    return 200;
  }on FirebaseException catch(e){
    return 400;
  }
}
Future<List<CourseRequestModel>> SearchCourses(String? courseCode1,String? courseCode2) async{
  List<CourseRequestModel> list=[];
  try{
   QuerySnapshot querySnapshot=await firebaseFirestore.collection('tbl_Courses').where('CourseCode',isGreaterThanOrEqualTo: courseCode1).where('CourseCode',isLessThanOrEqualTo: courseCode2).get();
  list=querySnapshot.docs.map((e) => CourseRequestModel.fromSnapShot(e)).toList();
  }on FirebaseException catch(e){
    print(e.toString());
  }
  return list;
}

Future<int> RemoveCourse(String ID) async{
  try{
    await firebaseFirestore.collection('tbl_Courses').doc(ID).delete();
    return 200;
  }on FirebaseException catch(e){
    return 400;
  }
}
Future<CourseRequestModel> GetCourseDetail(String? ID) async{
   DocumentSnapshot documentSnapshot= await firebaseFirestore.collection('tbl_Courses').doc(ID).get();
   CourseRequestModel requestModel=CourseRequestModel.fromSnapShot(documentSnapshot);
   return requestModel;
}
Future<List<CourseRequestModel>> GetAllCourseDetail() async{
  List<CourseRequestModel> list=[];
  try{
    QuerySnapshot querySnapshot=await firebaseFirestore.collection('tbl_Courses').get();
    list=querySnapshot.docs.map((e) => CourseRequestModel.fromSnapShot(e)).toList();
  }on FirebaseException catch(e){
    print(e.toString());
  }
  return list;

}

}