part of 'chat_bloc.dart';

@override
abstract class ChatEvents {}
class RegisterChatEvent extends ChatEvents{
ChatRequestModel? requestModel;
RegisterChatEvent({this.requestModel});
}
