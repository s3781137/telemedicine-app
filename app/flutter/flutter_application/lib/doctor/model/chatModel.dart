import 'dart:convert';
import 'dart:ffi';

class chatModel {
  chatModel();
  chatModel.fromJson(String chatModelJson) {
    json
        .decode(chatModelJson)
        .map((x) => addChatMessage(chatBubble.fromMap(x)));
  }

  List<chatBubble> chats = [];

  void addChatMessage(chatBubble chat) {
    chats.add(chat);
  }

  String chatToJson() {
    return json.encode(List<dynamic>.from(chats.map((x) => x.toJson())));
  }

  List<chatBubble> getChats() {
    return chats;
  }
}

class chatBubble {
  chatBubble({
    required this.message,
    required this.senderName,
  });

  factory chatBubble.fromMap(Map<String, dynamic> input) => chatBubble(
        message: input["message"],
        senderName: input["senderName"],
      );

  String message;
  String senderName;

  Map<String, dynamic> toJson() => {
        "message": message,
        "senderName": senderName,
      };
}
