package com.example.adminmicroservice.repository;

import org.springframework.data.mongodb.repository.MongoRepository;

import com.example.adminmicroservice.model.ChatRoom;

import java.util.Optional;

public interface ChatRoomRepository extends MongoRepository<ChatRoom, String> {
    Optional<ChatRoom> findBySenderIdAndRecipientId(String senderId, String recipientId);
}
