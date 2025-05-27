<%@ page pageEncoding="UTF-8" %>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css">

<nav class="navbar navbar-expand-lg navbar-light bg-light">
    <div class="container-fluid" style="background-color: white"> 
        <a href="index.jsp" style="align-content: center">
            <img style="width: 110px; height: 60px" 
                 src="images/logo.png"  alt="Logo">
        </a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav ml-auto">
                <li class="nav-item active">
                    <a class="nav-link" href="index.jsp"><i class="fa fa-home"></i> Trang chủ</a>
                </li>
                <li class="nav-item active">
                    <a class="nav-link" href="pagination">Các khóa học</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="cart.jsp">
                        <i class="bi bi-cart"></i>
                        <span class="badge badge-danger">
                            ${(cart_list.size()>0)?cart_list.size():0}
                        </span>
                    </a>
                </li>
                <%
                    if (auth!=null) {
                %>
                <li class="nav-item">
                    <a class="nav-link" href="orders.jsp">Đơn hàng</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="logout">Đăng xuất</a>
                </li>
                <%
                    } else {
                %>
                <li class="nav-item">
                    <a class="nav-link" href="login.jsp"> <i class="fa fa-user"></i> Tài khoản</a>
                </li>

                <%
                    }
                %>
            </ul>
        </div>
    </div>
</nav>