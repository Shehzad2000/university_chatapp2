import 'package:cloud_firestore/cloud_firestore.dart';

import '../Models/RequestModels/SignUpRequestModel.dart';


class FireBase{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
//  {String? email,String? password}
  void signUp({SignUpRequestModel? model}) async{
    await _firestore.collection('User').doc().set(model!.toSnapShot());
    //     {
    //   "Email": email,
    //   "password": password,
    // }
  }
}