<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/navbar.jsp"/>

<!-- Top Bar -->
<div class="bg-light py-4 border-bottom">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-between gap-3">
            <div class="d-flex align-items-center gap-3">
                <div class="rounded-circle d-flex align-items-center justify-content-center text-dark fw-bold shadow-sm" style="width: 56px; height: 56px; background: linear-gradient(135deg, #f59e0b 0%, #d97706 100%); font-size: 1.5rem;">
                    <i class="bi bi-building"></i>
                </div>
                <div>
                    <div class="d-flex align-items-center gap-2">
                        <h1 class="h4 fw-bold text-dark mb-0">${buyer.fullName}</h1>
                        <span class="badge bg-warning text-dark border border-warning-subtle px-2 py-1 rounded-pill small">
                            <i class="bi bi-shield-check me-1"></i> Industrial Buyer
                        </span>
                    </div>
                    <p class="text-muted small mb-0">
                        <i class="bi bi-geo-alt text-warning me-1"></i>
                        ${not empty buyer.district ? buyer.district : 'Industrial Procurement Hub'} &bull; ${buyer.email}
                    </p>
                </div>
            </div>
            <div class="d-flex gap-2">
                <a href="<c:url value='/marketplace'/>" class="btn btn-wtw-primary shadow-sm">
                    <i class="bi bi-search me-1"></i> Browse Agricultural Exchange
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container py-4 my-2">
    <!-- Notifications -->
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success d-flex align-items-center gap-2 py-3 px-4 rounded-3 shadow-sm mb-4" role="alert" style="background-color: #ecfdf5; border-left: 5px solid #10b981;">
            <i class="bi bi-check-circle-fill text-success fs-4"></i>
            <div><c:out value="${successMessage}"/></div>
        </div>
    </c:if>

    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger d-flex align-items-center gap-2 py-3 px-4 rounded-3 shadow-sm mb-4" role="alert">
            <i class="bi bi-exclamation-triangle-fill text-danger fs-4"></i>
            <div><c:out value="${errorMessage}"/></div>
        </div>
    </c:if>

    <!-- Stat Cards -->
    <div class="row g-3 mb-4">
        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 position-relative overflow-hidden">
                <div class="position-absolute top-0 start-0 w-100" style="height: 4px; background: #10b981;"></div>
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small fw-semibold text-uppercase">Live Lots on Market</span>
                        <h3 class="fw-bold text-dark mt-1 mb-0">${totalAvailable}</h3>
                        <span class="text-success small fw-medium">Available for direct order</span>
                    </div>
                    <div class="rounded-4 p-3 text-success" style="background: #ecfdf5; font-size: 1.8rem;">
                        <i class="bi bi-boxes"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 position-relative overflow-hidden">
                <div class="position-absolute top-0 start-0 w-100" style="height: 4px; background: #f59e0b;"></div>
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small fw-semibold text-uppercase">My Purchase Orders</span>
                        <h3 class="fw-bold text-dark mt-1 mb-0">${myRequests != null ? myRequests.size() : 0}</h3>
                        <span class="text-warning small fw-medium">${activeOrdersCount} Active orders</span>
                    </div>
                    <div class="rounded-4 p-3 text-warning" style="background: #fef3c7; font-size: 1.8rem;">
                        <i class="bi bi-file-earmark-check-fill"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 position-relative overflow-hidden">
                <div class="position-absolute top-0 start-0 w-100" style="height: 4px; background: #8b5cf6;"></div>
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small fw-semibold text-uppercase">ESG Sustainability</span>
                        <h3 class="fw-bold text-dark mt-1 mb-0">100%</h3>
                        <span class="text-primary small fw-medium">Zero stubble burning certified</span>
                    </div>
                    <div class="rounded-4 p-3 text-primary" style="background: #f5f3ff; font-size: 1.8rem;">
                        <i class="bi bi-tree-fill"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Section 1: My Sent Purchase Requests -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white mb-4">
        <div class="card-header bg-white py-3 px-4 border-bottom d-flex align-items-center justify-content-between">
            <h5 class="fw-bold text-dark mb-0"><i class="bi bi-receipt text-warning me-2"></i>My Purchase Orders & Requests</h5>
            <span class="badge bg-warning text-dark px-3 py-1 rounded-pill">${myRequests != null ? myRequests.size() : 0} Total</span>
        </div>
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light small text-uppercase text-secondary">
                    <tr>
                        <th class="ps-4">Order ID & Date</th>
                        <th>Crop Residue Lot</th>
                        <th>Farmer / Seller</th>
                        <th>Quantity</th>
                        <th>Total Amount</th>
                        <th>Logistics</th>
                        <th>Status</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty myRequests}">
                            <c:forEach var="req" items="${myRequests}">
                                <tr>
                                    <td class="ps-4">
                                        <div class="fw-bold text-dark">#REQ-${req.id}</div>
                                        <small class="text-muted">${req.createdAt}</small>
                                    </td>
                                    <td>
                                        <a href="<c:url value='/marketplace/listing/${req.listing.id}'/>" class="text-decoration-none fw-semibold text-dark">
                                            ${req.listing.title}
                                        </a>
                                        <div class="small text-muted"><i class="bi bi-geo-alt"></i> ${req.listing.location}</div>
                                    </td>
                                    <td>
                                        <div class="fw-semibold text-dark">${req.farmer.fullName}</div>
                                        <c:choose>
                                            <c:when test="${req.requestStatus == 'ACCEPTED'}">
                                                <div class="small text-success fw-semibold">
                                                    <i class="bi bi-telephone-fill"></i> ${req.farmer.mobileNumber}
                                                </div>
                                                <div class="small text-muted">${req.farmer.email}</div>
                                            </c:when>
                                            <c:otherwise>
                                                <small class="text-muted"><i class="bi bi-lock-fill"></i> Contact unlocked on acceptance</small>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td><strong>${req.quantity}</strong> ${req.unit}</td>
                                    <td>
                                        <div class="fw-bold text-dark">&#8377; ${req.totalAmount}</div>
                                        <div class="badge bg-success-subtle text-success border border-success-subtle mt-1">
                                            <i class="bi bi-shield-check me-1"></i> Adv Paid: &#8377; ${req.advanceAmount}
                                        </div>
                                        <div class="small text-muted mt-1 font-monospace">UTR: ${req.upiRefId}</div>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark border">${req.deliveryPreference}</span>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${req.requestStatus == 'PENDING'}">
                                                <span class="badge bg-warning text-dark px-3 py-1 rounded-pill">Pending Farmer</span>
                                            </c:when>
                                            <c:when test="${req.requestStatus == 'ACCEPTED'}">
                                                <span class="badge bg-success px-3 py-1 rounded-pill"><i class="bi bi-check-circle-fill me-1"></i> Accepted</span>
                                            </c:when>
                                            <c:when test="${req.requestStatus == 'REJECTED'}">
                                                <span class="badge bg-danger px-3 py-1 rounded-pill">Declined</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary px-3 py-1 rounded-pill">${req.requestStatus}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" class="text-center py-4 text-muted">
                                    <i class="bi bi-cart-x fs-3 d-block mb-1"></i>
                                    You have not submitted any purchase requests yet. Browse the farm lots below to order directly.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Section 2: Recommended Lots For Procurement -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white mb-4">
        <div class="card-header bg-white py-3 px-4 border-bottom d-flex align-items-center justify-content-between">
            <h5 class="fw-bold text-dark mb-0"><i class="bi bi-grid-fill text-success me-2"></i>Available Biomass Lots For Sourcing</h5>
            <a href="<c:url value='/marketplace'/>" class="text-decoration-none fw-semibold small text-success">
                Open Full Marketplace <i class="bi bi-arrow-right"></i>
            </a>
        </div>
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light small text-uppercase text-secondary">
                    <tr>
                        <th class="ps-4">Listing Title</th>
                        <th>Waste Category</th>
                        <th>Available Qty</th>
                        <th>Price / Unit</th>
                        <th>Location</th>
                        <th class="text-end pe-4">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="item" items="${availableListings}">
                        <tr>
                            <td class="ps-4">
                                <div class="fw-bold text-dark">${item.title}</div>
                                <small class="text-muted">Farmer: ${item.farmer != null ? item.farmer.fullName : 'Verified Farmer'}</small>
                            </td>
                            <td>
                                <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1 rounded-pill">
                                    ${item.wasteType != null ? item.wasteType.name : 'Crop Residue'}
                                </span>
                            </td>
                            <td><strong>${item.availableQuantity}</strong> ${item.unit}</td>
                            <td><strong class="text-success">&#8377; ${item.pricePerUnit}</strong> / ${item.unit}</td>
                            <td><i class="bi bi-geo-alt text-muted"></i> ${item.location}</td>
                            <td class="text-end pe-4">
                                <a href="<c:url value='/marketplace/listing/${item.id}'/>" class="btn btn-sm btn-wtw-primary fw-semibold shadow-sm">
                                    <i class="bi bi-send-fill me-1"></i> Order Now
                                </a>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
