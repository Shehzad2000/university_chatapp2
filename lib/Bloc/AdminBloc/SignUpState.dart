// ignore_for_file: file_names

import 'package:university_chatapp2/Models/RequestModels/SignUpRequestModel.dart';

import '../../Models/RequestModels/AdminRequestModel.dart';

abstract class SingUpStates{}
class SignUpInitialState extends SingUpStates{}
class SignUpLoadingState extends SingUpStates{}
class SignUpSuccessState extends SingUpStates{
 /* List<SignUpRequestModel>? signUpModel;
  SignUpRequestModel? signUpRequestModel;
  SignUpSuccessState({this.signUpRequestModel,this.signUpModel});*/
  //List<AdminRequestModel>? adminModel;
  AdminRequestModel? adminRequestModel;
  SignUpSuccessState({this.adminRequestModel});
}
class SignUpErrorState extends SingUpStates{}
class SignShowDataState extends SingUpStates{
  List<SignUpRequestModel>? list;
  SignShowDataState({this.list});
}
