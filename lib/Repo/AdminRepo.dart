// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:university_chatapp2/Models/RequestModels/AdminRequestModel.dart';
import 'package:university_chatapp2/Models/RequestModels/SignUpRequestModel.dart';
import 'package:university_chatapp2/Repo/Repo.dart';
import 'package:university_chatapp2/Repo/SharedPrefrence.dart';

class AdminFireBase {
  static FirebaseStorage _fireBaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  DocumentSnapshot? documentSnapshot;
  Future<int> SignUp(AdminRequestModel? adminRequestModel) async {
    try {
      await _firestore
          .collection("tbl_Admin")
          .doc()
          .set(adminRequestModel!.toSnapShot());
      if (adminRequestModel.adminImage != null) {
        _fireBaseStorage
            .ref()
            .child("Admin/${adminRequestModel.adminImage}-image")
            .putFile(adminRequestModel.adminImage!);
      }
      firebaseAuth.createUserWithEmailAndPassword(
          email: adminRequestModel.adminEmail!,
          password: adminRequestModel.adminPassword!);
      return 200;
    } on FirebaseException catch (e) {
      return 400;
    }
  }

  Future<int> SignIn(AdminRequestModel? adminRequestModel) async {
    try {
      QuerySnapshot res = await _firestore
          .collection('tbl_Admin')
          .where(
            "AdminEmail",
            isEqualTo: adminRequestModel!.adminEmail!.trim(),
          )
          .where("AdminPassword",
              isEqualTo: adminRequestModel.adminPassword!.trim())
          .get();
      if (res.docs.length > 0) {
        firebaseAuth.signInWithEmailAndPassword(
            email: adminRequestModel.adminEmail!,
            password: adminRequestModel.adminPassword!);
        SharedPreference.saveString(SharedPreference.uID, res.docs[0].id);
      }
      return 200;
    } on FirebaseAuthException catch (e) {
      return 400;
    }
  }

  Future<AdminRequestModel> getSingleUser() async {
    AdminRequestModel? model;
    try {
      documentSnapshot = await _firestore
          .collection('tbl_Admin')
          .doc('33apIeiWzzIuZyc8Tedf')
          .get();
      String image = await getImageUrl(documentSnapshot!["AdminImage"]);
      model = AdminRequestModel.fromSnapShot(documentSnapshot!);
      model.adminImage = image; /*documentSnapshot!.data()*/
    } catch (e) {}
    return model!;
  }

  Future<int> UpdateAdminDetail(AdminRequestModel adminRequestModel) async {
    try {
      await _firestore
          .collection('tbl_Admin')
          .doc(adminRequestModel.adminID)
          .update(adminRequestModel.toSnapShot());
      if (adminRequestModel.adminImage != null) {
        _fireBaseStorage
            .ref()
            .child("Admin/${adminRequestModel.adminImage}-image")
            .putFile(adminRequestModel.adminImage!);
      }
      return 200;
    } on FirebaseException catch (e) {
      return 400;
    }
  }

  Future<List<SignUpRequestModel>> GetAllAdmins() async {
    List<SignUpRequestModel> list = [];
    try {
      QuerySnapshot querySnapshot =
          await _firestore.collection('tbl_Admin').get();
      list = querySnapshot.docs
          .map((e) => SignUpRequestModel.fromSnapShot(e))
          .toList();
    } catch (e) {
      print(e.toString());
    }
    return list;
  }

  Future<int> RemoveAdmin(String? ID) async {
    try {
      await _firestore.collection('tbl_Admin').doc(ID).delete();
      return 200;
    } on FirebaseException catch (e) {
      return 400;
    }
  }

  static Future<String> getImageUrl(String imgUrl) async {
    String image = "";
    if (imgUrl != "") {
      try {
        image = await _fireBaseStorage.refFromURL(imgUrl).getDownloadURL();
      } catch (e) {}
    } else {
      image = "";
    }
    return image;
  }
}
