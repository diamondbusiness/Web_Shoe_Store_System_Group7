package entity;

import java.util.List;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Inheritance(strategy = InheritanceType.JOINED)
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class User {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int userID;

    private String fullName;
    private String phone;
    private boolean active;

    @OneToOne(mappedBy = "user",cascade = CascadeType.ALL)
    private Chat chat;

    @OneToOne(cascade = CascadeType.ALL, orphanRemoval = true)
    @JoinColumn(name = "accountID")
    private Account account;

    @OneToMany(mappedBy = "admin")
    private List<Response> responses;
}
