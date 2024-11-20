<%@ page import="service.ICategoryService" %>
<%@ page import="service.Impl.CategoryServiceImpl" %>
<%@ page import="java.util.*" %>
<%@ page import="dto.CategoryDTO" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    ICategoryService categoryService = new CategoryServiceImpl();
    List<CategoryDTO> categoryList = (List<CategoryDTO>) session.getAttribute("categoryList");

    if (categoryList == null) {
        categoryList = categoryService.listCategory();
        session.setAttribute("categoryList", categoryList);
    }
%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Shoe Store</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://unpkg.com/aos@next/dist/aos.css" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
    <link rel="stylesheet" href="./css/index.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css" integrity="sha512-KfkfwYDsLkIlwQp6LFnl8zNdLGxu9YAA1QvwINks4PhcElQSvqcyVLLD9aMhXd13uQjoXtEKNosOWaZqXgel0g==" crossorigin="anonymous" referrerpolicy="no-referrer" />
</head>

<body>
<%--Header--%>

<jsp:include page="./view/header.jsp"></jsp:include>
<%--Slider--%>
<jsp:include page="./view/slider.jsp"></jsp:include>
<!-- arrival section-->
<section class="container arrival">
    <div class="section-heading">
        <div class="heading">
            <h2 class="heading-two">new <span>arrival</span> </h2>
            <p class="sub-heading">our new collection</p>
        </div>
    </div>
    <div class="wrapper">
        <div class="col" data-aos="zoom-in-up">
            <figure>
                <img src="/image/ar1.png" alt="nike-shoe">
            </figure>
            <div class="col-body">
                <p class="rating-icon"><i class="fa-solid fa-star"></i> <span class="rating-num">4.9</span></p>
                <h3 class="heading-three">nike running</h3>
                <p class="sub-heading">air zoom pagasus</p>
                <div class="col-footer">
                    <p class="shoe-price">$350</p>
                    <button class="shoe-btn btn">Add to Cart</button>
                </div>
            </div>

        </div>

        <div class="col" data-aos="zoom-in-up">
            <figure>
                <img src="image/ar2.png" alt="nike-shoe">
            </figure>
            <div class="col-body">
                <p class="rating-icon"><i class="fa-solid fa-star"></i> <span class="rating-num">4.9</span></p>
                <h3 class="heading-three">nike running</h3>
                <p class="sub-heading">air zoom pagasus</p>
                <div class="col-footer">
                    <p class="shoe-price">$350</p>
                    <button class="shoe-btn btn">Add to Cart</button>
                </div>
            </div>

        </div>

        <div class="col" data-aos="zoom-in-up">
            <figure>
                <img src="image/ar3.png" alt="nike-shoe">
            </figure>
            <div class="col-body">
                <p class="rating-icon"><i class="fa-solid fa-star"></i> <span class="rating-num">4.9</span></p>
                <h3 class="heading-three">nike running</h3>
                <p class="sub-heading">air zoom pagasus</p>
                <div class="col-footer">
                    <p class="shoe-price">$350</p>
                    <button class="shoe-btn btn">Add to Cart</button>
                </div>
            </div>

        </div>

        <div class="col" data-aos="zoom-in-up">
            <figure>
                <img src="image/ar4.png" alt="nike-shoe">
            </figure>
            <div class="col-body">
                <p class="rating-icon"><i class="fa-solid fa-star"></i> <span class="rating-num">4.9</span></p>
                <h3 class="heading-three">nike running</h3>
                <p class="sub-heading">air zoom pagasus</p>
                <div class="col-footer">
                    <p class="shoe-price">$350</p>
                    <button class="shoe-btn btn">Add to Cart</button>
                </div>
            </div>

        </div>
    </div>
</section>
<!-- new collection -->
<section class="container collection">
    <!-- section header -->
    <div class="section-heading">
        <div class="heading">
            <p class="sub-heading">best collection</p>
            <h2 class="heading-two">our new collection</h2>
        </div>


        <div class="btn-section">
            <button class="btn-col active" data-btn="all">all</button>
            <c:forEach var="category" items="${sessionScope.categoryList}">
                <button class="btn-col" data-btn="${category.categoryId}">
                        ${category.categoryName}
                </button>
            </c:forEach>
        </div>

    </div>
    <!-- section wrapper and col -->
    <div class="grid-wrapper">
        <div class="col- collection-item" data-item="men" data-aos="zoom-in-up">
            <figure><img src="./image/pr1.png" alt=""></figure>
            <div class="col-body">
                <p class="rating-icon"><i class="fa-solid fa-star"></i> <span class="rating-num">4.9</span></p>
                <h3 class="heading-three">nike running</h3>
                <p class="sub-heading">air zoom pagasus</p>
                <div class="col-footer">
                    <p class="shoe-price">$350</p>
                    <button class="shoe-btn btn">Add to cart</button>
                </div>
            </div>
        </div>


        <div class="col- collection-item" data-item="women" data-aos="zoom-in-up">
            <figure><img src="/image/pr2.png" alt=""></figure>
            <div class="col-body">
                <p class="rating-icon"><i class="fa-solid fa-star"></i> <span class="rating-num">4.9</span></p>
                <h3 class="heading-three">nike running</h3>
                <p class="sub-heading">air zoom pagasus</p>
                <div class="col-footer">
                    <p class="shoe-price">$350</p>
                    <button class="shoe-btn btn">Add to cart</button>
                </div>
            </div>
        </div>

        <div class="col- collection-item" data-item="men" data-aos="zoom-in-up">
            <figure><img src="/image/pr3.png" alt=""></figure>
            <div class="col-body">
                <p class="rating-icon"><i class="fa-solid fa-star"></i> <span class="rating-num">4.9</span></p>
                <h3 class="heading-three">nike running</h3>
                <p class="sub-heading">air zoom pagasus</p>
                <div class="col-footer">
                    <p class="shoe-price">$350</p>
                    <button class="shoe-btn btn">Add to cart</button>
                </div>
            </div>
        </div>

        <div class="col- collection-item" data-item="sports" data-aos="zoom-in-up">
            <figure><img src="/image/pr4.png" alt=""></figure>
            <div class="col-body">
                <p class="rating-icon"><i class="fa-solid fa-star"></i> <span class="rating-num">4.9</span></p>
                <h3 class="heading-three">nike running</h3>
                <p class="sub-heading">air zoom pagasus</p>
                <div class="col-footer">
                    <p class="shoe-price">$350</p>
                    <button class="shoe-btn btn">Add to cart</button>
                </div>
            </div>
        </div>

        <div class="col- collection-item" data-item="men" data-aos="zoom-in-up">
            <figure><img src="/image/pr5.png" alt=""></figure>
            <div class="col-body">
                <p class="rating-icon"><i class="fa-solid fa-star"></i> <span class="rating-num">4.9</span></p>
                <h3 class="heading-three">nike running</h3>
                <p class="sub-heading">air zoom pagasus</p>
                <div class="col-footer">
                    <p class="shoe-price">$350</p>
                    <button class="shoe-btn btn">Add to cart</button>
                </div>
            </div>
        </div>

        <div class="col- collection-item" data-item="women" data-aos="zoom-in-up">
            <figure><img src="/image/pr6.png" alt=""></figure>
            <div class="col-body">
                <p class="rating-icon"><i class="fa-solid fa-star"></i> <span class="rating-num">4.9</span></p>
                <h3 class="heading-three">nike running</h3>
                <p class="sub-heading">air zoom pagasus</p>
                <div class="col-footer">
                    <p class="shoe-price">$350</p>
                    <button class="shoe-btn btn">Add to cart</button>
                </div>
            </div>
        </div>

        <div class="col- collection-item" data-item="sports" data-aos="zoom-in-up">
            <figure><img src="/image/pr7.png" alt=""></figure>
            <div class="col-body">
                <p class="rating-icon"><i class="fa-solid fa-star"></i> <span class="rating-num">4.9</span></p>
                <h3 class="heading-three">nike running</h3>
                <p class="sub-heading">air zoom pagasus</p>
                <div class="col-footer">
                    <p class="shoe-price">$350</p>
                    <button class="shoe-btn btn">Add to cart</button>
                </div>
            </div>
        </div>

        <div class="col- collection-item" data-item="men" data-aos="zoom-in-up">
            <figure><img src="/image/pr8.png" alt=""></figure>
            <div class="col-body">
                <p class="rating-icon"><i class="fa-solid fa-star"></i> <span class="rating-num">4.9</span></p>
                <h3 class="heading-three">nike running</h3>
                <p class="sub-heading">air zoom pagasus</p>
                <div class="col-footer">
                    <p class="shoe-price">$350</p>
                    <button class="shoe-btn btn">Add to cart</button>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- customer review -->
<section class="container testimonial">
    <div class="clr-one"></div>
    <div class="section-heading">
        <div class="heading">
            <p class="sub-heading">testimonial</p>
            <h2 class="heading-two">what our customer says</h2>
        </div>
    </div>
    <div class="wrapper">
        <div class="col" data-aos="zoom-in-up">
            <figure><img src="asses/testimonail/tes-1.png" alt=""></figure>
            <h3 class="heading-three">thor john</h3>
            <p class="testi-message">I stumbled upon this shoe website and decided to give it a try. Wow, was I
                impressed! The quality of the shoes exceeded my expectations, and the customer service was
                outstanding. I'll definitely be a repeat customer!"</p>
            <span class="ratting"><i class="fa-solid fa-star"></i> <i class="fa-solid fa-star"></i> <i
                    class="fa-solid fa-star"></i> <i class="fa-solid fa-star"></i> <i
                    class="fa-solid fa-star"></i></span>
        </div>

        <div class="col" data-aos="zoom-in-up">
            <figure><img src="asses/testimonail/tes-2.png" alt=""></figure>
            <h3 class="heading-three">john wick</h3>
            <p class="testi-message">I've been searching for the perfect pair of shoes for months, and I finally
                found them on this website. Not only are they stylish and comfortable, but the ordering process was
                seamless</p>
            <span class="ratting"><i class="fa-solid fa-star"></i> <i class="fa-solid fa-star"></i> <i
                    class="fa-solid fa-star"></i> <i class="fa-solid fa-star"></i> <i
                    class="fa-solid fa-star"></i></span>
        </div>

        <div class="col" data-aos="zoom-in-up">
            <figure><img src="asses/testimonail/tes-3.png" alt=""></figure>
            <h3 class="heading-three">James Jackie</h3>
            <p class="testi-message">I'm not one to leave reviews often, but I had to for this website. The variety
                of shoes available is fantastic, and the prices are unbeatable. Plus, the shoes I ordered arrived in
                pristine condition and fit perfectly."</p>
            <span class="ratting"><i class="fa-solid fa-star"></i> <i class="fa-solid fa-star"></i> <i
                    class="fa-solid fa-star"></i> <i class="fa-solid fa-star"></i> <i
                    class="fa-solid fa-star"></i></span>
        </div>
    </div>
</section>
<%--Footer--%>
<jsp:include page="./view/footer.jsp"></jsp:include>
<script src="./js/index.js"></script>
<script src="https://unpkg.com/aos@next/dist/aos.js"></script>
<script>
    AOS.init();
</script>

</body>

</html>