part of 'chat_bloc.dart';

abstract class WebSocketChatState extends Equatable {
  const WebSocketChatState();
  @override
  List<Object?> get props => [];
}

class WebSocketInitialState extends WebSocketChatState {}

class WebSocketConnectedState extends WebSocketChatState {}

class WebSocketDisconnectedState extends WebSocketChatState {}

class WebSocketConnectionErrorState extends WebSocketChatState {
  final String message;
  const WebSocketConnectionErrorState({required this.message});

  @override
  List<Object?> get props => [message];
}

class WebSocketMessageReceivedState extends WebSocketChatState {
  const WebSocketMessageReceivedState({required this.messagesList});
  final List<ChatModel> messagesList;
  @override
  List<Object?> get props => [DateTime.now(), messagesList];
}
