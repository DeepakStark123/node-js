import 'package:chat_app_with_nodejs/chat_bloc/chat_bloc.dart';
import 'package:chat_app_with_nodejs/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  @override
  Widget build(BuildContext context) {
    var chatBloc = BlocProvider.of<ChatBloc>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Chat App')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: chatBloc.nameController,
              decoration: InputDecoration(
                hintText: 'Enter your name',
                border: const OutlineInputBorder(),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ElevatedButton(
                    child: const Text("Save"),
                    onPressed: () {
                      if (chatBloc.nameController.text.isNotEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Name Saved"),
                          duration: Duration(seconds: 2),
                        ));
                        chatBloc.username = chatBloc.nameController.text.trim();
                      }
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(child: BlocBuilder<ChatBloc, WebSocketChatState>(
            builder: (context, state) {
              if (state is WebSocketInitialState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is WebSocketMessageReceivedState) {
                debugPrint("message receive on frountend");
                return ListView.builder(
                    itemCount: state.messagesList.length,
                    itemBuilder: (context, index) {
                      var messageData = state.messagesList[index];
                      return ListTile(
                        title: Text(messageData.message),
                        subtitle: Text(
                            '${messageData.userName} - ${messageData.dateTime}'),
                      );
                    });
              }
              return const SizedBox();
            },
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: chatBloc.messageController,
                    decoration: const InputDecoration(
                      hintText: 'Enter your message',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    chatBloc.add(SendMessageEvent(
                        chatModel: ChatModel(
                      message: chatBloc.messageController.text,
                      userName: chatBloc.username,
                    )));
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
