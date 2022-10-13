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
  });

  factory chatBubble.fromMap(Map<String, dynamic> input) => chatBubble(
        message: input["message"],
        id: input["id"].toString(),
      );

  String message;
  String id;

  Map<String, dynamic> toJson() => {
        "message": message,
        "id": id,
      };

  String getMessage() {
    return message;
  }

  String getID() {
    return id;
  }
}
