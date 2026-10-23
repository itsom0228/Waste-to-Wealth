<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/navbar.jsp"/>

<!-- Top Bar -->
<div class="bg-dark text-white py-4 border-bottom">
    <div class="container">
        <div class="d-flex flex-wrap align-items-center justify-content-between gap-3">
            <div class="d-flex align-items-center gap-3">
                <div class="rounded-circle d-flex align-items-center justify-content-center text-white fw-bold shadow-sm" style="width: 56px; height: 56px; background: linear-gradient(135deg, #059669 0%, #10b981 100%); font-size: 1.5rem;">
                    <i class="bi bi-shield-lock-fill"></i>
                </div>
                <div>
                    <div class="d-flex align-items-center gap-2">
                        <h1 class="h4 fw-bold text-white mb-0">Platform Administration Control Center</h1>
                        <span class="badge bg-danger px-2 py-1 rounded-pill small">Admin Access</span>
                    </div>
                    <p class="text-white-50 small mb-0">Manage Farmers, Buyers, Crop Residue Listings & Platform Transactions</p>
                </div>
            </div>
            <div class="d-flex gap-2">
                <button type="button" class="btn btn-success shadow-sm" data-bs-toggle="modal" data-bs-target="#addUserModal">
                    <i class="bi bi-person-plus-fill me-1"></i> Add Farmer / Buyer
                </button>
                <a href="<c:url value='/marketplace'/>" class="btn btn-outline-light">
                    <i class="bi bi-shop me-1"></i> Public Exchange
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

    <!-- KPI Metric Cards -->
    <div class="row g-3 mb-4">
        <div class="col-md-3">
            <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 position-relative overflow-hidden">
                <div class="position-absolute top-0 start-0 w-100" style="height: 4px; background: #10b981;"></div>
                <span class="text-muted small fw-semibold text-uppercase">Total Users</span>
                <h3 class="fw-bold text-dark mt-1 mb-0">${totalUsers}</h3>
                <span class="text-success small fw-medium">All registered accounts</span>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 position-relative overflow-hidden">
                <div class="position-absolute top-0 start-0 w-100" style="height: 4px; background: #059669;"></div>
                <span class="text-muted small fw-semibold text-uppercase">Farmers (Sellers)</span>
                <h3 class="fw-bold text-dark mt-1 mb-0">${totalFarmers}</h3>
                <span class="text-success small fw-medium">Crop residue producers</span>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 position-relative overflow-hidden">
                <div class="position-absolute top-0 start-0 w-100" style="height: 4px; background: #f59e0b;"></div>
                <span class="text-muted small fw-semibold text-uppercase">Buyers (Industry)</span>
                <h3 class="fw-bold text-dark mt-1 mb-0">${totalBuyers}</h3>
                <span class="text-warning small fw-medium">Procurement businesses</span>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card border-0 shadow-sm rounded-4 p-3 bg-white h-100 position-relative overflow-hidden">
                <div class="position-absolute top-0 start-0 w-100" style="height: 4px; background: #06b6d4;"></div>
                <span class="text-muted small fw-semibold text-uppercase">Purchase Orders</span>
                <h3 class="fw-bold text-dark mt-1 mb-0">${totalOrders}</h3>
                <span class="text-info small fw-medium">${activeListings} Active Lots</span>
            </div>
        </div>
    </div>

    <!-- Management Tabs -->
    <ul class="nav nav-pills mb-4 bg-white p-2 rounded-4 shadow-sm border" id="adminTabs" role="tablist">
        <li class="nav-item" role="presentation">
            <button class="nav-link active fw-semibold rounded-3 px-4 py-2" id="users-tab" data-bs-toggle="pill" data-bs-target="#usersTab" type="button" role="tab">
                <i class="bi bi-people-fill me-2"></i> Manage Farmers & Buyers (${allUsers.size()})
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link fw-semibold rounded-3 px-4 py-2" id="listings-tab" data-bs-toggle="pill" data-bs-target="#listingsTab" type="button" role="tab">
                <i class="bi bi-tags-fill me-2"></i> Manage Waste Listings (${allListings.size()})
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link fw-semibold rounded-3 px-4 py-2" id="orders-tab" data-bs-toggle="pill" data-bs-target="#ordersTab" type="button" role="tab">
                <i class="bi bi-receipt me-2"></i> All Purchase Orders (${allOrders.size()})
            </button>
        </li>
        <li class="nav-item" role="presentation">
            <button class="nav-link fw-semibold rounded-3 px-4 py-2" id="logs-tab" data-bs-toggle="pill" data-bs-target="#logsTab" type="button" role="tab">
                <i class="bi bi-clock-history me-2"></i> Audit Logs
            </button>
        </li>
    </ul>

    <div class="tab-content" id="adminTabsContent">
        <!-- TAB 1: USER MANAGEMENT (FARMERS & BUYERS) -->
        <div class="tab-pane fade show active" id="usersTab" role="tabpanel">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
                <div class="card-header bg-white py-3 px-4 border-bottom d-flex align-items-center justify-content-between">
                    <div>
                        <h5 class="fw-bold text-dark mb-0"><i class="bi bi-people text-success me-2"></i>Registered Platform Users</h5>
                        <small class="text-muted">Edit, update details, or delete farmers and buyers directly</small>
                    </div>
                    <button type="button" class="btn btn-sm btn-wtw-primary shadow-sm" data-bs-toggle="modal" data-bs-target="#addUserModal">
                        <i class="bi bi-plus-lg me-1"></i> Add New User
                    </button>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light small text-uppercase text-secondary">
                            <tr>
                                <th class="ps-4">ID & Name</th>
                                <th>Email</th>
                                <th>Mobile</th>
                                <th>Role</th>
                                <th>Status</th>
                                <th>Location</th>
                                <th class="text-end pe-4">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="u" items="${allUsers}">
                                <tr>
                                    <td class="ps-4">
                                        <div class="fw-bold text-dark">${u.fullName}</div>
                                        <small class="text-muted">ID: #${u.id}</small>
                                    </td>
                                    <td><code>${u.email}</code></td>
                                    <td>${u.mobileNumber}</td>
                                    <td>
                                        <span class="badge ${u.role == 'ADMIN' ? 'bg-danger' : (u.role == 'FARMER' ? 'bg-success' : 'bg-warning text-dark')} px-2 py-1 rounded-pill">
                                            ${u.role}
                                        </span>
                                    </td>
                                    <td>
                                        <span class="badge ${u.accountStatus == 'ACTIVE' ? 'bg-success-subtle text-success border border-success-subtle' : 'bg-danger-subtle text-danger'} px-2 py-1 rounded-pill small">
                                            ${u.accountStatus}
                                        </span>
                                    </td>
                                    <td>
                                        <small class="text-muted">${not empty u.district ? u.district : 'N/A'}</small>
                                    </td>
                                    <td class="text-end pe-4">
                                        <div class="d-flex justify-content-end gap-1">
                                            <!-- Edit User Button -->
                                            <button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editUserModal${u.id}" title="Edit User">
                                                <i class="bi bi-pencil-square"></i> Edit
                                            </button>

                                            <!-- Delete User Form -->
                                            <form action="<c:url value='/admin/users/${u.id}/delete'/>" method="post" class="d-inline" onsubmit="return confirm('Are you sure you want to permanently delete user ${u.fullName}?');">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                <button type="submit" class="btn btn-sm btn-outline-danger" title="Delete User">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        </div>

                                        <!-- Edit User Modal -->
                                        <div class="modal fade text-start" id="editUserModal${u.id}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">
                                                    <div class="modal-header bg-dark text-white py-3 px-4">
                                                        <h5 class="modal-title fw-bold"><i class="bi bi-pencil-square me-2"></i>Edit User: ${u.fullName}</h5>
                                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <form action="<c:url value='/admin/users/${u.id}/update'/>" method="post">
                                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                        <div class="modal-body p-4">
                                                            <div class="mb-3">
                                                                <label class="form-label small fw-semibold text-secondary">Full Name *</label>
                                                                <input type="text" name="fullName" class="form-control" value="${u.fullName}" required>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label small fw-semibold text-secondary">Email Address (Read-only)</label>
                                                                <input type="email" class="form-control bg-light" value="${u.email}" readonly>
                                                            </div>
                                                            <div class="row g-2 mb-3">
                                                                <div class="col-md-6">
                                                                    <label class="form-label small fw-semibold text-secondary">Mobile Number *</label>
                                                                    <input type="tel" name="mobileNumber" class="form-control" value="${u.mobileNumber}" required>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <label class="form-label small fw-semibold text-secondary">Role</label>
                                                                    <select name="role" class="form-select">
                                                                        <option value="FARMER" ${u.role == 'FARMER' ? 'selected' : ''}>Farmer</option>
                                                                        <option value="BUYER" ${u.role == 'BUYER' ? 'selected' : ''}>Buyer</option>
                                                                        <option value="ADMIN" ${u.role == 'ADMIN' ? 'selected' : ''}>Admin</option>
                                                                    </select>
                                                                </div>
                                                            </div>
                                                            <div class="row g-2 mb-3">
                                                                <div class="col-md-6">
                                                                    <label class="form-label small fw-semibold text-secondary">District</label>
                                                                    <input type="text" name="district" class="form-control" value="${u.district}">
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <label class="form-label small fw-semibold text-secondary">Village / Town</label>
                                                                    <input type="text" name="village" class="form-control" value="${u.village}">
                                                                </div>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label small fw-semibold text-secondary">Account Status</label>
                                                                <select name="accountStatus" class="form-select">
                                                                    <option value="ACTIVE" ${u.accountStatus == 'ACTIVE' ? 'selected' : ''}>Active</option>
                                                                    <option value="SUSPENDED" ${u.accountStatus == 'SUSPENDED' ? 'selected' : ''}>Suspended</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer bg-light px-4 py-3 border-top">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                            <button type="submit" class="btn btn-success fw-bold px-4">
                                                                <i class="bi bi-save me-1"></i> Save Changes
                                                            </button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- TAB 2: LISTINGS MANAGEMENT -->
        <div class="tab-pane fade" id="listingsTab" role="tabpanel">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
                <div class="card-header bg-white py-3 px-4 border-bottom">
                    <h5 class="fw-bold text-dark mb-0"><i class="bi bi-tags text-warning me-2"></i>Platform Waste Listings</h5>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light small text-uppercase text-secondary">
                            <tr>
                                <th class="ps-4">ID & Title</th>
                                <th>Farmer</th>
                                <th>Category</th>
                                <th>Available Qty</th>
                                <th>Price / Unit</th>
                                <th>Status</th>
                                <th class="text-end pe-4">Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="item" items="${allListings}">
                                <tr>
                                    <td class="ps-4">
                                        <div class="fw-bold text-dark">${item.title}</div>
                                        <small class="text-muted">#LOT-${item.id} &bull; ${item.location}</small>
                                    </td>
                                    <td>${item.farmer != null ? item.farmer.fullName : 'N/A'}</td>
                                    <td>
                                        <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1 rounded-pill">
                                            ${item.wasteType != null ? item.wasteType.name : 'Agri'}
                                        </span>
                                    </td>
                                    <td><strong>${item.availableQuantity}</strong> ${item.unit}</td>
                                    <td><strong class="text-success">&#8377; ${item.pricePerUnit}</strong></td>
                                    <td>
                                        <span class="badge ${item.listingStatus == 'ACTIVE' ? 'bg-success' : 'bg-secondary'} px-2 py-1 rounded-pill">
                                            ${item.listingStatus}
                                        </span>
                                    </td>
                                    <td class="text-end pe-4">
                                        <div class="d-flex justify-content-end gap-1">
                                            <button type="button" class="btn btn-sm btn-outline-primary" data-bs-toggle="modal" data-bs-target="#editListingModal${item.id}" title="Edit Listing">
                                                <i class="bi bi-pencil-square"></i>
                                            </button>
                                            <form action="<c:url value='/admin/listings/${item.id}/delete'/>" method="post" class="d-inline" onsubmit="return confirm('Permanently delete this listing?');">
                                                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                <button type="submit" class="btn btn-sm btn-outline-danger" title="Delete Listing">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        </div>

                                        <!-- Edit Listing Modal -->
                                        <div class="modal fade text-start" id="editListingModal${item.id}" tabindex="-1" aria-hidden="true">
                                            <div class="modal-dialog modal-dialog-centered">
                                                <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">
                                                    <div class="modal-header bg-dark text-white py-3 px-4">
                                                        <h5 class="modal-title fw-bold">Edit Listing #${item.id}</h5>
                                                        <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                                                    </div>
                                                    <form action="<c:url value='/admin/listings/${item.id}/update'/>" method="post">
                                                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                                                        <div class="modal-body p-4">
                                                            <div class="mb-3">
                                                                <label class="form-label small fw-semibold text-secondary">Listing Title</label>
                                                                <input type="text" class="form-control bg-light" value="${item.title}" readonly>
                                                            </div>
                                                            <div class="row g-2 mb-3">
                                                                <div class="col-md-6">
                                                                    <label class="form-label small fw-semibold text-secondary">Price Per Unit (₹) *</label>
                                                                    <input type="number" name="pricePerUnit" class="form-control" value="${item.pricePerUnit}" required>
                                                                </div>
                                                                <div class="col-md-6">
                                                                    <label class="form-label small fw-semibold text-secondary">Available Quantity *</label>
                                                                    <input type="number" name="availableQuantity" class="form-control" value="${item.availableQuantity}" step="0.5" required>
                                                                </div>
                                                            </div>
                                                            <div class="mb-3">
                                                                <label class="form-label small fw-semibold text-secondary">Listing Status</label>
                                                                <select name="listingStatus" class="form-select">
                                                                    <option value="ACTIVE" ${item.listingStatus == 'ACTIVE' ? 'selected' : ''}>Active</option>
                                                                    <option value="SOLD" ${item.listingStatus == 'SOLD' ? 'selected' : ''}>Sold</option>
                                                                    <option value="CANCELLED" ${item.listingStatus == 'CANCELLED' ? 'selected' : ''}>Cancelled</option>
                                                                </select>
                                                            </div>
                                                        </div>
                                                        <div class="modal-footer bg-light px-4 py-3 border-top">
                                                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                                            <button type="submit" class="btn btn-success fw-bold px-4">Save</button>
                                                        </div>
                                                    </form>
                                                </div>
                                            </div>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- TAB 3: PURCHASE ORDERS -->
        <div class="tab-pane fade" id="ordersTab" role="tabpanel">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
                <div class="card-header bg-white py-3 px-4 border-bottom">
                    <h5 class="fw-bold text-dark mb-0"><i class="bi bi-cart-check text-info me-2"></i>Platform Purchase Requests & Orders</h5>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light small text-uppercase text-secondary">
                            <tr>
                                <th class="ps-4">ID & Date</th>
                                <th>Listing</th>
                                <th>Farmer</th>
                                <th>Buyer</th>
                                <th>Quantity</th>
                                <th>Total (₹)</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="ord" items="${allOrders}">
                                <tr>
                                    <td class="ps-4">
                                        <div class="fw-bold text-dark">#ORD-${ord.id}</div>
                                        <small class="text-muted">${ord.createdAt}</small>
                                    </td>
                                    <td>${ord.listing.title}</td>
                                    <td>${ord.farmer.fullName}</td>
                                    <td>${ord.buyer.fullName} (${ord.buyer.email})</td>
                                    <td><strong>${ord.quantity}</strong> ${ord.unit}</td>
                                    <td><strong class="text-success">&#8377; ${ord.totalAmount}</strong></td>
                                    <td>
                                        <span class="badge ${ord.requestStatus == 'ACCEPTED' ? 'bg-success' : (ord.requestStatus == 'PENDING' ? 'bg-warning text-dark' : 'bg-danger')} px-2 py-1 rounded-pill">
                                            ${ord.requestStatus}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- TAB 4: AUDIT LOGS -->
        <div class="tab-pane fade" id="logsTab" role="tabpanel">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white">
                <div class="card-header bg-white py-3 px-4 border-bottom">
                    <h5 class="fw-bold text-dark mb-0"><i class="bi bi-journal-text text-secondary me-2"></i>Security & Transaction Audit Trail</h5>
                </div>
                <div class="table-responsive">
                    <table class="table table-hover align-middle mb-0">
                        <thead class="table-light small text-uppercase text-secondary">
                            <tr>
                                <th class="ps-4">Timestamp</th>
                                <th>Action</th>
                                <th>Entity</th>
                                <th>Details</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="log" items="${auditLogs}">
                                <tr>
                                    <td class="ps-4 text-muted small">${log.timestamp}</td>
                                    <td><code>${log.action}</code></td>
                                    <td>${log.entityType} #${log.entityId}</td>
                                    <td class="text-secondary small">${log.safeMetadata}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- Modal: Add New User (Farmer / Buyer) -->
<div class="modal fade text-start" id="addUserModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered">
        <div class="modal-content border-0 shadow-lg rounded-4 overflow-hidden">
            <div class="modal-header bg-success text-white py-3 px-4">
                <h5 class="modal-title fw-bold"><i class="bi bi-person-plus-fill me-2"></i>Add New Platform User</h5>
                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
            </div>
            <form action="<c:url value='/admin/users/create'/>" method="post">
                <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                <div class="modal-body p-4">
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-secondary">Full Name / Organization *</label>
                        <input type="text" name="fullName" class="form-control" placeholder="e.g. Balasaheb Thorat" required>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-secondary">Email Address *</label>
                        <input type="email" name="email" class="form-control" placeholder="user@example.com" required>
                    </div>
                    <div class="row g-2 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold text-secondary">Mobile Number *</label>
                            <input type="tel" name="mobileNumber" class="form-control" placeholder="9822123456" required>
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold text-secondary">Role *</label>
                            <select name="role" class="form-select" required>
                                <option value="FARMER" selected>Farmer (Seller)</option>
                                <option value="BUYER">Buyer (Industry)</option>
                            </select>
                        </div>
                    </div>
                    <div class="row g-2 mb-3">
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold text-secondary">District</label>
                            <input type="text" name="district" class="form-control" placeholder="e.g. Pune">
                        </div>
                        <div class="col-md-6">
                            <label class="form-label small fw-semibold text-secondary">Village / Town</label>
                            <input type="text" name="village" class="form-control" placeholder="e.g. Indapur">
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label small fw-semibold text-secondary">Initial Password *</label>
                        <input type="password" name="password" class="form-control" placeholder="••••••••" minlength="6" required>
                    </div>
                </div>
                <div class="modal-footer bg-light px-4 py-3 border-top">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-success fw-bold px-4">
                        <i class="bi bi-check-circle me-1"></i> Create User
                    </button>
                </div>
            </form>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
