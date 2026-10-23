<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/navbar.jsp"/>

<div class="container py-5 my-5 text-center">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card border-0 shadow-sm p-4 rounded-4">
                <div class="text-danger display-1 mb-3">
                    <i class="bi bi-shield-lock-fill"></i>
                </div>
                <h2 class="h3 fw-bold text-dark mb-2">Access Forbidden (403)</h2>
                <p class="text-muted mb-4">
                    You do not have the required role or authorization to access this protected area.
                </p>
                <div class="d-flex justify-content-center gap-2">
                    <a href="<c:url value='/'/>" class="btn btn-wtw-primary">
                        <i class="bi bi-house-door"></i> Return to Home
                    </a>
                    <a href="<c:url value='/login'/>" class="btn btn-wtw-secondary">
                        <i class="bi bi-box-arrow-in-right"></i> Sign In
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
