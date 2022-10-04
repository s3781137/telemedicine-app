package com.example.adminmicroservice.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.Optional;


import com.example.adminmicroservice.model.ChatRoom;

import java.util.Optional;

@Repository
public interface ChatRoomRepository extends JpaRepository<ChatRoom, Integer> {
    @Query("SELECT * FROM ChatRoom where senderId = ?1, recipientId = ?2")
    Optional<ChatRoom> findBySenderIdAndRecipientId(@Param("senderId") int senderId, @Param("recipientId") int recipientId);
}
