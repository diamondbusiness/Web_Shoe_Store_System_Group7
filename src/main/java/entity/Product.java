package entity;

import dto.ProductDTO;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.time.LocalDateTime;
import java.util.Base64;
import java.util.List;
import java.util.stream.Collectors;

@Entity
@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class Product {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int productID;

    private String productName;
    private double price;

    @Lob
    private byte[] image;

    private String color;
    private int size;
    private boolean status;
    private String description;

    @OneToOne(mappedBy = "product", cascade = CascadeType.ALL, orphanRemoval = true, fetch = FetchType.EAGER)
    private Review review;

    @OneToMany(mappedBy = "product") // tham chieu den "product" trong cardItem
    private List<CartItem> orders;

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
    private List<OrderItem> orderItems;

    private LocalDateTime createDate;

    @ManyToOne
    @JoinColumn(name = "categoryID", nullable = true)
    private Category category;

    @OneToMany(mappedBy = "product", fetch = FetchType.LAZY)
    private List<PromotionProduct> promotionProducts;

    // Phương thức ánh xạ từ Product sang ProductDTO
    public ProductDTO toDTO() {
        return new ProductDTO(
                this.productID,
                this.productName,
                this.price,
                0,
                this.image,
                this.color,
                this.size,
                this.status,
                this.description,
                this.createDate,
                null,
                null,
                null,
                this.promotionProducts != null ? this.promotionProducts.stream().map(PromotionProduct::toDTO).collect(Collectors.toList()) : null,
                0,
                this.review != null ? this.review.toDTO() : null
        );
    }
}
