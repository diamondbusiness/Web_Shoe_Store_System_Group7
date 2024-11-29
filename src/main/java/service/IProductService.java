package service;

import dto.ProductDTO;
import entity.Product;

import java.util.List;
import java.util.Map;

public interface IProductService {
    List<ProductDTO> findAllWithPagination(int offset, int limit);
    List<ProductDTO> findByName(String name);
    List<ProductDTO> findRandomProducts(int offset, int limit, String CurrentProductName);
    List<String> getDistinctProductNames();
    List<String> getListNameProductForPromotion(int promotionId);
}
