part of 'chat_bloc.dart';

abstract class ChatState {
  const ChatState();
}

class ChatInitialState extends ChatState {}

class ChatConnectedState extends ChatState {}

class ChatDisconnectedState extends ChatState {}

class ChatMessageReceivedState extends ChatState {
  final List<String> messages;

  const ChatMessageReceivedState(this.messages);
}
