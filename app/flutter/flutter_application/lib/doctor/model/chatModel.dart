import 'dart:convert';

class chatModel {
  chatModel();
  List<chatBubble> chats = [];

  chatModel.fromJson(String chatModelJson) {
    print(chatModelJson);
    List<dynamic> decodedChatModel = json.decode(chatModelJson);
    decodedChatModel
        .forEach((element) => {addChatMessage(chatBubble.fromMap(element))});
    print(chatToJson());
  }

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
    required this.id,
    required this.senderId,
  });

  factory chatBubble.fromMap(Map<String, dynamic> input) => chatBubble(
        message: input["message"],
        id: input["id"].toString(),
        senderId: input["senderId"].toString(),
      );

  String message;
  String id;
  String senderId;

  Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
        "senderId": senderId,
      };

  String getMessage() {
    return message;
  }

  String getID() {
    return id;
  }

  String getSenderId() {
    return senderId;
  }
}
