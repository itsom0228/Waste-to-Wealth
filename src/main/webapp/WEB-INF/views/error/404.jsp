<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/navbar.jsp"/>

<div class="container py-5 my-5 text-center">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card border-0 shadow-sm p-4 rounded-4 bg-white">
                <div class="text-warning display-1 mb-3">
                    <i class="bi bi-search"></i>
                </div>
                <h2 class="h3 fw-bold text-dark mb-2">Listing or Page Not Found (404)</h2>
                <p class="text-muted mb-4">
                    <c:out value="${errorMessage != null ? errorMessage : 'The requested agricultural waste listing or page does not exist or has been removed.'}"/>
                </p>
                <div class="d-flex justify-content-center gap-2">
                    <a href="<c:url value='/marketplace'/>" class="btn btn-wtw-primary">
                        <i class="bi bi-grid"></i> Browse Marketplace
                    </a>
                    <a href="<c:url value='/'/>" class="btn btn-wtw-secondary">
                        <i class="bi bi-house-door"></i> Return Home
                    </a>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
