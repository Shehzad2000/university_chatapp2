import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';

import '../Models/RequestModels/DepartmentRequestModel.dart';

class DepFireBase {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  DocumentSnapshot? documentSnapshot;

   Future<int> AddDepartment(DepartmentRequestModel? departmentRequestModel) async {
     try {
       await firestore.collection('tbl_Department').doc().set(departmentRequestModel!.toSnapShot());
       return 200;
     }on FirebaseException catch(e){
      return 400;
     }
  }

  void UpdateDepartment(DepartmentRequestModel? departmentRequestModel) async =>
      await firestore
          .collection('tbl_Department')
          .doc(departmentRequestModel!.departmentID)
          .update(departmentRequestModel.toSnapShot());

  Future<List<DepartmentRequestModel>> getDepartments() async{
    List<DepartmentRequestModel> list =[];
    try {
      QuerySnapshot snapshot = await firestore.collection('tbl_Department').get();
      list = snapshot.docs.map((dep) => DepartmentRequestModel.fromSnapShot(dep)).toList();
    }on FirebaseException catch(e){
      print(e.toString());
    }
    return list;
  }
  void DeleteDep({String? depId})async{
    await firestore.collection('tbl_Department').doc(depId).delete();
  }
  Future<DepartmentRequestModel> GetSingleDepartmentData({String? depID}) async{
    documentSnapshot = await  firestore.collection('tbl_Department').doc(depID).get();
    DepartmentRequestModel model = DepartmentRequestModel.fromSnapShot(documentSnapshot!);/*documentSnapshot!.data()*/
    return model;

  }
}
