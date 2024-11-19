package dao.Impl;

import JpaConfig.JpaConfig;
import dao.IAccountDAO;
import dto.AccountDTO;
import dto.UserDTO;
import entity.Account;
import enums.AuthProvider;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;

public class AccountDaoImpl implements IAccountDAO {

    @Override
    public boolean InsertAccount(Account account) {
        EntityManager entityManager = JpaConfig.getEmFactory().createEntityManager();
        EntityTransaction transaction = entityManager.getTransaction();
        try {
            transaction.begin();
            entityManager.merge(account);
            transaction.commit();
            return true;
        } catch (Exception e){
            if(transaction.isActive()){
                transaction.rollback();
            }
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return false;
    }

    @Override
    public boolean findAccountForLogin(Account account) {
        EntityManager entityManager = JpaConfig.getEmFactory().createEntityManager();
        try {
            String jpql = "SELECT a FROM Account a WHERE a.email = :email AND a.password = :password";
            Account result = entityManager.createQuery(jpql, Account.class)
                    .setParameter("email", account.getEmail())
                    .setParameter("password", account.getPassword())
                    .getSingleResult();

            return result != null;
        } catch (jakarta.persistence.NoResultException e) {
            return false;
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return false;
    }

    @Override
    public Account findAccountByEmail(String email) {
        EntityManager entityManager = JpaConfig.getEmFactory().createEntityManager();
        try {
            String jpql = "SELECT a FROM Account a WHERE a.email = :email AND a.authProvider=:authProvider";
            Account result = entityManager.createQuery(jpql, Account.class)
                    .setParameter("email", email)
                    .setParameter("authProvider", AuthProvider.LOCAL)
                    .getSingleResult();
            return result;
        }catch (Exception e){
            e.printStackTrace();
        }finally {
            entityManager.close();
        }
        return null;
    }

    @Override
    public Account findAccountById(int accountID) {
        EntityManager entityManager = JpaConfig.getEmFactory().createEntityManager();
        try {
            String jqpl = "SELECT a FROM Account a WHERE a.accountID = :id";
            Account result = entityManager.createQuery(jqpl, Account.class)
                    .setParameter("id", accountID)
                    .getSingleResult();
            return result;

        } catch (Exception e){
            e.printStackTrace();
        } finally {
            entityManager.close();
        }
        return null;
    }

    public AccountDTO getAccoutByEmail(String email) {
        EntityManager entityManager = JpaConfig.getEmFactory().createEntityManager();
        try{
            Account account = entityManager.createQuery("select a from Account a where a.email like :email",Account.class)
                    .setParameter("email",email).getSingleResult();
            AccountDTO accountDTO = new AccountDTO();
            accountDTO.setAccountID(account.getAccountID());
            accountDTO.setEmail(account.getEmail());
            accountDTO.setRole(account.getRole());
            accountDTO.setUser(new UserDTO());
            accountDTO.getUser().setUserID(-1);
            if (account.getUser()!=null){
                accountDTO.getUser().setUserID(account.getUser().getUserID());
                accountDTO.getUser().setActive(account.getUser().isActive());
            }
            return accountDTO;
        }
        catch (Exception e){
            e.printStackTrace();
        }
        return null;
    }
}
