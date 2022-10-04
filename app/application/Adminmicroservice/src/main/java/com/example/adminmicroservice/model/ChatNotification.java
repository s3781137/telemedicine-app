package com.example.adminmicroservice.model;

import javax.persistence.Entity;
import javax.persistence.Table;

// import lombok.AllArgsConstructor;
// import lombok.Builder;
// import lombok.Data;
// import lombok.NoArgsConstructor;

// @Data
// @AllArgsConstructor
// @NoArgsConstructor
// @Builder

@Entity
@Table(name = "ChatNotification")
public class ChatNotification {
    private String id;
    private String senderId;
    private String senderName;
}