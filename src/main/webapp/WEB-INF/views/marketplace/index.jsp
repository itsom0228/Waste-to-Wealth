<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/navbar.jsp"/>

<!-- Marketplace Header Banner -->
<div class="py-4" style="background: linear-gradient(135deg, #064e3b 0%, #065f46 50%, #047857 100%); color: #ffffff;">
    <div class="container">
        <div class="row align-items-center">
            <div class="col-lg-8">
                <span class="badge bg-warning text-dark px-3 py-1 rounded-pill fw-semibold mb-2">Live Marketplace</span>
                <h1 class="h2 fw-bold text-white mb-2"><spring:message code="marketplace.title"/></h1>
                <p class="text-white-50 mb-0"><spring:message code="marketplace.subtitle"/></p>
            </div>
            <div class="col-lg-4 text-lg-end mt-3 mt-lg-0">
                <a href="<c:url value='/register?role=FARMER'/>" class="btn btn-light text-dark fw-semibold shadow-sm">
                    <i class="bi bi-plus-circle text-success me-1"></i> <spring:message code="btn.listWaste"/>
                </a>
            </div>
        </div>
    </div>
</div>

<!-- Search & Filter Controls -->
<div class="container py-4">
    <div class="card border-0 shadow-sm rounded-4 p-3 mb-4 bg-white">
        <form action="<c:url value='/marketplace'/>" method="get" class="row g-3 align-items-end">
            <!-- Keyword Search -->
            <div class="col-lg-4 col-md-6">
                <label for="keyword" class="form-label small fw-semibold text-secondary mb-1"><spring:message code="marketplace.search.label"/></label>
                <div class="input-group">
                    <span class="input-group-text bg-light border-end-0 text-muted"><i class="bi bi-search"></i></span>
                    <input type="text" id="keyword" name="keyword" class="form-control border-start-0" placeholder="e.g. Wheat straw, Nashik, Baled..." value="<c:out value='${currentKeyword}'/>">
                </div>
            </div>

            <!-- Waste Category Filter -->
            <div class="col-lg-2 col-md-3 col-6">
                <label for="category" class="form-label small fw-semibold text-secondary mb-1"><spring:message code="marketplace.category.label"/></label>
                <select id="category" name="category" class="form-select">
                    <option value="ALL"><spring:message code="marketplace.category.all"/></option>
                    <c:forEach var="cat" items="${categories}">
                        <option value="<c:out value='${cat}'/>" ${currentCategory == cat ? 'selected' : ''}><c:out value="${cat}"/></option>
                    </c:forEach>
                </select>
            </div>

            <!-- District Filter -->
            <div class="col-lg-2 col-md-3 col-6">
                <label for="district" class="form-label small fw-semibold text-secondary mb-1"><spring:message code="marketplace.district.label"/></label>
                <select id="district" name="district" class="form-select">
                    <option value="ALL"><spring:message code="marketplace.district.all"/></option>
                    <c:forEach var="dist" items="${districts}">
                        <option value="<c:out value='${dist}'/>" ${currentDistrict == dist ? 'selected' : ''}><c:out value="${dist}"/></option>
                    </c:forEach>
                </select>
            </div>

            <!-- Sort By -->
            <div class="col-lg-2 col-md-4 col-6">
                <label for="sortBy" class="form-label small fw-semibold text-secondary mb-1"><spring:message code="marketplace.sort.label"/></label>
                <select id="sortBy" name="sortBy" class="form-select">
                    <option value="newest" ${currentSortBy == 'newest' ? 'selected' : ''}><spring:message code="marketplace.sort.newest"/></option>
                    <option value="price_asc" ${currentSortBy == 'price_asc' ? 'selected' : ''}><spring:message code="marketplace.sort.priceAsc"/></option>
                    <option value="price_desc" ${currentSortBy == 'price_desc' ? 'selected' : ''}><spring:message code="marketplace.sort.priceDesc"/></option>
                    <option value="quantity_desc" ${currentSortBy == 'quantity_desc' ? 'selected' : ''}><spring:message code="marketplace.sort.qtyDesc"/></option>
                </select>
            </div>

            <!-- Filter Buttons -->
            <div class="col-lg-2 col-md-4 col-6 d-flex gap-2">
                <button type="submit" class="btn btn-wtw-primary w-100 justify-content-center">
                    <i class="bi bi-funnel"></i> <spring:message code="btn.filter"/>
                </button>
                <a href="<c:url value='/marketplace'/>" class="btn btn-outline-secondary" title="Clear Filters">
                    <i class="bi bi-arrow-counterclockwise"></i>
                </a>
            </div>
        </form>
    </div>

    <!-- Results Header -->
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h5 class="fw-bold mb-0 text-dark">Available Crop Residue Lots</h5>
            <small class="text-muted">Showing <strong><c:out value="${totalResults}"/></strong> verified farm listings</small>
        </div>
        <div class="d-none d-md-flex gap-2">
            <span class="badge bg-success-subtle text-success border border-success-subtle px-3 py-2 rounded-pill">
                <i class="bi bi-shield-check"></i> Quality Guaranteed
            </span>
            <span class="badge bg-warning-subtle text-warning-emphasis border border-warning-subtle px-3 py-2 rounded-pill">
                <i class="bi bi-truck"></i> Farm Gate Pickup
            </span>
        </div>
    </div>

    <!-- Empty State -->
    <c:if test="${empty listings}">
        <div class="card border-0 shadow-sm rounded-4 p-5 text-center bg-white my-4">
            <div class="display-3 text-muted mb-3"><i class="bi bi-inbox"></i></div>
            <h4 class="fw-bold text-dark">No Listings Found Matching Your Criteria</h4>
            <p class="text-muted">Try adjusting your keyword, expanding your district radius, or clearing category filters.</p>
            <div class="mt-3">
                <a href="<c:url value='/marketplace'/>" class="btn btn-wtw-primary">
                    <i class="bi bi-arrow-repeat"></i> Reset All Filters
                </a>
            </div>
        </div>
    </c:if>

    <!-- Listings Grid -->
    <div class="row g-4">
        <c:forEach var="item" items="${listings}">
            <div class="col-lg-4 col-md-6">
                <div class="card border-0 shadow-sm rounded-4 h-100 overflow-hidden bg-white transition-all hover-shadow">
                    <!-- Image Box with Badges -->
                    <div class="position-relative" style="height: 220px; overflow: hidden; background-color: #f1f5f9;">
                        <img src="<c:url value='${item.imagePath}'/>" alt="<c:out value='${item.title}'/>" class="w-100 h-100 object-fit-cover" onerror="this.src='https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=600&auto=format&fit=crop&q=80'">
                        <span class="badge position-absolute top-0 start-0 m-3 px-3 py-2 rounded-pill bg-dark bg-opacity-75 text-white fw-medium">
                            <i class="bi bi-tag-fill text-warning me-1"></i> <c:out value="${item.wasteCategory}"/>
                        </span>
                        <span class="badge position-absolute top-0 end-0 m-3 px-2 py-1 rounded-pill bg-success text-white small">
                            <i class="bi bi-check-circle-fill"></i> Verified
                        </span>
                    </div>

                    <!-- Card Body -->
                    <div class="card-body p-4 d-flex flex-column">
                        <div class="mb-2">
                            <small class="text-muted d-flex align-items-center gap-1 mb-1">
                                <i class="bi bi-geo-alt-fill text-danger"></i> <c:out value="${item.village}"/>, <c:out value="${item.district}"/>, <c:out value="${item.state}"/>
                            </small>
                            <h5 class="card-title fw-bold text-dark mb-2">
                                <a href="<c:url value='/marketplace/listing/${item.id}'/>" class="text-dark text-decoration-none hover-primary">
                                    <c:out value="${item.title}"/>
                                </a>
                            </h5>
                            <p class="card-text text-muted small line-clamp-2 mb-3">
                                <c:out value="${item.description}"/>
                            </p>
                        </div>

                        <!-- Quantity & Price Matrix -->
                        <div class="p-3 rounded-3 mb-3 mt-auto" style="background-color: var(--color-primary-50); border: 1px solid var(--color-primary-100);">
                            <div class="row g-2 text-center">
                                <div class="col-6 border-end">
                                    <span class="d-block text-muted small">Available</span>
                                    <strong class="text-dark fs-6"><c:out value="${item.availableQuantity}"/> <c:out value="${item.unit}"/></strong>
                                </div>
                                <div class="col-6">
                                    <span class="d-block text-muted small">Price / <c:out value="${item.unit}"/></span>
                                    <strong class="text-success fs-6">&#8377; <c:out value="${item.pricePerUnit}"/></strong>
                                </div>
                            </div>
                        </div>

                        <!-- Farmer Info & Action -->
                        <div class="d-flex justify-content-between align-items-center pt-2 border-top">
                            <div class="d-flex align-items-center gap-2">
                                <div class="rounded-circle bg-light d-flex align-items-center justify-content-center text-success fw-bold" style="width: 34px; height: 34px; border: 1px solid var(--border-subtle);">
                                    <i class="bi bi-person-fill"></i>
                                </div>
                                <div>
                                    <small class="d-block fw-semibold text-dark"><c:out value="${item.farmerName}"/></small>
                                    <small class="text-muted" style="font-size: 0.78rem;"><c:out value="${item.moistureGrade}"/></small>
                                </div>
                            </div>
                            <a href="<c:url value='/marketplace/listing/${item.id}'/>" class="btn btn-wtw-primary btn-sm px-3">
                                View Details <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
