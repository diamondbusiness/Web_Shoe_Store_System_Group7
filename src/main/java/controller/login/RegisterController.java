package controller.login;

import Authentication.SendOTPEmail;
import dto.AccountDTO;
import dto.AddressDTO;
import dto.CustomerDTO;
import enums.AuthProvider;
import enums.RoleType;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import service.IAccountService;
import service.ICustomerService;
import service.Impl.AccountServiceImpl;
import service.Impl.CustomerServiceImpl;

import java.io.IOException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

@WebServlet({"/view/register", "/verifyOTP"})
public class RegisterController extends HttpServlet {
    private ICustomerService customerService = new CustomerServiceImpl();
    private IAccountService accountService = new AccountServiceImpl();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.setContentType("text/html;charset=UTF-8");
        String path = req.getServletPath();
        if(path.equals("/view/register")) {
            String fullName = req.getParameter("fullName");
            String phone = req.getParameter("phone");
            int day = Integer.parseInt(req.getParameter("day"));
            int month = Integer.parseInt(req.getParameter("month"));
            int year = Integer.parseInt(req.getParameter("year"));
            LocalDate localDate = LocalDate.of(year, month, day);
            int houseNumber =Integer.parseInt(req.getParameter("houseNumber")) ;
            String streetName = req.getParameter("streetName");
            String email = req.getParameter("email");

            String province = req.getParameter("province");
            String district = req.getParameter("district");
            String ward = req.getParameter("ward");
            String password = req.getParameter("password");

            CustomerDTO customerDTO = new CustomerDTO();
            if (customerDTO.getAddressDTO() == null) {
                customerDTO.setAddressDTO(new AddressDTO());
            }

            Date dateOfBirth = Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
            customerDTO.setDateOfBirth(dateOfBirth);
            customerDTO.getAddressDTO().setHouseNumber(houseNumber);
            customerDTO.getAddressDTO().setStreetName(streetName);
            customerDTO.getAddressDTO().setProvince(province);
            customerDTO.getAddressDTO().setDistrict(district);
            customerDTO.getAddressDTO().setCity(ward);
            if (customerDTO.getAccount() == null) {
                customerDTO.setAccount(new AccountDTO());
            }

            customerDTO.getAccount().setEmail(email);
            customerDTO.getAccount().setPassword(password);
            customerDTO.getAccount().setAuthProvider(AuthProvider.LOCAL);
            customerDTO.getAccount().setRole(RoleType.CUSTOMER);
            customerDTO.setFullName(fullName);
            customerDTO.setPhone(phone);
            if(accountService.findAccountByEmail(email) != null) {
                req.setAttribute("errorEmail", "Email đã tồn tại!");
                System.out.println(req.getAttribute("errorEmail"));
                req.setAttribute("customerDTO", customerDTO);
                req.getRequestDispatcher("/view/Register.jsp").forward(req, resp);
                return;
            }

            HttpSession session = req.getSession();
            session.setAttribute("customerDTO", customerDTO);

            SendOTPEmail sendOTPEmail = new SendOTPEmail();
            String code = sendOTPEmail.getRandom();
            session.setAttribute("code", code);
            sendOTPEmail.sendEmail(customerDTO.getAccount().getEmail(), code);
            resp.sendRedirect("./OTPRegister.jsp");

        } else if (path.equals("/verifyOTP")) {
            String num1 = req.getParameter("num1");
            String num2 = req.getParameter("num2");
            String num3 = req.getParameter("num3");
            String num4 = req.getParameter("num4");
            String num5 = req.getParameter("num5");
            String num6 = req.getParameter("num6");

            String number = num1 + num2 + num3 + num4 + num5 + num6;
            System.out.println(number + "qweqweqweqw");

            HttpSession session = req.getSession();
            String code = (String) session.getAttribute("code");
            CustomerDTO customerDTO = (CustomerDTO) session.getAttribute("customerDTO");

            if(code.equals(number) ) {
                session.removeAttribute("code");
                try {
                    if (!customerService.insertCustomer(customerDTO)) {

                        req.setAttribute("errorEmail", "Dang ky tài khoan khong thanh cong!");
                        System.out.println(req.getAttribute("errorEmail"));
                        req.setAttribute("customerDTO", customerDTO);
                        req.getRequestDispatcher("/view/Register.jsp").forward(req, resp);
                        return;
                    }
                    resp.sendRedirect("/view/login.jsp");
                } catch (Exception e) {
                    System.out.println(e.getMessage());
                    req.setAttribute("errorMessage", "Đã xảy ra lỗi. Vui lòng thử lại!");
                    req.setAttribute("customerDTO", customerDTO);
                    req.getRequestDispatcher("/view/Register.jsp").forward(req, resp);
                }
            }
        }
    }
}
