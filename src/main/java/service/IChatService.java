package service;

import dto.ChatDTO;
import dto.MessageDTO;
import entity.Chat;
import jakarta.websocket.Session;

import java.util.List;

public interface IChatService {
    ChatDTO getOrCreateChatId(int userId);
}
