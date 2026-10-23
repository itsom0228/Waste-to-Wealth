<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/navbar.jsp"/>

<div class="container py-5 my-3">
    <div class="row justify-content-center">
        <div class="col-lg-6 col-md-8">
            <div class="card border-0 shadow-lg rounded-4 p-4 p-md-5 bg-white position-relative overflow-hidden">
                <div class="position-absolute top-0 start-0 w-100" style="height: 6px; background: linear-gradient(90deg, #10b981 0%, #059669 50%, #f59e0b 100%);"></div>

                <div class="text-center mb-4">
                    <div class="brand-icon-box mx-auto mb-3" style="width: 54px; height: 54px; font-size: 1.6rem;">
                        <i class="bi bi-person-plus"></i>
                    </div>
                    <h2 class="h3 fw-bold text-dark"><spring:message code="auth.register.title"/></h2>
                    <p class="text-muted small"><spring:message code="auth.register.subtitle"/></p>
                </div>

                <!-- Role Selection Toggle -->
                <div class="row g-2 mb-4">
                    <div class="col-6">
                        <button type="button" class="btn w-100 py-3 rounded-3 border ${selectedRole != 'BUYER' ? 'btn-success text-white shadow-sm' : 'btn-light text-dark'} fw-bold" id="btnRoleFarmer">
                            <i class="bi bi-person-workspace d-block fs-3 mb-1"></i>
                            <spring:message code="auth.register.farmer"/>
                        </button>
                    </div>
                    <div class="col-6">
                        <button type="button" class="btn w-100 py-3 rounded-3 border ${selectedRole == 'BUYER' ? 'btn-warning text-dark shadow-sm' : 'btn-light text-dark'} fw-bold" id="btnRoleBuyer">
                            <i class="bi bi-building d-block fs-3 mb-1"></i>
                            <spring:message code="auth.register.buyer"/>
                        </button>
                    </div>
                </div>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger d-flex align-items-center gap-2 py-2 mb-4" role="alert">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                        <div><c:out value="${errorMessage}"/></div>
                    </div>
                </c:if>

                <form action="<c:url value='/register-process'/>" method="post" id="registerForm">
                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                    <input type="hidden" name="role" id="roleInput" value="${selectedRole != null ? selectedRole : 'FARMER'}"/>

                    <div class="mb-3">
                        <label for="fullName" class="form-label fw-semibold small text-secondary">
                            <spring:message code="auth.register.fullName"/> <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-person"></i></span>
                            <input type="text" id="fullName" name="fullName" class="form-control border-start-0" placeholder="e.g. Ramesh Patil" value="${user != null ? user.fullName : ''}" required>
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label for="email" class="form-label fw-semibold small text-secondary">
                                <spring:message code="auth.register.email"/> <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-envelope"></i></span>
                                <input type="email" id="email" name="email" class="form-control border-start-0" placeholder="ramesh@example.com" value="${user != null ? user.email : ''}" required>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="mobileNumber" class="form-label fw-semibold small text-secondary">
                                <spring:message code="auth.register.phone"/> <span class="text-danger">*</span>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-telephone"></i></span>
                                <input type="tel" id="mobileNumber" name="mobileNumber" class="form-control border-start-0" placeholder="9876543210" value="${user != null ? user.mobileNumber : ''}" required>
                            </div>
                        </div>
                    </div>

                    <div class="row g-3 mb-3">
                        <div class="col-md-6">
                            <label for="district" class="form-label fw-semibold small text-secondary">
                                <spring:message code="auth.register.district"/>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-geo-alt"></i></span>
                                <input type="text" id="district" name="district" class="form-control border-start-0" placeholder="e.g. Pune / Nashik" value="${user != null ? user.district : ''}">
                            </div>
                        </div>
                        <div class="col-md-6">
                            <label for="village" class="form-label fw-semibold small text-secondary">
                                <spring:message code="auth.register.village"/>
                            </label>
                            <div class="input-group">
                                <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-house"></i></span>
                                <input type="text" id="village" name="village" class="form-control border-start-0" placeholder="e.g. Baramati" value="${user != null ? user.village : ''}">
                            </div>
                        </div>
                    </div>

                    <div class="mb-4">
                        <label for="password" class="form-label fw-semibold small text-secondary">
                            <spring:message code="auth.register.password"/> <span class="text-danger">*</span>
                        </label>
                        <div class="input-group">
                            <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-lock"></i></span>
                            <input type="password" id="password" name="password" class="form-control border-start-0" placeholder="••••••••" minlength="6" required>
                        </div>
                        <div class="form-text small text-muted">Minimum 6 characters.</div>
                    </div>

                    <button type="submit" class="btn btn-wtw-primary w-100 py-3 justify-content-center fw-bold shadow-sm">
                        <i class="bi bi-check-circle"></i> <spring:message code="auth.register.button"/>
                    </button>
                </form>

                <div class="text-center mt-4 pt-2 border-top">
                    <p class="text-muted small mb-0">
                        <spring:message code="auth.register.hasAccount"/> 
                        <a href="<c:url value='/login'/>" class="fw-bold text-success text-decoration-none">
                            <spring:message code="auth.register.loginHere"/>
                        </a>
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById('btnRoleFarmer').addEventListener('click', function () {
        document.getElementById('roleInput').value = 'FARMER';
        this.className = 'btn w-100 py-3 rounded-3 border btn-success text-white shadow-sm fw-bold';
        document.getElementById('btnRoleBuyer').className = 'btn w-100 py-3 rounded-3 border btn-light text-dark fw-bold';
    });
    document.getElementById('btnRoleBuyer').addEventListener('click', function () {
        document.getElementById('roleInput').value = 'BUYER';
        this.className = 'btn w-100 py-3 rounded-3 border btn-warning text-dark shadow-sm fw-bold';
        document.getElementById('btnRoleFarmer').className = 'btn w-100 py-3 rounded-3 border btn-light text-dark fw-bold';
    });
</script>

<jsp:include page="../common/footer.jsp"/>
