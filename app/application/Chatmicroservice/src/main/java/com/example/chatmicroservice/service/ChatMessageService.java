package com.example.chatmicroservice.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.chatmicroservice.exception.ResourceNotFoundException;
import com.example.chatmicroservice.model.ChatMessage;
import com.example.chatmicroservice.model.MessageStatus;
import com.example.chatmicroservice.repository.ChatMessageRepository;

import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

@Service
public class ChatMessageService {
    @Autowired private ChatMessageRepository repository;
    @Autowired private ChatRoomService chatRoomService;

    public ChatMessage save(ChatMessage chatMessage) {
        chatMessage.setStatus(MessageStatus.RECEIVED);
        repository.save(chatMessage);
        return chatMessage;
    }

    public List<ChatMessage> findAll() {
        return repository.findAll();
    }


    public long countNewMessages(int senderId, int recipientId, MessageStatus status) {
        return repository.countBySenderIdAndRecipientIdAndStatus(
                senderId, recipientId, MessageStatus.RECEIVED);
    }

    public List<ChatMessage> findChatMessages(int senderId, int recipientId) {
        //Optional<Integer> chatId = chatRoomService.getChatId(senderId, recipientId, false);

        // List messages =
        //         chatId.map(cId -> repository.findByChatId(senderId, recipientId)).orElse(new ArrayList<>());

        List<ChatMessage> messages = repository.findChat(senderId, recipientId);
        if(messages.size() > 0) {
          //  updateStatuses(MessageStatus.DELIVERED, senderId, recipientId);
        }

        return messages;
    }

    public ChatMessage findById(int id) {
        return repository
                .findById(id)
                .map(chatMessage -> {
                    chatMessage.setStatus(MessageStatus.DELIVERED);
                    return repository.save(chatMessage);
                })
                .orElseThrow(() ->
                        new ResourceNotFoundException("can't find message (" + id + ")"));
    }

    public void updateStatuses(MessageStatus status, int senderId, int recipientId) {
        
        repository.updateDetails(status, senderId, recipientId);
    }

    
}
