package com.example.chatmicroservice.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;
import com.example.chatmicroservice.model.ChatRoom;
import java.util.Optional;

@Repository
public interface ChatRoomRepository extends JpaRepository<ChatRoom, Integer> {
    @Query("SELECT b FROM ChatRoom b WHERE b.senderId = ?1 and b.recipientId = ?2")
    Optional<ChatRoom> findBySenderIdAndRecipientId(@Param("senderId") int senderId, @Param("recipientId") int recipientId);
}
