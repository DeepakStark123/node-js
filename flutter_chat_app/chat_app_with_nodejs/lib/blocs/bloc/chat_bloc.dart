import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final List<String> _messages = [];
  late WebSocketChannel _channel;

  ChatBloc() : super(ChatInitialState()) {
    on<ConnectWebSocketEvent>((event, emit) {
      _channel = WebSocketChannel.connect(Uri.parse('http://192.168.2.32:4500'));
      _channel.stream.listen((message) {
        message.add(ReceiveMessageEvent(message));
      });
      emit(ChatConnectedState());
    });

    on<DisconnectWebSocket>((event, emit) {
      _disconnect();
      emit(ChatDisconnectedState());
    });

    on<SendMessageEvent>((event, emit) {
      _channel.sink.add(event.message);
    });

    on<ReceiveMessageEvent>((event, emit) {
      _messages.add(event.message);
      emit(ChatMessageReceivedState(List.from(_messages)));
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
