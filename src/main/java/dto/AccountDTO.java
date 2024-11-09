package dto;
import enums.AuthProvider;
import enums.RoleType;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
public class AccountDTO {
    private int accountID;

    private String email;
    private String password;

    private AuthProvider authProvider;

    private String providerID;

    private RoleType role;

    private UserDTO user;

}