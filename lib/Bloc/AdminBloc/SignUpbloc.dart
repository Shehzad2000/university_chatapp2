import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:university_chatapp2/Bloc/AdminBloc/SignUpEvent.dart';
import 'package:university_chatapp2/Bloc/AdminBloc/SignUpState.dart';
import 'package:university_chatapp2/Models/RequestModels/AdminRequestModel.dart';
import 'package:university_chatapp2/Models/RequestModels/SignUpRequestModel.dart';
import 'package:university_chatapp2/Repo/AdminRepo.dart';
import 'package:university_chatapp2/Repo/Repo.dart';

class SignUpBloc extends Bloc<SignUpEvents, SingUpStates> {
 // FireBase fireBase = FireBase();
  AdminFireBase fireBase=AdminFireBase();
  SignUpBloc(SingUpStates initialState) : super(initialState) {
    // TODO: implement
    on<AddAdminEvent>(_onAddAdminEvent);
    on<UpdateAdminEvent>(_onUpdateAdminEvent);
    on<GetAdminsEvent>(_onGetAdminsEvent);
    on<DeleteAdminEvent>(_onDeleteAdminEvent);
    on<GetSingleAdminEvent>(_onGetSingleAdminEvent);
    on<SignInAdminEvent>(_onAdminSignIn);
  }

  FutureOr<void> _onAddAdminEvent(AddAdminEvent event, Emitter<SingUpStates> emit) async{
   /* fireBase.signUp(
        model: SignUpRequestModel(
            email: event.signUpRequestModel.email,
    //         password: event.signUpRequestModel.password));*/
    int res=await fireBase.SignUp(AdminRequestModel(
       adminID: null,adminName: event.adminRequestModel.adminName,
         adminEmail: event.adminRequestModel.adminEmail,adminContact: event.adminRequestModel.adminContact,
       adminPassword: null,adminGender: event.adminRequestModel.adminGender,adminImage: null,

       adminStatus: 1
     ));
    if(res==200){
      emit(SignUpSuccessState());
    }else{
      emit(SignUpErrorState());
    }
  }
  FutureOr<void> _onUpdateAdminEvent(
      UpdateAdminEvent event, Emitter<SingUpStates> emit) async{
    int res=await fireBase.UpdateAdminDetail(event.adminRequestModel!);
    if(res==200){
      emit(SignUpSuccessState());
    }else{
      emit(SignUpErrorState());
    }
  }

  FutureOr<void> _onGetAdminsEvent(
      GetAdminsEvent event, Emitter<SingUpStates> emit) async{
  }

  FutureOr<void> _onDeleteAdminEvent(
      DeleteAdminEvent event, Emitter<SingUpStates> emit) async{
    await fireBase.RemoveAdmin(event.ID);
  }

  FutureOr<void> _onGetSingleAdminEvent(
      GetSingleAdminEvent event, Emitter<SingUpStates> emit) async{
    AdminRequestModel requestModel=await fireBase.getSingleUser() ;
    emit(SignUpSuccessState(adminRequestModel: requestModel));
  }

  FutureOr<void> _onAdminSignIn(SignInAdminEvent event, Emitter<SingUpStates> emit) async{
    int res=await fireBase.SignIn(event.adminRequestModel);
    if(res==200){
      emit(SignUpSuccessState());
    }else{
      emit(SignUpErrorState());
    }
  }
}
