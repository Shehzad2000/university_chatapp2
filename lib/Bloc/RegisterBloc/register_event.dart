part of 'register_bloc.dart';

@override
abstract class RegisterGroupEvents {}
class RegisterGroupEvent extends RegisterGroupEvents{
  CreateGroupModel model;
  RegisterGroupEvent(this.model);
}
