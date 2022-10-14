// ignore_for_file: file_names

import 'package:university_chatapp2/Models/RequestModels/AdminRequestModel.dart';

abstract class SignUpEvents{}
class AddAdminEvent extends SignUpEvents{
 /* late SignUpRequestModel signUpRequestModel;
  AddAdminEvent(this.signUpRequestModel);*/

  final AdminRequestModel adminRequestModel;
  AddAdminEvent(this.adminRequestModel);
}
class UpdateAdminEvent extends SignUpEvents{
  AdminRequestModel? adminRequestModel;
  UpdateAdminEvent({this.adminRequestModel});
}
class GetAdminsEvent extends SignUpEvents{
}
class DeleteAdminEvent extends SignUpEvents{
String? ID;
DeleteAdminEvent({this.ID});
}
class SignInAdminEvent extends SignUpEvents{
  AdminRequestModel? adminRequestModel;
  SignInAdminEvent(this.adminRequestModel);
}
class  GetSingleAdminEvent extends SignUpEvents{
String? ID;
GetSingleAdminEvent({this.ID});
}