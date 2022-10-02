package com.example.adminmicroservice.repository;


import org.springframework.data.mongodb.repository.MongoRepository;

import com.example.adminmicroservice.model.ChatMessage;
import com.example.adminmicroservice.model.MessageStatus;

import java.util.List;

public interface ChatMessageRepository
        extends MongoRepository<ChatMessage, String> {

    long countBySenderIdAndRecipientIdAndStatus(
            String senderId, String recipientId, MessageStatus status);

    List<ChatMessage> findByChatId(String chatId);
}
