part of 'getuser_id_bloc.dart';

@immutable
abstract class GetuserIdState {}

class GetuserIdInitial extends GetuserIdState {}

class GetuserIdLoading extends GetuserIdState {}

class GetuserIdSuccess extends GetuserIdState {
  String? userId;
  GetuserIdSuccess({this.userId});
}
