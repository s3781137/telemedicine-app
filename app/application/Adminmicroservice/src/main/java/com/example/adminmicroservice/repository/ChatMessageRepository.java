package com.example.adminmicroservice.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;

// import org.springframework.data.mongodb.repository.MongoRepository;

import com.example.adminmicroservice.model.ChatMessage;
import com.example.adminmicroservice.model.MessageStatus;

import java.util.List;

@Repository
public interface ChatMessageRepository extends JpaRepository<ChatMessage, Integer> {

        @Query("SELECT count(*) FROM ChatMessage WHERE senderId = ?1, recipientId = ?2, status = ?3 ")
        long countBySenderIdAndRecipientIdAndStatus(@Param("senderId") int senderId,
        @Param("recipientId") int recipientId, 
        @Param("status") MessageStatus status);


        @Query("SELECT count(*) FROM ChatMessage WHERE chatId = ?1")
        List<ChatMessage> findByChatId(@Param("chatId") int chatId);

        @Query("UPDATE ChatMessage SET senderId = ?1, recipientId = ?2, status = ?3 ")
        void updateDetails(
            @Param("senderId") int senderId,
            @Param("recipientId") int recipientId,
            @Param("status") MessageStatus status);
}
