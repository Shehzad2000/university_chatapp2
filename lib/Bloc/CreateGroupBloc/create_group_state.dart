part of 'create_group_bloc.dart';

@override
abstract class CreateGroupStates {}

class CreateGroupInitialState extends CreateGroupStates {}
class CreateGroupLoadingState extends CreateGroupStates {}
class CreateGroupSuccessState extends CreateGroupStates {}
class CreateGroupErrorState extends CreateGroupStates {}
class CreateGroupShowDataState extends CreateGroupStates {
  List<CreateGroupModel>? list;
  CreateGroupShowDataState(this.list);
}
