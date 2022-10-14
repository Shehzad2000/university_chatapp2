import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:university_chatapp2/Models/RequestModels/CreateGroupModel.dart';
import 'package:university_chatapp2/Repo/CreateGroupRepo.dart';

part 'register_event.dart';
part 'register_state.dart';

class RegisterGroupBloc extends Bloc<RegisterGroupEvents, RegisterGroupStates> {
 CreateGroupRepo repo=CreateGroupRepo();
 RegisterGroupBloc(RegisterGroupStates registerInitialState) : super(RegisterInitialState()) {
    on<RegisterGroupEvents>((event, emit) {
      on<RegisterGroupEvent>(_onRegisterGroup);
      // TODO: implement event handler
    });
  }

  FutureOr<void> _onRegisterGroup(RegisterGroupEvent event, Emitter<RegisterGroupStates> emit) async{
      await repo.CreateGroup(event.model);
  }
}
