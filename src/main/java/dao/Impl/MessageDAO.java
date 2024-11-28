package dao.Impl;

import JpaConfig.JpaConfig;
import dao.IMessageDAO;
import entity.Message;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;

import java.sql.Timestamp;
import java.util.List;

public class MessageDAO implements IMessageDAO {

    @Override
    public void saveMessage(Message message) {
        EntityManager entityManager = JpaConfig.getEmFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.persist(message);
            transaction.commit();
        } catch (Exception e) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Message> getMessages(int chatId, Timestamp lastMessageTimestamp) {
        EntityManager entityManager = JpaConfig.getEmFactory().createEntityManager();
        try {
            String jpql = "SELECT m FROM Message m WHERE m.chat.chatID = :chatId AND m.date < :lastMessageTimestamp ORDER BY m.date DESC";
            TypedQuery<Message> query = entityManager.createQuery(jpql, Message.class);
            query.setParameter("chatId", chatId);
            query.setParameter("lastMessageTimestamp", lastMessageTimestamp);
            query.setMaxResults(10);
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }

    @Override
    public List<Message> getRecentMessages(int chatId) {
        EntityManager entityManager = JpaConfig.getEmFactory().createEntityManager();
        try {
            String jpql = "SELECT m FROM Message m WHERE m.chat.chatID = :chatId ORDER BY m.date DESC";
            TypedQuery<Message> query = entityManager.createQuery(jpql, Message.class);
            query.setParameter("chatId", chatId);
            query.setMaxResults(15);
            return query.getResultList();
        } finally {
            entityManager.close();
        }
    }
}
