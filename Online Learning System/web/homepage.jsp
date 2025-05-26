<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>homePage</title>
        <!-- Thêm bootstrap ở đây -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/css/bootstrap.min.css"
              integrity="sha512-jnSuA4Ss2PkkikSOLtYs8BlYIeeIK1h99ty4YfvRPAlzr377vr3CXDb7sb7eEEBYjDtcYj+AjBH3FLv5uSJuXg=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/5.3.3/js/bootstrap.min.js"
                integrity="sha512-ykZ1QQr0Jy/4ZkvKuqWn4iF3lqPZyij9iRv6sGqLRdTPkY69YX6+7wvVGmsdBbiIfN/8OdsI7HABjvEok6ZopQ=="
        crossorigin="anonymous" referrerpolicy="no-referrer"></script>
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" rel="stylesheet" />
    </head>
    <body>
        <!-- Header -->

        <!-- Content -->
        <div class="container row mb-5 mx-auto">
            <!-- Left side -->
            <div class="col-md-9">
                <!-- Slider -->
                <div id="slider" class="carousel slide mt-3" data-bs-ride="carousel">
                    <div class="carousel-indicators">
                        <button type="button" data-bs-target="#slider" data-bs-slide-to="0" class="active"></button>
                        <button type="button" data-bs-target="#slider" data-bs-slide-to="1"></button>
                        <button type="button" data-bs-target="#slider" data-bs-slide-to="2"></button>
                    </div>
                    <div class="carousel-inner">
                        <!-- slider item 1 -->
                        <div class="carousel-item active">
                            <a href="khoa-hoc-1.jsp">
                                <img src="images/slider1.jpg" class="d-block w-100" alt="First slide">
                                <div class="carousel-caption d-none d-md-block text-lg-left">
                                    <h5>Data Science</h5>
                                    <p>Master data analysis and machine learning.</p>
                                </div>
                            </a>
                        </div>
                        <!-- slider item 2 -->
                        <div class="carousel-item" href="khoa-hoc-1.jsp">
                            <a href="khoa-hoc-1.jsp">
                                <img src="images/slider2.jpg" class="d-block w-100" alt="Second slide">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>Web Development</h5>
                                    <p>Build modern and responsive websites.</p>
                                </div>
                            </a>
                        </div>
                        <!-- slider item 3 -->
                        <div class="carousel-item" href="khoa-hoc-1.jsp">
                            <a href="khoa-hoc-1.jsp">
                                <img src="images/slider3.jpg" class="d-block w-100" alt="Third slide">
                                <div class="carousel-caption d-none d-md-block">
                                    <h5>Mobile Development</h5>
                                    <p>Create powerful mobile applications.</p>
                                </div>
                            </a>
                        </div>
                        <!-- Slider controls -->
                        <a class="carousel-control-prev" type="button" data-bs-target="#slider" data-bs-slide="prev">
                            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        </a>
                        <a class="carousel-control-next" type="button" data-bs-target="#slider" data-bs-slide="next">
                            <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        </a>
                    </div>
                    <!-- End of slider-->
                </div>
                <!-- Hot posts -->
                <div class="mb-5 mt-5" id="hot-posts">
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="section-title h3 fw-bold">Hot Posts</h2>
                        <a href="blogList.jsp" class="text-decoration-none text-primary mb-1">View All</a>
                        <!-- Link to blog list page --------------------------------------------------------------------------------------------------------------------------------------------->
                    </div>
                    <div class="row row-cols-md-3 g-4">
                        <div class="col">
                            <a href="#" class="text-decoration-none text-dark">
                                <!--link........................................................................................-->
                                <div class="card shadow h-100">
                                    <img src="images/1.jpg" class="img-fluid p-3" style="height: 200px; object-fit: cover;"
                                         alt="Example image">
                                    <div class="card-body">
                                        <h5 class=" card-title">How to Start a Career in Data Science</h5>
                                        <p class="text-muted small mb-2">
                                            <i class="far fa-calendar-alt me-1"></i> June 10, 2023
                                        </p>
                                        <p class="card-text text-muted">A comprehensive guide to launching your
                                            career
                                            in the exciting field of data science.</p>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col">
                            <a href="#" class="text-decoration-none text-dark">
                                <!--link........................................................................................-->
                                <div class="card shadow h-100">
                                    <img src="images/1.jpg" class="img-fluid p-3" style="height: 200px; object-fit: cover;"
                                         alt="Example image">
                                    <div class="card-body">
                                        <h5 class=" card-title">How to Start a Career in Data Science</h5>
                                        <p class="text-muted small mb-2">
                                            <i class="far fa-calendar-alt me-1"></i> June 10, 2023
                                        </p>
                                        <p class="card-text text-muted">A comprehensive guide to launching your
                                            career
                                            in the exciting field of data science.</p>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col">
                            <a href="#" class="text-decoration-none text-dark">
                                <!--link........................................................................................-->
                                <div class="card shadow h-100">
                                    <img src="images/1.jpg" class="img-fluid p-3" style="height: 200px; object-fit: cover;"
                                         alt="Example image">
                                    <div class="card-body">
                                        <h5 class=" card-title">How to Start a Career in Data Science</h5>
                                        <p class="text-muted small mb-2">
                                            <i class="far fa-calendar-alt me-1"></i> June 10, 2023
                                        </p>
                                        <p class="card-text text-muted">A comprehensive guide to launching your
                                            career
                                            in the exciting field of data science.</p>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
                <!-- Featured subjects -->
                <div>
                    <div class="d-flex justify-content-between align-items-center mb-4">
                        <h2 class="section-title h3 fw-bold">Featured Subjects</h2>
                        <a href="#" class="text-decoration-none text-primary">View All</a>
                    </div>
                    <div class="row row-cols-md-3 g-4">
                        <div class="col">
                            <a href="#" class="text-decoration-none text-dark">
                                <div class="card shadow">
                                    <!--image-->
                                    <div class="p-3">
                                        <img src="images/image1.jpg" class="img-fluid w-100"
                                             style="height: 200px; object-fit: cover; border-radius: 15px;"
                                             alt="Featured subject image">
                                        <!-- tagline -->
                                        <span class="badge bg-info text-white position-absolute top-0 start-0 m-2">
                                            Người mới bắt đầu
                                        </span>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title mb-3">How to Start a Career in Data Science</h5>
                                        <!-- xem khóa học và số bài học -->
                                        <div class="d-flex align-items-center">
                                            <a href="#" class="btn btn-outline-info me-2">View Course</a>
                                            <div class="ms-auto text-end d-flex align-items-center">
                                                <i class="fas fa-file-alt me-1"></i>1 Lectures
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col">
                            <a href="#" class="text-decoration-none text-dark">
                                <div class="card shadow">
                                    <!--image-->
                                    <div class="p-3">
                                        <img src="images/image1.jpg" class="img-fluid w-100"
                                             style="height: 200px; object-fit: cover; border-radius: 15px;"
                                             alt="Featured subject image">
                                        <!-- tagline -->
                                        <span class="badge bg-info text-white position-absolute top-0 start-0 m-2">
                                            Người mới bắt đầu
                                        </span>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title mb-3">How to Start a Career in Data Science</h5>
                                        <!-- xem khóa học và số bài học -->
                                        <div class="d-flex align-items-center">
                                            <a href="#" class="btn btn-outline-info me-2">View Course</a>
                                            <div class="ms-auto text-end d-flex align-items-center">
                                                <i class="fas fa-file-alt me-1"></i>1 Lectures
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="col">
                            <a href="#" class="text-decoration-none text-dark">
                                <div class="card shadow">
                                    <!--image-->
                                    <div class="p-3">
                                        <img src="images/image1.jpg" class="img-fluid w-100"
                                             style="height: 200px; object-fit: cover; border-radius: 15px;"
                                             alt="Featured subject image">
                                        <!-- tagline -->
                                        <span class="badge bg-info text-white position-absolute top-0 start-0 m-2">
                                            Người mới bắt đầu
                                        </span>
                                    </div>
                                    <div class="card-body">
                                        <h5 class="card-title mb-3">How to Start a Career in Data Science</h5>
                                        <!-- xem khóa học và số bài học -->
                                        <div class="d-flex align-items-center">
                                            <a href="#" class="btn btn-outline-info me-2">View Course</a>
                                            <div class="ms-auto text-end d-flex align-items-center">
                                                <i class="fas fa-file-alt me-1"></i>1 Lectures
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <!-- Featured subjects end -->
                    </div>
                </div>
            </div>
            <!-- Right side -->
            <div class="col-md-3">
                <div class="card shadow">
                    <div class="card-body">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h3 class="card-title h4 fw-bold">Latest Posts</h3>
                            <!-- Link to latest posts page .........................................................-->
                        </div>
                        <div class="latest-posts">
                            <a href="#" class="text-decoration-none text-dark">
                                <!--link........................................................................................-->
                                <div class="d-flex mb-5">
                                    <div class="w-25 rounded me-3 overflow-hidden flex-shrink-0">
                                        <img src="images/image1.jpg" alt="JavaScript" class="w-100 h-100 latest-post-img">
                                    </div>
                                    <!-- Nội dung bài viết -->
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1">JavaScript Fundamentals Every Developer Should Know</h6>
                                        <p class="text-muted small mb-0">
                                            <i class="far fa-calendar-alt me-1"></i> June 18, 2023
                                        </p>
                                    </div>
                                </div>
                            </a>
                            <a href="#" class="text-decoration-none text-dark">
                                <!--link........................................................................................-->
                                <div class="d-flex mb-5">
                                    <div class="w-25 rounded me-3 overflow-hidden flex-shrink-0">
                                        <img src="images/image1.jpg" alt="JavaScript" class="w-100 h-100 latest-post-img">
                                    </div>
                                    <!-- Nội dung bài viết -->
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1">JavaScript Fundamentals Every Developer Should Know</h6>
                                        <p class="text-muted small mb-0">
                                            <i class="far fa-calendar-alt me-1"></i> June 18, 2023
                                        </p>
                                    </div>
                                </div>
                            </a>
                            <a href="#" class="text-decoration-none text-dark">
                                <!--link........................................................................................-->
                                <div class="d-flex mb-5">
                                    <div class="w-25 rounded me-3 overflow-hidden flex-shrink-0">
                                        <img src="images/image1.jpg" alt="JavaScript" class="w-100 h-100 latest-post-img">
                                    </div>
                                    <!-- Nội dung bài viết -->
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1">JavaScript Fundamentals Every Developer Should Know</h6>
                                        <p class="text-muted small mb-0">
                                            <i class="far fa-calendar-alt me-1"></i> June 18, 2023
                                        </p>
                                    </div>
                                </div>
                            </a>
                            <a href="#" class="text-decoration-none text-dark">
                                <!--link........................................................................................-->
                                <div class="d-flex mb-5">
                                    <div class="w-25 rounded me-3 overflow-hidden flex-shrink-0">
                                        <img src="images/image1.jpg" alt="JavaScript" class="w-100 h-100 latest-post-img">
                                    </div>
                                    <!-- Nội dung bài viết -->
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1">JavaScript Fundamentals Every Developer Should Know</h6>
                                        <p class="text-muted small mb-0">
                                            <i class="far fa-calendar-alt me-1"></i> June 18, 2023
                                        </p>
                                    </div>
                                </div>
                            </a>
                            <a href="#" class="text-decoration-none text-dark">
                                <!--link........................................................................................-->
                                <div class="d-flex mb-5">
                                    <div class="w-25 rounded me-3 overflow-hidden flex-shrink-0">
                                        <img src="images/image1.jpg" alt="JavaScript" class="w-100 h-100 latest-post-img">
                                    </div>
                                    <!-- Nội dung bài viết -->
                                    <div class="flex-grow-1">
                                        <h6 class="mb-1">JavaScript Fundamentals Every Developer Should Know</h6>
                                        <p class="text-muted small mb-0">
                                            <i class="far fa-calendar-alt me-1"></i> June 18, 2023
                                        </p>
                                    </div>
                                </div>
                            </a>
                            <!-- button see all-->
                            <div class="text-center mb-2">
                                <button class="btn mt-3 px-3" style="background-color: #e0e0e0; color: #000;"
                                        onclick="window.location.href = 'blogList.jsp'">
                                    See All
                                </button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card shadow mt-4">
                    <div class="card-body">
                        <h3 class="card-title h5 fw-bold mb-3">Contact Us</h3>
                        <div class="list-unstyled" style="text-decoration: none; color: #000;">
                            <div class="d-flex mt-3 mb-3">
                                <span class="contact-icon px-2 pt-1"><i class="fas fa-map-marker-alt"></i></span>
                                <span> 123 Hoa Lac, Thach That, Ha Noi, 600000</span>
                            </div>
                            <div class="d-flex mb-3">
                                <span class="contact-icon px-2 pt-1"><i class="fas fa-phone-alt"></i></span>
                                <span>+84 (0) 123 456 789</span>
                            </div>
                            <div class="d-flex mb-3">
                                <span class="contact-icon px-2 pt-1"><i class="fas fa-envelope"></i></span>
                                <span>sonnhhe189023@fpt.edu.vn</span>
                            </div>
                            <div class="d-flex mb-3">
                                <span class="contact-icon px-2 pt-1"><i class="fas fa-clock"></i></span>
                                <div class="mb-2">
                                    <p class="mb-1">Monday - Friday: 7.30am - 5pm</p>
                                    <p class="mb-0">Saturday - Sunday: Closed</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!-- End of all-->
        </div>
    </body>
</html>
