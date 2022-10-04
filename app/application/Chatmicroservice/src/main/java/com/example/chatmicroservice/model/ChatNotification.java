package com.example.chatmicroservice.model;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "ChatNotification")
public class ChatNotification {
    private String id;
    private String senderId;
    private String senderName;
}