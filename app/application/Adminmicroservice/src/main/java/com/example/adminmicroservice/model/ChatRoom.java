package com.example.adminmicroservice.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Table;

// import lombok.AllArgsConstructor;
// import lombok.Builder;
// import lombok.Data;
// import lombok.NoArgsConstructor;
 import org.springframework.data.annotation.Id;
// import org.springframework.data.mongodb.core.mapping.Document;

// @Data
// @AllArgsConstructor
// @NoArgsConstructor
// @Builder
// @Document
@Entity
@Table(name = "ChatRoom")
public class ChatRoom {


   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private int chatId;
    private int senderId;
    private int recipientId;
}
