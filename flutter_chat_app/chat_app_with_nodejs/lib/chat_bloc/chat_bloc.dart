// import 'dart:async';
import 'package:chat_app_with_nodejs/models/chat_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, WebSocketChatState> {
  TextEditingController messageController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final String serverUrl = 'http://192.168.2.32:4500';
  final List<ChatModel> messagesList = [];
  io.Socket? socket;
  String username = "DemoUser";

  ChatBloc() : super(WebSocketInitialState()) {
    socket = io.io(
      serverUrl,
      OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .setTimeout(3000)
          .setReconnectionDelay(5000)
          .build(),
    );
    //------------WebSocket---Events--------------
    //---connect--
    socket!.onConnecting((data) => add(WebSocketConnectingEvent()));
    socket!.onConnect((_) => add(WebSocketConnectEvent()));
    //---dis-connect--
    socket!.onDisconnect((_) => add(WebSocketOnDisconnectEvent()));
    //---timeout---
    socket!.onConnectTimeout((data) => add(WebSocketOnTimeOutEvent()));
    //---Error---
    socket!.onConnectError((data) => add(WebSocketOnConnectErrorEvent()));
    socket!.onError((data) => add(WebSocketOnErrorEvent()));
    //---Join---
    socket!.on('joined', (data) => add(WebSocketOnJoinedEvent()));
    socket!.on('receive_message', (data) {
      debugPrint("Receive message event===> $data");
      add(ReceiveMessageEvent(
        chatModel: ChatModel(
            message: data['message'],
            userName: data['username'],
            dateTime: data['dateTime']),
      ));
    });

    //------------WebSocket---States--------------

    //-------Connect-State----
    on<WebSocketConnectingEvent>((event, emit) {
      debugPrint("Websocket connecting...");
    });

    on<WebSocketConnectEvent>((event, emit) {
      socket!.connect();
      emit(WebSocketConnectedState());
    });

    on<WebSocketOnJoinedEvent>((event, emit) {
      emit(WebSocketConnectedState());
    });

    //-------Disconnect-State----
    on<WebSocketDisconnectEvent>((event, emit) {
      debugPrint("Websocket disconnected...");
      socket!.disconnect();
    });

    on<WebSocketOnDisconnectEvent>((event, emit) {
      debugPrint("Websocket disconnected");
      socket!.dispose();
      emit(WebSocketDisconnectedState());
    });

    //-------Error-State------
    on<WebSocketOnErrorEvent>((event, emit) {
      debugPrint("Websocket disconnected");
      emit(
          const WebSocketConnectionErrorState(message: "Something went wrong"));
    });

    on<WebSocketOnConnectErrorEvent>((event, emit) {
      debugPrint("Websocket disconnected");
      emit(
          const WebSocketConnectionErrorState(message: "Something went wrong"));
    });

    on<WebSocketOnTimeOutEvent>((event, emit) {
      debugPrint("Websocket disconnected");
      emit(const WebSocketConnectionErrorState(
          message: "Websocket timeout error"));
    });

    //--Send-Message-To-Web-Socket---
    on<SendMessageEvent>((event, emit) {
      ChatModel chatData = event.chatModel;
      if (chatData.message.isNotEmpty && socket != null) {
        debugPrint('send_message --> ${chatData.message}');
        socket!.emit('send_message', {
          'message': chatData.message.trim(),
          'username': event.chatModel.userName,
          'dateTime': DateTime.now().toString(),
        });
        messageController.clear();
      }
    });
    //--On-Receive-Message-From-Web-Socket---
    on<ReceiveMessageEvent>((event, emit) {
      ChatModel chatData = event.chatModel;
      debugPrint('Receive message ==> ${chatData.message}');
      messagesList.add(chatData);
      debugPrint("messagesList=> $messagesList");
      emit(WebSocketMessageReceivedState(messagesList: messagesList));
    });
  }
}
