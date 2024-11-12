package dao.Impl;

import JpaConfig.JpaConfig;
import dao.IOrderDao;
import dto.OrderDTO;
import dto.OrderItemDTO;
import entity.*;
import enums.OrderStatus;
import enums.PaymentMethod;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class OrderImpl implements IOrderDao {
    public boolean CreateOrder(OrderDTO order){
        EntityManager entityManager = JpaConfig.getEmFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        transaction.begin();
        try{
            Customer customer = entityManager.find(Customer.class,Integer.valueOf(order.getCustomer().getUserID()));
            List<OrderItemDTO> ListOrderItem = order.getOrderItems();
            List<OrderItem> orderItems = new ArrayList<OrderItem>();
            Order orderEnty = new Order();
            orderEnty.setOrderId(order.getOrderId());
            orderEnty.setCustomer(customer);
            orderEnty.setOrderDate(Date.from(Instant.now()));
            orderEnty.setOrderStatus(OrderStatus.WAITING_CONFIRMATION);
            entityManager.persist(orderEnty);
            for (OrderItemDTO item : ListOrderItem) {
                OrderItem orderItem = new OrderItem();
                Product product = entityManager.find(Product.class,item.getProductDTO().getProductId());
                orderItem.setOrder(orderEnty);
                orderItem.setProduct(product);
                orderItem.setQuantity(item.getQuantity());
                entityManager.persist(orderItem);
                orderItems.add(orderItem);
            }

            Payment payment = new Payment();
            payment.setPaymentDate(Date.from(Instant.now()));
            payment.setPaymentMethod(PaymentMethod.MOMO);
            payment.setAmount(order.getPayment().getAmount());
            payment.setStatus(true);
            entityManager.persist(payment);

            orderEnty.setPayment(payment);
            orderEnty.setOrderItems(orderItems);
            payment.setOrder(orderEnty);

            transaction.commit();
        } catch (Exception e) {
            e.printStackTrace();
            transaction.rollback();
            return false;
        }
        return true;
    }
}
