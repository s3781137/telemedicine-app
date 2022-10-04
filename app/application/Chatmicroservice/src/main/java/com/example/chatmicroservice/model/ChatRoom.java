package com.example.chatmicroservice.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Table;

import org.springframework.data.annotation.Id;

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
