package com.example.adminmicroservice.model;

// import lombok.AllArgsConstructor;
// import lombok.Builder;
// import lombok.Data;
// import lombok.NoArgsConstructor;
import org.springframework.data.annotation.Id;
import java.util.Date;
import javax.persistence.*;
// @Data
// @AllArgsConstructor
// @NoArgsConstructor
// @Builder
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
}
