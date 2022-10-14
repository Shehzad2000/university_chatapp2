part of 'chat_bloc.dart';

@override
abstract class ChatStates {}
class ChatInitialState extends ChatStates {}
class ChatLoadingState extends ChatStates {}
class ChatSuccessState extends ChatStates {

}
class ChatErrorState extends ChatStates {}
class ChatShowDataState extends ChatStates {}
