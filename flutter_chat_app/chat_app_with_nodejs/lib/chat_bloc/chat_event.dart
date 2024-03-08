part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object?> get props => [];
}

class WebSocketConnectEvent extends ChatEvent {}

class WebSocketConnectingEvent extends ChatEvent {}

class WebSocketConnectedEvent extends ChatEvent {}

class WebSocketOnConnectErrorEvent extends ChatEvent {}

class WebSocketOnTimeOutEvent extends ChatEvent {}

class WebSocketOnErrorEvent extends ChatEvent {}

class WebSocketOnJoinedEvent extends ChatEvent {}

class WebSocketDisconnectEvent extends ChatEvent {}

class WebSocketOnDisconnectEvent extends ChatEvent {}

class SendMessageEvent extends ChatEvent {
  const SendMessageEvent({required this.chatModel});
  final ChatModel chatModel;

  @override
  List<Object?> get props => [chatModel];
}

class ReceiveMessageEvent extends ChatEvent {
  const ReceiveMessageEvent({required this.chatModel});
  final ChatModel chatModel;

  @override
  List<Object?> get props => [chatModel];
}
