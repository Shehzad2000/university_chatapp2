import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:university_chatapp2/Models/RequestModels/ChatRequestModel.dart';

import '../../Repo/ChatRepo.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvents, ChatStates> {
  ChatRepo repo = ChatRepo();
  ChatBloc(ChatStates chatInitialState) : super(ChatInitialState()) {
    on<RegisterChatEvent>(_onRegisterChat);
  }

  FutureOr<void> _onRegisterChat(
      RegisterChatEvent event, Emitter<ChatStates> emit) async {
    int res = await repo.AddChatToDB(event.requestModel!);
    if (res == 200) {
      emit(ChatSuccessState());
    }
  }
}
