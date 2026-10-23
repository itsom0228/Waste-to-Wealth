<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/navbar.jsp"/>

<div class="container py-5 my-3">
    <div class="row justify-content-center">
        <div class="col-lg-5 col-md-7">
            <div class="card border-0 shadow-lg rounded-4 p-4 p-md-5 bg-white position-relative overflow-hidden">
                <div class="position-absolute top-0 start-0 w-100" style="height: 6px; background: linear-gradient(90deg, #10b981 0%, #059669 50%, #f59e0b 100%);"></div>

                <div class="text-center mb-4">
                    <div class="brand-icon-box mx-auto mb-3" style="width: 54px; height: 54px; font-size: 1.6rem;">
                        <i class="bi bi-box-arrow-in-right"></i>
                    </div>
                    <h2 class="h3 fw-bold text-dark"><spring:message code="auth.login.title"/></h2>
                    <p class="text-muted small"><spring:message code="auth.login.subtitle"/></p>
                </div>

                <!-- Registration Success Banner (Highlighting the successful registration) -->
                <c:if test="${registeredSuccess or param.registered != null}">
                    <div class="alert alert-success d-flex align-items-center gap-3 p-3 rounded-3 shadow-sm mb-4" style="background-color: #ecfdf5; border-left: 5px solid #10b981;" role="alert">
                        <i class="bi bi-check-circle-fill text-success fs-3"></i>
                        <div>
                            <div class="fw-bold text-success fs-6"><spring:message code="auth.registered.title"/></div>
                            <div class="small text-secondary"><spring:message code="auth.registered.desc"/></div>
                        </div>
                    </div>
                </c:if>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger d-flex align-items-center gap-2 py-2 mb-4" role="alert">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                        <div><c:out value="${errorMessage}"/></div>
                    </div>
                </c:if>

                <c:if test="${not empty logoutMessage}">
                    <div class="alert alert-info d-flex align-items-center gap-2 py-2 mb-4" role="alert">
                        <i class="bi bi-info-circle-fill"></i>
                        <div><c:out value="${logoutMessage}"/></div>
                    </div>
                </c:if>

                <form action="<c:url value='/login-process'/>" method="post">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                    <div class="mb-3">
                        <label for="username" class="form-label fw-semibold small text-secondary">
                            <spring:message code="auth.login.email"/>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-envelope"></i></span>
                            <input type="email" id="username" name="username" class="form-control border-start-0" placeholder="name@example.com" required autofocus>
                        </div>
                    </div>

                    <div class="mb-4">
                        <div class="d-flex justify-content-between align-items-center">
                            <label for="password" class="form-label fw-semibold small text-secondary mb-0">
                                <spring:message code="auth.login.password"/>
                            </label>
                        </div>
                        <div class="input-group mt-1">
                            <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-lock"></i></span>
                            <input type="password" id="password" name="password" class="form-control border-start-0" placeholder="••••••••" required>
                        </div>
                    </div>

                    <button type="submit" class="btn btn-wtw-primary w-100 py-2 justify-content-center fw-bold shadow-sm">
                        <i class="bi bi-box-arrow-in-right"></i> <spring:message code="auth.login.button"/>
                    </button>
                </form>

                <!-- Demo Accounts Helper -->
                <div class="mt-4 p-3 rounded-3 bg-light border text-start small">
                    <div class="fw-bold text-muted mb-2 text-uppercase d-flex justify-content-between align-items-center" style="font-size: 0.72rem; letter-spacing: 0.05em;">
                        <span><i class="bi bi-key-fill text-warning me-1"></i> Quick Test Accounts (1-Click Fill)</span>
                    </div>
                    <div class="d-flex gap-2 mb-2">
                        <button type="button" class="btn btn-sm btn-outline-success flex-fill" onclick="fillLogin('farmer@wastetowealth.com', 'Farmer@123')">
                            <i class="bi bi-person-fill"></i> Farmer
                        </button>
                        <button type="button" class="btn btn-sm btn-outline-primary flex-fill" onclick="fillLogin('buyer@wastetowealth.com', 'Buyer@123')">
                            <i class="bi bi-cart-fill"></i> Buyer
                        </button>
                        <button type="button" class="btn btn-sm btn-outline-dark flex-fill" onclick="fillLogin('admin@wastetowealth.com', 'Admin@123')">
                            <i class="bi bi-shield-lock-fill"></i> Admin
                        </button>
                    </div>
                    <div class="text-muted" style="font-size: 0.75rem;">
                        Farmer: <code>farmer@wastetowealth.com</code> | Buyer: <code>buyer@wastetowealth.com</code> | Admin: <code>admin@wastetowealth.com</code>
                    </div>
                </div>

                <script>
                    function fillLogin(email, pass) {
                        document.getElementById('username').value = email;
                        document.getElementById('password').value = pass;
                    }
                </script>

                <div class="text-center mt-4 pt-2 border-top">
                    <p class="text-muted small mb-0">
                        <spring:message code="auth.login.noAccount"/> 
                        <a href="<c:url value='/register'/>" class="fw-bold text-success text-decoration-none">
                            <spring:message code="auth.login.registerHere"/>
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
