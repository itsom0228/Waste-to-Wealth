<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/navbar.jsp"/>

<!-- Top Bar -->
<div class="bg-light py-4 border-bottom">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-between gap-3">
            <div class="d-flex align-items-center gap-3">
                <div class="rounded-circle d-flex align-items-center justify-content-center text-white fw-bold shadow-sm" style="width: 56px; height: 56px; background: linear-gradient(135deg, #10b981 0%, #047857 100%); font-size: 1.5rem;">
                    <i class="bi bi-person-fill"></i>
                </div>
                <div>
                    <div class="d-flex align-items-center gap-2">
                        <h1 class="h4 fw-bold text-dark mb-0">${farmer.fullName}</h1>
                        <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1 rounded-pill small">
                            <i class="bi bi-check-circle-fill me-1"></i> Farmer (Seller)
                        </span>
                    </div>
                    <p class="text-muted small mb-0">
                        <i class="bi bi-geo-alt text-success me-1"></i>
                        ${not empty farmer.village ? farmer.village : 'Village'}, ${not empty farmer.district ? farmer.district : 'District'} &bull; ${farmer.email}
                    </p>
                </div>
            </div>
            <div class="d-flex gap-2">
                <a href="<c:url value='/marketplace'/>" class="btn btn-outline-success">
                    <i class="bi bi-shop me-1"></i> View Marketplace
                </a>
                <button type="button" class="btn btn-wtw-primary shadow-sm" data-bs-toggle="modal" data-bs-target="#postWasteModal">
                    <i class="bi bi-plus-circle me-1"></i> Post Farm Waste
                </button>
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
                        <span class="text-muted small fw-semibold text-uppercase">My Active Lots</span>
                        <h3 class="fw-bold text-dark mt-1 mb-0">${totalListings}</h3>
                        <span class="text-success small fw-medium">Live on marketplace</span>
                    </div>
                    <div class="rounded-4 p-3 text-success" style="background: #ecfdf5; font-size: 1.8rem;">
                        <i class="bi bi-tag-fill"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 position-relative overflow-hidden">
                <div class="position-absolute top-0 start-0 w-100" style="height: 4px; background: #f59e0b;"></div>
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small fw-semibold text-uppercase">Total Residue Volume</span>
                        <h3 class="fw-bold text-dark mt-1 mb-0">${totalQuantity} <span class="fs-6 text-muted fw-normal">Units</span></h3>
                        <span class="text-warning small fw-medium">Available for supply</span>
                    </div>
                    <div class="rounded-4 p-3 text-warning" style="background: #fef3c7; font-size: 1.8rem;">
                        <i class="bi bi-box-seam-fill"></i>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-4">
            <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 position-relative overflow-hidden">
                <div class="position-absolute top-0 start-0 w-100" style="height: 4px; background: #06b6d4;"></div>
                <div class="d-flex align-items-center justify-content-between">
                    <div>
                        <span class="text-muted small fw-semibold text-uppercase">Direct Buyer Orders</span>
                        <h3 class="fw-bold text-dark mt-1 mb-0">${incomingRequests != null ? incomingRequests.size() : 0}</h3>
                        <span class="text-info small fw-medium">${pendingRequestsCount} Pending Approval</span>
                    </div>
                    <div class="rounded-4 p-3 text-info" style="background: #e0f2fe; font-size: 1.8rem;">
                        <i class="bi bi-cart-check-fill"></i>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Section 1: Incoming Purchase Orders from Buyers -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white mb-4">
        <div class="card-header bg-white py-3 px-4 border-bottom d-flex align-items-center justify-content-between">
            <div>
                <h5 class="fw-bold text-dark mb-0"><i class="bi bi-inbox-fill text-primary me-2"></i>Incoming Purchase Orders & Enquiries</h5>
                <small class="text-muted">Direct purchase offers sent by buyers and industries</small>
            </div>
            <span class="badge bg-primary px-3 py-2 rounded-pill">${incomingRequests != null ? incomingRequests.size() : 0} Requests</span>
        </div>
        <div class="table-responsive">
            <table class="table table-hover align-middle mb-0">
                <thead class="table-light small text-uppercase text-secondary">
                    <tr>
                        <th class="ps-4">Buyer Details</th>
                        <th>Listing</th>
                        <th>Requested Qty</th>
                        <th>Offer Total (₹)</th>
                        <th>Logistics / Note</th>
                        <th>Status</th>
                        <th class="text-end pe-4">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty incomingRequests}">
                            <c:forEach var="req" items="${incomingRequests}">
                                <tr>
                                    <td class="ps-4">
                                        <div class="fw-bold text-dark">${req.buyer.fullName}</div>
                                        <small class="text-muted"><i class="bi bi-telephone text-success"></i> ${req.buyer.mobileNumber}</small>
                                        <div class="small text-muted"><i class="bi bi-envelope"></i> ${req.buyer.email}</div>
                                    </td>
                                    <td>
                                        <span class="fw-semibold text-dark">${req.listing.title}</span>
                                        <div class="small text-muted">Lot #${req.listing.id}</div>
                                    </td>
                                    <td><strong>${req.quantity}</strong> ${req.unit}</td>
                                    <td>
                                        <div class="fw-bold text-dark">&#8377; ${req.totalAmount}</div>
                                        <div class="badge bg-success-subtle text-success border border-success-subtle mt-1">
                                            <i class="bi bi-cash-stack me-1"></i> Advance Paid: &#8377; ${req.advanceAmount}
                                        </div>
                                        <div class="small text-muted mt-1 font-monospace">UTR: ${req.upiRefId}</div>
                                    </td>
                                    <td>
                                        <span class="badge bg-light text-dark border"><i class="bi bi-truck me-1"></i> ${req.deliveryPreference}</span>
                                        <c:if test="${not empty req.message}">
                                            <div class="small text-secondary mt-1 font-italic">"${req.message}"</div>
                                        </c:if>
                                    </td>
                                    <td>
                                        <c:choose>
                                            <c:when test="${req.requestStatus == 'PENDING'}">
                                                <span class="badge bg-warning text-dark px-2 py-1 rounded-pill">Pending</span>
                                            </c:when>
                                            <c:when test="${req.requestStatus == 'ACCEPTED'}">
                                                <span class="badge bg-success px-2 py-1 rounded-pill"><i class="bi bi-check-circle-fill me-1"></i> Accepted</span>
                                            </c:when>
                                            <c:when test="${req.requestStatus == 'REJECTED'}">
                                                <span class="badge bg-danger px-2 py-1 rounded-pill">Rejected</span>
                                            </c:when>
                                            <c:otherwise>
                                                <span class="badge bg-secondary px-2 py-1 rounded-pill">${req.requestStatus}</span>
                                            </c:otherwise>
                                        </c:choose>
                                    </td>
                                    <td class="text-end pe-4">
                                        <c:if test="${req.requestStatus == 'PENDING'}">
                                            <div class="d-flex justify-content-end gap-1">
                                                <form action="<c:url value='/farmer/requests/${req.id}/accept'/>" method="post" class="d-inline">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                    <button type="submit" class="btn btn-sm btn-success px-2 py-1 fw-semibold" title="Accept Offer">
                                                        <i class="bi bi-check-lg"></i> Accept
                                                    </button>
                                                </form>
                                                <form action="<c:url value='/farmer/requests/${req.id}/reject'/>" method="post" class="d-inline">
                                                    <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                    <button type="submit" class="btn btn-sm btn-outline-danger px-2 py-1" title="Decline Offer">
                                                        <i class="bi bi-x-lg"></i> Reject
                                                    </button>
                                                </form>
                                            </div>
                                        </c:if>
                                        <c:if test="${req.requestStatus == 'ACCEPTED'}">
                                            <span class="text-success small fw-bold"><i class="bi bi-check-all fs-5"></i> Ready for Pickup</span>
                                        </c:if>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" class="text-center py-4 text-muted">
                                    <i class="bi bi-inbox fs-3 d-block mb-1"></i>
                                    No purchase orders yet. Buyers browsing the marketplace can send direct offers for your listings.
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>

    <!-- Section 2: Farmer's Waste Listings -->
    <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white mb-4">
        <div class="card-header bg-white py-3 px-4 border-bottom d-flex align-items-center justify-content-between">
            <h5 class="fw-bold text-dark mb-0"><i class="bi bi-list-stars text-success me-2"></i>My Farm Waste Listings</h5>
            <button type="button" class="btn btn-sm btn-wtw-primary shadow-sm" data-bs-toggle="modal" data-bs-target="#postWasteModal">
                <i class="bi bi-plus-lg me-1"></i> Post New Residue
            </button>
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
                        <th>Status</th>
                        <th class="text-end pe-4">Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:choose>
                        <c:when test="${not empty myListings}">
                            <c:forEach var="item" items="${myListings}">
                                <tr>
                                    <td class="ps-4">
                                        <div class="fw-bold text-dark">${item.title}</div>
                                        <small class="text-muted">ID: #${item.id}</small>
                                    </td>
                                    <td>
                                        <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1 rounded-pill">
                                            ${item.wasteType != null ? item.wasteType.name : 'Agri Residue'}
                                        </span>
                                    </td>
                                    <td><strong>${item.availableQuantity}</strong> ${item.unit}</td>
                                    <td><strong class="text-success">&#8377; ${item.pricePerUnit}</strong> / ${item.unit}</td>
                                    <td><i class="bi bi-geo-alt text-muted"></i> ${item.location}</td>
                                    <td>
                                        <span class="badge bg-success px-2 py-1 rounded-pill">${item.listingStatus}</span>
                                    </td>
                                    <td class="text-end pe-4">
                                        <a href="<c:url value='/marketplace/listing/${item.id}'/>" class="btn btn-sm btn-outline-success">
                                            <i class="bi bi-eye"></i> View
                                        </a>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr>
                                <td colspan="7" class="text-center py-5">
                                    <i class="bi bi-inbox fs-1 text-muted d-block mb-2"></i>
                                    <h6 class="fw-bold text-dark">No farm waste listings posted yet</h6>
                                    <p class="text-muted small mb-3">Click below to post your harvest crop residue and start receiving direct buyer offers.</p>
                                    <button type="button" class="btn btn-sm btn-wtw-primary" data-bs-toggle="modal" data-bs-target="#postWasteModal">
                                        <i class="bi bi-plus-circle me-1"></i> Post Farm Waste Now
                                    </button>
                                </td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>
    </div>
</div>

<!-- Modal: Post Farm Waste -->
<div class="modal fade" id="postWasteModal" tabindex="-1" aria-labelledby="postWasteModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">
            <div class="modal-header bg-success text-white py-3 px-4">
                <h5 class="modal-title fw-bold" id="postWasteModalLabel">
                    <i class="bi bi-plus-circle me-2"></i>Post Agricultural Farm Waste
                </h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="<c:url value='/farmer/listings/create'/>" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="modal-body p-4">
                    <div class="row g-3">
                        <div class="col-md-12">
                            <label for="postTitle" class="form-label small fw-semibold text-secondary">Listing Title *</label>
                            <input type="text" id="postTitle" name="title" class="form-control" placeholder="e.g. Dry High-Density Wheat Straw Bales (Harvest 2026)" required>
                        </div>

                        <div class="col-md-6">
                            <label for="postCategory" class="form-label small fw-semibold text-secondary">Waste Category *</label>
                            <select id="postCategory" name="wasteTypeId" class="form-select" required>
                                <c:forEach var="wt" items="${wasteTypes}">
                                    <option value="${wt.id}">${wt.name}</option>
                                </c:forEach>
                            </select>
                        </div>

                        <div class="col-md-3">
                            <label for="postQty" class="form-label small fw-semibold text-secondary">Quantity *</label>
                            <input type="number" id="postQty" name="quantity" class="form-control" placeholder="e.g. 50" min="1" step="0.5" required>
                        </div>

                        <div class="col-md-3">
                            <label for="postUnit" class="form-label small fw-semibold text-secondary">Unit *</label>
                            <select id="postUnit" name="unit" class="form-select">
                                <option value="Tons" selected>Tons</option>
                                <option value="Quintals">Quintals</option>
                                <option value="Bales">Bales</option>
                            </select>
                        </div>

                        <div class="col-md-6">
                            <label for="postPrice" class="form-label small fw-semibold text-secondary">Expected Price Per Unit (₹) *</label>
                            <div class="input-group">
                                <span class="input-group-text bg-light text-muted">&#8377;</span>
                                <input type="number" id="postPrice" name="pricePerUnit" class="form-control" placeholder="e.g. 1800" min="1" required>
                            </div>
                        </div>

                        <div class="col-md-3">
                            <label for="postDistrict" class="form-label small fw-semibold text-secondary">District</label>
                            <input type="text" id="postDistrict" name="district" class="form-control" value="${farmer.district != null ? farmer.district : 'Pune'}">
                        </div>

                        <div class="col-md-3">
                            <label for="postVillage" class="form-label small fw-semibold text-secondary">Village / Taluka</label>
                            <input type="text" id="postVillage" name="village" class="form-control" value="${farmer.village != null ? farmer.village : 'Baramati'}">
                        </div>

                        <div class="col-md-6">
                            <label for="postUpi" class="form-label small fw-semibold text-secondary">My Receiving UPI ID (For Advance Booking) *</label>
                            <input type="text" id="postUpi" name="upiId" class="form-control font-monospace" placeholder="e.g. 9822012345@upi or name@oksbi" value="${farmer.mobileNumber}@upi" required>
                            <div class="form-text small">Buyers will pay advance booking amount directly to this UPI ID.</div>
                        </div>

                        <div class="col-md-6">
                            <label for="postDesc" class="form-label small fw-semibold text-secondary">Description & Quality Details *</label>
                            <textarea id="postDesc" name="description" class="form-control" rows="2" placeholder="Describe moisture content, baling quality, farm gate accessibility for trucks..." required>Fresh sun-dried residue from current season harvest. Moisture less than 12%. Direct vehicle access to farm gate for seamless loading.</textarea>
                        </div>
                    </div>
                </div>
                <div class="modal-footer bg-light px-4 py-3 border-top">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-wtw-primary fw-bold px-4">
                        <i class="bi bi-cloud-arrow-up me-1"></i> Publish on Marketplace
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
