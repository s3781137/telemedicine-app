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

import com.example.chatmicroservice.exceptions.ResourceNotFoundException;
import com.example.chatmicroservice.model.ChatMessage;
import com.example.chatmicroservice.model.ChatNotification;
import com.example.chatmicroservice.model.MessageStatus;
import com.example.chatmicroservice.service.ChatMessageService;
import com.example.chatmicroservice.service.ChatRoomService;

@RestController
@RequestMapping("/chat")
public class ChatController {

    @Autowired
    private SimpMessagingTemplate messagingTemplate;
    @Autowired
    private ChatMessageService chatMessageService;
    @Autowired
    private ChatRoomService chatRoomService;

    //send a message to a reciever from a sender
    @PostMapping("/send")
    public ResponseEntity<?> sendMessage(@RequestBody ChatMessage chatMessage) {
        try {
            // var chatId = chatRoomService
            // .getChatId(chatMessage.getSenderId(), chatMessage.getRecipientId());
            // chatMessage.setChatId(chatId.get());

            ChatMessage saved = chatMessageService.save(chatMessage);
            messagingTemplate.convertAndSendToUser(
                    Integer.toString(chatMessage.getRecipientId()), "/queue/messages",
                    new ChatNotification(
                            saved.getId(),
                            saved.getSenderId(),
                            saved.getSenderName()));

            return new ResponseEntity<>("message sent", HttpStatus.OK);
        } catch (Exception e) {
            throw new ResourceNotFoundException("error sending message");
        }
    }

    //list all the messages in the databsase
    @GetMapping("/list")
    public List<ChatMessage> getMessages() {
        try {
            return chatMessageService.findAll();
        } catch (Exception e) {
            throw new ResourceNotFoundException("messages not found");
        }
    }

    //count the number of messages between two people
    @GetMapping("/messageCount")
    public ResponseEntity<Long> messageCount(@RequestParam int senderId, @RequestParam int recipientId,
            @RequestParam MessageStatus status)// RECEIVED) {
    {
        try {

            return ResponseEntity.ok(chatMessageService.countNewMessages(senderId, recipientId, status));
        } catch (Exception e) {
            throw new ResourceNotFoundException("chat not found");
        }
    }

    //finds all the messages between a sender and a reciever
    @GetMapping("/findMessages") // {senderId}/{recipientId}
    public ResponseEntity<?> findMessage(@RequestParam int senderId, @RequestParam int recipientId) {
        try {
            return ResponseEntity.ok(chatMessageService.findChatMessages(senderId, recipientId));
        } catch (Exception e) {
            throw new ResourceNotFoundException("chat not found");
        }
        // return new ResponseEntity<>("okay", HttpStatus.OK);
    }

    //finds a message by the message id
    @GetMapping("/messages")
    public ResponseEntity<?> findMessage(@RequestParam int id) {
        return ResponseEntity
                .ok(chatMessageService.findById(id));

    }

}
