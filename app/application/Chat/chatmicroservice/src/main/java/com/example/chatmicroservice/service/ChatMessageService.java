package com.example.chatmicroservice.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.example.chatmicroservice.exceptions.ResourceNotFoundException;
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

    //saves a chat message
    public ChatMessage save(ChatMessage chatMessage) {
        chatMessage.setStatus(MessageStatus.RECEIVED);
        repository.save(chatMessage);
        return chatMessage;
    }

    //lists chat messages
    public List<ChatMessage> findAll() {
        return repository.findAll();
    }


    //counts the number of messages betwen two people form the database
    public long countNewMessages(int senderId, int recipientId, MessageStatus status) {
        return repository.countBySenderIdAndRecipientIdAndStatus(
                senderId, recipientId, MessageStatus.RECEIVED);
    }

    //lists the chat messages between two people
    public List<ChatMessage> findChatMessages(int senderId, int recipientId) {

        List<ChatMessage> messages = repository.findChat(senderId, recipientId);
        if(messages.size() > 0) {

        }

        return messages;
    }

    //finds a chat message by an id
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

    //updates the status of a message
    public void updateStatuses(MessageStatus status, int senderId, int recipientId) {
        
        repository.updateDetails(status, senderId, recipientId);
    }

    
}
