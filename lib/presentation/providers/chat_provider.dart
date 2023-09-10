import 'package:flutter/material.dart';
import 'package:yes_no_maybe/config/helpers/get_yes_no_answer.dart';
import 'package:yes_no_maybe/domain/entities/message.dart';

class ChatProvider extends ChangeNotifier {
  final ScrollController chatScrollController = ScrollController();
  final GetYesNoAnswer getYesNoAnswer = GetYesNoAnswer();

  List<Message> messages = [
    Message(text: 'Hola payaso', fromWho: FromWho.me),
    Message(text: 'Te pitieaste al mongolito?', fromWho: FromWho.me),
    Message(
        text: 'Keti',
        fromWho: FromWho.his,
        imageUrl:
            'https://yesno.wtf/assets/no/3-80a6f5b5d6684674bcfeda34accca4e1.gif')
  ];

  Future<void> sendMessage(String text) async {
    if (text.isEmpty) return;
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messages.add(newMessage);

    if (text.endsWith('?')) {
      await hisReply();
    }
    notifyListeners(); // notifica un cambio al watch de chat_screen
    moveScrollToBottom();
  }

  Future<void> hisReply() async {
    final hisMessage = await getYesNoAnswer.getAnswer();
    messages.add(hisMessage);
    notifyListeners();

    moveScrollToBottom();
  }

  Future<void> moveScrollToBottom() async {
    await Future.delayed(const Duration(milliseconds: 100));

    chatScrollController.animateTo(
        chatScrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut);
  }
}
