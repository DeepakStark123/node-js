import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, WebSocketChatState> {
  final List<String> _messages = [];
  late WebSocketChannel _channel;
  // String websocketUrl = 'ws://192.168.53.150:4500';
  String websocketUrl = 'wss://localhost:4500';

  // String websocketUrl = 'http://192.168.53.150:4500';

  ChatBloc() : super(WebSocketInitialState()) {
    on<ConnectWebSocketEvent>((event, emit) {
      _channel = WebSocketChannel.connect(Uri.parse(websocketUrl));
      _channel.stream.listen((message) {
        debugPrint("flutter log--->$message");
        message.add(ReceiveMessageEvent(message));
      });
      emit(WebSocketConnectedState());
    });

    on<DisconnectWebSocket>((event, emit) {
      _disconnect();
      emit(WebSocketDisconnectedState());
    });

    on<SendMessageEvent>((event, emit) {
      _channel.sink.add(event.message);
    });

    on<ReceiveMessageEvent>((event, emit) {
      _messages.add(event.message);
      emit(WebSocketMessageReceivedState(List.from(_messages)));
    });
  }

  void _disconnect() {
    if (_channel != null) {
      _channel.sink.close();
    }
  }

  @override
  Future<void> close() {
    _disconnect();
    return super.close();
  }
}
