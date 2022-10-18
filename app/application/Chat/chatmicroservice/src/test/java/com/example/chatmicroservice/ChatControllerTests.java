package com.example.chatmicroservice;


import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.annotation.Rollback;
import org.springframework.test.context.junit4.SpringRunner;

import com.example.chatmicroservice.api.*;
import com.example.chatmicroservice.config.*;
import com.example.chatmicroservice.model.*;
import com.example.chatmicroservice.repository.*;
import com.example.chatmicroservice.service.*;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.mock.mockito.MockBean;


@SpringBootTest
public class ChatControllerTests {

    @Autowired
    ChatMessageService chatMessageService;

    @Autowired
    ChatRoomService chatRoomService;

    @Test
    public void testSendMessage() throws RuntimeException{
        ChatMessage cm = new ChatMessage(78, 67, 67, "Aishwarya", "Jimin", "park jimin", MessageStatus.RECEIVED);
        Assertions.assertNotNull(chatMessageService.save(cm));
    }

    @Test
    public void testListMessages() throws RuntimeException{
        ChatMessage cm = new ChatMessage(30, 36, 39, "Aishwarya", "Jimin", "park jimin", MessageStatus.RECEIVED);
        chatMessageService.save(cm);
        Assertions.assertNotNull(chatMessageService.findAll());
    }

    @Test
    public void testCountMessage() throws RuntimeException{
        ChatMessage cm = new ChatMessage(102, 103, 104, "Jungkook", "Jimin", "yo", MessageStatus.RECEIVED);
        chatMessageService.save(cm);
        Assertions.assertEquals(chatMessageService.countNewMessages(103, 104, MessageStatus.RECEIVED), 1);
    }

    @Test
    public void testFindMessage() throws RuntimeException{
        ChatMessage cm = new ChatMessage(77, 78, 79, "rm", "Jimin", "hello", MessageStatus.RECEIVED);
        chatMessageService.save(cm);
        
        Assertions.assertNotNull((chatMessageService.findChatMessages(78, 79)));

    }

    @Test
    public void testFindById() throws RuntimeException{
        ChatMessage cm = new ChatMessage(55, 71, 72, "min", "jin", "hi", MessageStatus.RECEIVED);
        chatMessageService.save(cm);
        int id =chatMessageService.findChatMessages(71, 72).get(0).getId();
        Assertions.assertNotNull(chatMessageService.findById(id));

    }


    
}
