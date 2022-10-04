package com.example.chatmicroservice.model;

import org.springframework.data.annotation.Id;
import java.util.Date;
import javax.persistence.*;

@Entity
@Table(name = "ChatMessage")
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
   private Date timestamp;
   private MessageStatus status;

   public void setStatus(MessageStatus received) {
      this.status = received;
   }

   public int getId(){
      return id;
   }

   public String getSenderName(){
      return senderName;
   }

   public int getSenderId() {
      return senderId;
   }

   public int getRecipientId() {
      return recipientId;
   }

   public void setChatId(int chatId){
      this.chatId = chatId;
   }


}
