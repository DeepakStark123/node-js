part of 'chat_bloc.dart';

abstract class ChatEvent {}

class ConnectWebSocketEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  final String message;

  SendMessageEvent(this.message);
}

class ReceiveMessageEvent extends ChatEvent {
  final String message;

  ReceiveMessageEvent(this.message);
}

class DisconnectWebSocket extends ChatEvent {}
