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
    
}
