package com.example.chatmicroservice.model;

import javax.persistence.Entity;
import javax.persistence.Table;

@Entity
@Table(name = "ChatNotification")
public class ChatNotification {

    private int id;
    private int senderId;
    private String senderName;

    public ChatNotification(int id, int senderId, String senderName){
        this.id = id;
        this.senderId = senderId;
        this.senderName = senderName;
    }

}