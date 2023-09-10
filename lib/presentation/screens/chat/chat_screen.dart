import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yes_no_maybe/domain/entities/message.dart';
import 'package:yes_no_maybe/presentation/providers/chat_provider.dart';
import 'package:yes_no_maybe/presentation/widgets/chat/his_message_bubble.dart';
import 'package:yes_no_maybe/presentation/widgets/chat/my_message_bubble.dart';
import 'package:yes_no_maybe/presentation/widgets/shared/message_field_box.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: const Padding(
            padding: EdgeInsets.all(4.0),
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                  'https://styles.redditmedia.com/t5_5btkc6/styles/profileIcon_x4iob8nj9bz71.jpg?width=256&height=256&frame=1&auto=webp&crop=256:256,smart&s=3fa624491e1004b4f6ccc8237749fbcb9526d109'),
            ),
          ),
          title: const Text('Senpai'),
          centerTitle: false,
        ),
        body: _ChatView());
  }
}

class _ChatView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ChatProvider>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                  controller: chatProvider.chatScrollController,
                  itemCount: chatProvider.messages.length,
                  itemBuilder: (context, index) {
                    final message = chatProvider.messages[index];
                    return (message.fromWho == FromWho.his)
                        ? HisMessageBubble(
                            message: message,
                          )
                        : MyMessageBubble(message: message);
                  }),
            ),

            /// Caja de Texto
            MessageFieldBox(
                onValue: (value) => chatProvider.sendMessage(value)),
          ],
        ),
      ),
    );
  }
}
