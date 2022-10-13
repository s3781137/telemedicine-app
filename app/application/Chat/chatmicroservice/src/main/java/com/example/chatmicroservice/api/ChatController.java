package com.example.chatmicroservice.api;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.Payload;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.example.chatmicroservice.model.ChatMessage;
import com.example.chatmicroservice.model.ChatNotification;
import com.example.chatmicroservice.model.MessageStatus;
import com.example.chatmicroservice.service.ChatMessageService;
import com.example.chatmicroservice.service.ChatRoomService;



@RestController
@RequestMapping("/chat")
 public class ChatController {

    @Autowired private SimpMessagingTemplate messagingTemplate;
    @Autowired private ChatMessageService chatMessageService;
    @Autowired private ChatRoomService chatRoomService;

    @PostMapping("/send")
    public ResponseEntity<?> sendMessage(@RequestBody ChatMessage chatMessage) {
        // var chatId = chatRoomService
        //         .getChatId(chatMessage.getSenderId(), chatMessage.getRecipientId());
        // chatMessage.setChatId(chatId.get());

        ChatMessage saved = chatMessageService.save(chatMessage);
        messagingTemplate.convertAndSendToUser(
                Integer.toString(chatMessage.getRecipientId()),"/queue/messages",
                new ChatNotification(
                        saved.getId(),
                        saved.getSenderId(),
                        saved.getSenderName()));
        
        return new ResponseEntity<>("message sent", HttpStatus.OK);
    }

    @GetMapping("/list")
    public List<ChatMessage> getPatients() {
        return chatMessageService.findAll();
    }


    @GetMapping("/messageCount")
    public ResponseEntity<Long> messageCount(
            @RequestParam int senderId,
            @RequestParam int recipientId,
            @RequestParam MessageStatus status //RECEIVED
            ) {

        return ResponseEntity
                .ok(chatMessageService.countNewMessages(senderId, recipientId, status));
    }

    @GetMapping("/findMessages") //{senderId}/{recipientId}
    public ResponseEntity<?> findMessage ( @RequestParam int senderId,
                                                @RequestParam int recipientId) {
        return ResponseEntity
                .ok(chatMessageService.findChatMessages(senderId, recipientId));

        //return new ResponseEntity<>("okay", HttpStatus.OK);
    }

//     @GetMapping("/messages")
//     public ResponseEntity<?> findMessage ( @RequestParam int id) {
//         return ResponseEntity
//                 .ok(chatMessageService.findById(id));    
//     }
 }

