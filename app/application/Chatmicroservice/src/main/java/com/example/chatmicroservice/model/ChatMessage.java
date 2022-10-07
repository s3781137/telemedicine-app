package com.example.chatmicroservice.model;

import java.util.Date;
import javax.persistence.*;

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
   private String recipientName;
   private String content;
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
