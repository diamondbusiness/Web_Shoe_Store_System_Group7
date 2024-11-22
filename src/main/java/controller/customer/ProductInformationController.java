package controller.customer;

import dto.ProductDTO;
import dto.ReviewDTO;
import entity.Product;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import service.IProductService;
import service.IReviewService;
import service.Impl.ProductServiceImpl;
import service.Impl.ReviewServiceImpl;

import java.io.IOException;
import java.util.Base64;
import java.util.List;


@WebServlet(urlPatterns = {"/product/details"})
public class ProductInformationController extends HttpServlet {
    private IProductService productService = new ProductServiceImpl();
    private IReviewService reviewService = new ReviewServiceImpl();
    public void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String productName  = "A";
        if (productName == null || productName.trim().isEmpty()) {
            req.setAttribute("error", "Tên sản phẩm không hợp lệ.");
            return;
        }

        // Lấy thông tin sản phẩm từ cơ sở dữ liệu
        List<ProductDTO> productDetails = productService.findByName(productName);

        if (productDetails == null || productDetails.isEmpty()) {
//            req.setAttribute("error", "Không tìm thấy sản phẩm.");
//            req.getRequestDispatcher("/error.jsp").forward(req, resp);
            resp.getWriter().print("Không tìm thấy sản phẩm");
        } else {
            List<String> images = productDetails.stream()
                    .map(ProductDTO::getBase64Image)
                    .filter(image -> image != null)
                    .distinct()
                    .toList();

            List<String> colors = productDetails.stream()
                    .map(ProductDTO::getColor)
                    .filter(color -> color != null)
                    .distinct()
                    .toList();

            List<Integer> sizes = productDetails.stream()
                    .map(ProductDTO::getSize)
                    .distinct()
                    .sorted()
                    .toList();

            List<Integer> IDs = productDetails.stream()
                    .map(ProductDTO::getProductId)
                    .distinct().toList();
            List<ReviewDTO> reviews = reviewService.getReviewsByProductID(IDs);

            if(reviews == null || reviews.isEmpty()) {
                req.setAttribute("errorReview", "Không có đánh giá.");

            }else{
                req.setAttribute("reviews", reviews);
            }

            List<ProductDTO> RecommendProducts = productService.findRandomProducts(1, 20, productName);
            req.setAttribute("RecommendProducts", RecommendProducts);




            // Truyền dữ liệu sang JSP
            req.setAttribute("images", images);
            req.setAttribute("colors", colors);
            req.setAttribute("sizes", sizes);
            req.setAttribute("price", productDetails.getFirst().getPrice());
            req.setAttribute("name", productDetails.getFirst().getProductName());
            req.setAttribute("description", productDetails.getFirst().getDescription());
            req.getRequestDispatcher("/ProductInformation.jsp").forward(req, resp);
        }

    }

    public void destroy() {
    }
}