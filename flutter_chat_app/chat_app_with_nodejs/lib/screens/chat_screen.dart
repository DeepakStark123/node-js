import 'package:chat_app_with_nodejs/chat_bloc/chat_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Chat App')),
      body: BlocBuilder<ChatBloc, WebSocketChatState>(
        builder: (context, state) {
          if (state is WebSocketMessageReceivedState) {
            return ListView.builder(
              itemCount: state.messages.length,
              itemBuilder: (context, index) => ListTile(
                title: Text(state.messages[index]),
              ),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          BlocProvider.of<ChatBloc>(context)
              .add(SendMessageEvent('Hello from Bloc!'));
        },
        tooltip: 'Send Message',
        child: const Icon(Icons.send),
      ),
    );
  }
}
