package com.example.chatmicroservice.model;

import java.util.Date;
import javax.persistence.*;


import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Column;

@Table(name = "ChatMessage")
@Entity
public class ChatMessage {
   @Id
   @GeneratedValue(strategy = GenerationType.IDENTITY)
   private int id;
   //@Column(name = "chatId")
   private int chatId;
   //@Column(name = "senderId")
   private int senderId;
   //@Column(name = "recipientId")
   private int recipientId;
  // @Column(name = "senderName")
   private String senderName;
   @Column(name = "recipientName")
   private String recipientName;
   @Column(name = "message")
   private String message;
   @Column(name = "status")
   private MessageStatus status;

   public void setStatus(MessageStatus received) {
      this.status = received;
   }

   public int getId() {
      return id;
   }

   public String getSenderName() {
      return senderName;
   }

   public int getSenderId() {
      return senderId;
   }

   public int getRecipientId() {
      return recipientId;
   }

   public void setChatId(int chatId) {
      this.chatId = chatId;
   }

}
