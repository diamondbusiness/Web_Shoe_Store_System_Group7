<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 11/21/2024
  Time: 5:07 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<script>

    function filterProductsByName() {
        const searchText = document.querySelector('.text-Name').value.toLowerCase(); // Lấy giá trị từ ô tìm kiếm
        const productList = document.querySelectorAll('.col'); // Lấy danh sách sản phẩm

        productList.forEach(product => {
            const productName = product.querySelector('.shoe-name').textContent.toLowerCase(); // Lấy tên sản phẩm
            if (productName.includes(searchText)) {
                product.style.display = 'block'; // Hiển thị nếu khớp
            } else {
                product.style.display = 'none'; // Ẩn nếu không khớp
            }
        });
    }

    // const products = ["Adidas", "Nike", "Asia", "AlphaBounce", "Puma", "Vans"];
    const products = [
        <c:forEach var="product" items="${products}" varStatus="status">
        "${product.productName}"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    // Hàm lấy gợi ý

    function fetchSuggestions(searchText) {
        const suggestionsBox = document.getElementById('suggestions');
        const filteredProducts = products.filter(product =>
            product.toLowerCase().startsWith(searchText.toLowerCase()) // Kiểm tra chữ cái đầu tiên
        );

        // Xóa các gợi ý cũ
        suggestionsBox.innerHTML = '';

        if (searchText && filteredProducts.length > 0) {
            filteredProducts.forEach(product => {
                const suggestionItem = document.createElement('div');
                suggestionItem.textContent = product;
                suggestionItem.classList.add('suggestion-item');
                suggestionItem.onclick = () => selectSuggestion(product);
                suggestionsBox.appendChild(suggestionItem);
            });
            suggestionsBox.style.display = 'block'; // Hiển thị danh sách gợi ý
        } else {
            suggestionsBox.style.display = 'none'; // Ẩn nếu không có gợi ý
        }
    }

    // Hàm chọn gợi ý
    function selectSuggestion(product) {
        document.querySelector('.text-Name').value = product; // Điền vào ô tìm kiếm
        document.getElementById('suggestions').style.display = 'none'; // Ẩn gợi ý
        filterProductsByName(); // Gọi hàm lọc sản phẩm
    }

    document.addEventListener('DOMContentLoaded', () => {
        // Xử lý sự kiện nhấp ra ngoài để đóng danh sách gợi ý
        document.addEventListener('click', (event) => {
            const suggestionsBox = document.getElementById('suggestions');
            const searchInput = document.querySelector('.text-Name');
            if (!suggestionsBox.contains(event.target) && !searchInput.contains(event.target)) {
                suggestionsBox.style.display = 'none'; // Ẩn danh sách gợi ý
            }
        });
    });
</script>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/ProductInCategory.css">
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
</head>

<body>
<div id="header">

    <form id="searchForm" onsubmit="event.preventDefault();" style="display: inline;">
        <input type="text" name="textName" class="text-Name" placeholder="Tìm kiếm tên giày" oninput="fetchSuggestions(this.value)">
        <div id="suggestions" class="suggestions-list" style="display: none;"></div>
        <!-- Begin: Search Icon -->
        <div class="search-btn" style="height: 100%; display: flex; align-items: center;">
            <i class="fa-solid fa-magnifying-glass" style="color:white; cursor: pointer;" onclick="filterProductsByName()"></i>
        </div>
        <!-- End: Search Icon -->
    </form>


</div>
<div id="main">
    <div class="content-section">
        <h2 class="section-heading text-black">${categoryName}</h2>
        <h2 class="shoe-quantity text-black">Số lượng: </h2>


        <div class="row shoes-list">
            <c:forEach var="product" items="${products}">
                <div class="col col-third">
                    <img src="${product.getBase64Image()}" alt="Shoe" class="shoe-img">
                    <div class="shoe-body">
                        <h2 class="shoe-name">${product.productName}</h2>
                        <p class="shoe-price">Price: ${product.price}$</p>
                        <p class="shoe-color">Color: ${product.color}</p>
                        <p class="shoe-size">Size: ${product.size}</p>
                        <button class="btn js-delete-product-from-category">Xóa sản phẩm</button>
                    </div>
                </div>
            </c:forEach>



        </div>
    </div>
</div>
</body>

</html>