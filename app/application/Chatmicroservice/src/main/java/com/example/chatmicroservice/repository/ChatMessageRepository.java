package com.example.chatmicroservice.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.example.chatmicroservice.model.ChatMessage;
import com.example.chatmicroservice.model.MessageStatus;

import java.util.List;

@Repository
public interface ChatMessageRepository extends JpaRepository<ChatMessage, Integer> {

        @Query("SELECT count(b) FROM ChatMessage b WHERE b.senderId = ?1 and b.recipientId = ?2 and b.status = ?3 ")
        long countBySenderIdAndRecipientIdAndStatus(@Param("senderId") int senderId,
        @Param("recipientId") int recipientId, 
        @Param("status") MessageStatus status);


        @Query("SELECT count(b) FROM ChatMessage b WHERE b.chatId = ?1")
        List<ChatMessage> findByChatId(@Param("chatId") int chatId);

        @Query("UPDATE ChatMessage SET senderId = ?1, recipientId = ?2, status = ?3 ")
        void updateDetails(
            @Param("senderId") int senderId,
            @Param("recipientId") int recipientId,
            @Param("status") MessageStatus status);

        @Query("Select m FROM ChatMessage m")
        List<ChatMessage> findAll();
}
