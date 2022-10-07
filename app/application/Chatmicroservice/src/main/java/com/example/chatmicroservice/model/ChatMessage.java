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
   private int chatId;
   private int senderId;
   private int recipientId;
   private String senderName;
   //@Column(name = "recipientName")
   private String recipientName;
   //@Column(name = "message")
   private String message;
   //@Column(name = "status")
   private MessageStatus status;

   public ChatMessage(int chatId, int senderId, int recipientId, String senderName,
   String recipientName, String message, MessageStatus status )
   {
      this.chatId = chatId;
      this.senderId = senderId;
      this.recipientId = recipientId;
      this.senderName = senderName;
      this.recipientName = recipientName;
      this.message = message;
      this.status = status;
   }

   public ChatMessage(){

   }

   public void setStatus(MessageStatus received) {
      this.status = received;
   }

   public int getId() {
      return id;
   }

   public String getRecipientName(){
      return recipientName;
   }

   public String getMessage(){
      return message;
   }

   public int getChatId(){
      return chatId;
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

   public MessageStatus getStatus(){
      return status;
   } 



}
