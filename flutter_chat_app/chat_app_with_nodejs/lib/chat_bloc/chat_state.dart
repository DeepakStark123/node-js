part of 'chat_bloc.dart';

abstract class WebSocketChatState {
  const WebSocketChatState();
}

class WebSocketInitialState extends WebSocketChatState {}

class WebSocketConnectedState extends WebSocketChatState {}

class WebSocketDisconnectedState extends WebSocketChatState {}

class WebSocketMessageReceivedState extends WebSocketChatState {
  final List<String> messages;

  const WebSocketMessageReceivedState(this.messages);
}
