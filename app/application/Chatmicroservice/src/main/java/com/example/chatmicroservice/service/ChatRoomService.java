// package com.example.chatmicroservice.service;


// import org.springframework.beans.factory.annotation.Autowired;
// import org.springframework.stereotype.Service;
// import com.example.chatmicroservice.model.ChatRoom;
// import com.example.chatmicroservice.repository.ChatRoomRepository;

// import java.util.Optional;

// @Service
// public class ChatRoomService {

//     @Autowired private ChatRoomRepository chatRoomRepository;

//     public Optional<Integer> getChatId(int senderId, int recipientId, boolean createIfNotExist) {

//          return chatRoomRepository
//                 .findBySenderIdAndRecipientId(senderId, recipientId)
//                 .map(ChatRoom::getChatId).or(() -> {
//                     if(!createIfNotExist) {
//                         return  Optional.empty();
//                     }
//                      //var chatId = String.format("%s_%s", senderId, recipientId);

//                      int chatId = Integer.parseInt(Integer.toString(senderId) + Integer.toString(recipientId));

//                     ChatRoom senderRecipient = new ChatRoom(chatId, senderId, recipientId);
                
//                     ChatRoom recipientSender = new ChatRoom(chatId, recipientId, senderId);

//                     chatRoomRepository.save(senderRecipient);
//                     chatRoomRepository.save(recipientSender);

//                     return Optional.of(chatId);
//                 });
//     }
// }
