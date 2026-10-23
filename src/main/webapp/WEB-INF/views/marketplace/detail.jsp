<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/navbar.jsp"/>

<div class="container py-4">
    <!-- Breadcrumb -->
    <nav aria-label="breadcrumb" class="mb-4">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<c:url value='/'/>" class="text-decoration-none">Home</a></li>
            <li class="breadcrumb-item"><a href="<c:url value='/marketplace'/>" class="text-decoration-none">Marketplace</a></li>
            <li class="breadcrumb-item active" aria-current="page"><c:out value="${listing.title}"/></li>
        </ol>
    </nav>

    <div class="row g-4">
        <!-- Left: Image & Specifications -->
        <div class="col-lg-7">
            <div class="card border-0 shadow-sm rounded-4 overflow-hidden bg-white mb-4">
                <div style="height: 420px; overflow: hidden; background-color: #f1f5f9;">
                    <img src="<c:url value='${listing.imagePath}'/>" alt="<c:out value='${listing.title}'/>" class="w-100 h-100 object-fit-cover" onerror="this.src='https://images.unsplash.com/photo-1500382017468-9049fed747ef?w=800&auto=format&fit=crop&q=80'">
                </div>
                <div class="card-body p-4">
                    <div class="d-flex flex-wrap gap-2 mb-3">
                        <span class="badge bg-dark px-3 py-2 rounded-pill"><i class="bi bi-tag-fill text-warning me-1"></i> <c:out value="${listing.wasteCategory}"/></span>
                        <span class="badge bg-success px-3 py-2 rounded-pill"><i class="bi bi-check-circle-fill me-1"></i> Verified Farm</span>
                        <span class="badge bg-info text-dark px-3 py-2 rounded-pill"><i class="bi bi-droplet-half me-1"></i> <c:out value="${listing.moistureGrade}"/></span>
                    </div>

                    <h2 class="h3 fw-bold text-dark mb-3"><c:out value="${listing.title}"/></h2>
                    <p class="text-secondary leading-relaxed mb-4">
                        <c:out value="${listing.description}"/>
                    </p>

                    <h5 class="fw-bold text-dark mb-3">Lot Specifications & Application</h5>
                    <div class="table-responsive">
                        <table class="table table-bordered align-middle">
                            <tbody>
                                <tr>
                                    <th class="bg-light text-secondary w-35">Residue Category</th>
                                    <td><c:out value="${listing.wasteCategory}"/></td>
                                </tr>
                                <tr>
                                    <th class="bg-light text-secondary">Suitability</th>
                                    <td><c:out value="${listing.suitability}"/></td>
                                </tr>
                                <tr>
                                    <th class="bg-light text-secondary">Quality / Moisture</th>
                                    <td><c:out value="${listing.moistureGrade}"/> (Low ash, high calorific value)</td>
                                </tr>
                                <tr>
                                    <th class="bg-light text-secondary">Available From</th>
                                    <td><c:out value="${listing.availableFrom}"/></td>
                                </tr>
                                <tr>
                                    <th class="bg-light text-secondary">Farm Gate Location</th>
                                    <td><i class="bi bi-geo-alt-fill text-danger me-1"></i> <c:out value="${listing.location}"/> - <c:out value="${listing.postalCode}"/></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <!-- Right: Pricing, Purchase Request & Farmer Card -->
        <div class="col-lg-5">
            <!-- Purchase Request Card -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white mb-4">
                <span class="text-muted small text-uppercase fw-bold letter-spacing-1">Procurement Terms</span>
                <div class="d-flex align-items-baseline gap-2 my-2">
                    <span class="display-6 fw-bold text-success">&#8377; <c:out value="${listing.pricePerUnit}"/></span>
                    <span class="text-muted fs-5">/ <c:out value="${listing.unit}"/></span>
                </div>

                <div class="p-3 rounded-3 mb-4" style="background-color: var(--color-primary-50); border: 1px solid var(--color-primary-100);">
                    <div class="d-flex justify-content-between mb-2">
                        <span class="text-muted small">Total Lot Available:</span>
                        <strong class="text-dark"><c:out value="${listing.availableQuantity}"/> <c:out value="${listing.unit}"/></strong>
                    </div>
                    <div class="d-flex justify-content-between">
                        <span class="text-muted small">Minimum Order Quantity:</span>
                        <strong class="text-dark">5 <c:out value="${listing.unit}"/></strong>
                    </div>
                </div>

                <c:if test="${not empty errorMessage}">
                    <div class="alert alert-danger d-flex align-items-center gap-2 mb-3 py-2" role="alert">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                        <span class="small"><c:out value="${errorMessage}"/></span>
                    </div>
                </c:if>

                <sec:authorize access="isAnonymous()">
                    <div class="alert alert-warning d-flex align-items-center gap-2 mb-3" role="alert">
                        <i class="bi bi-exclamation-circle-fill fs-5"></i>
                        <span class="small">Sign in as an authorized Buyer to place purchase requests and schedule pickup.</span>
                    </div>
                    <a href="<c:url value='/login'/>" class="btn btn-wtw-primary w-100 py-2 justify-content-center mb-2">
                        <i class="bi bi-box-arrow-in-right"></i> Sign In to Purchase
                    </a>
                    <a href="<c:url value='/register?role=BUYER'/>" class="btn btn-wtw-secondary w-100 py-2 justify-content-center">
                        <i class="bi bi-building"></i> Register as Industrial Buyer
                    </a>
                </sec:authorize>

                <sec:authorize access="hasAnyRole('BUYER', 'ADMIN')">
                    <form action="<c:url value='/buyer/purchase-request/create'/>" method="post" id="purchaseForm">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <input type="hidden" name="listingId" value="${listing.id}"/>
                        <input type="hidden" id="unitPriceVal" value="${listing.pricePerUnit}"/>

                        <div class="mb-3">
                            <label for="reqQuantity" class="form-label small fw-semibold text-secondary">Quantity Desired (<c:out value="${listing.unit}"/>)</label>
                            <input type="number" id="reqQuantity" name="quantity" class="form-control form-control-lg fw-bold" min="1" max="${listing.availableQuantity}" value="10" required>
                            <div class="form-text small">Maximum available: <c:out value="${listing.availableQuantity}"/> <c:out value="${listing.unit}"/></div>
                        </div>

                        <div class="mb-3">
                            <label for="deliveryPref" class="form-label small fw-semibold text-secondary">Logistics & Delivery Mode</label>
                            <select id="deliveryPref" name="deliveryPreference" class="form-select">
                                <option value="Farm Gate Pickup" selected>🚜 Farm Gate Pickup (Buyer arranges transport)</option>
                                <option value="Farmer Dispatch">🚛 Request Farmer Transport Dispatch</option>
                            </select>
                        </div>

                        <div class="mb-3">
                            <label for="reqMessage" class="form-label small fw-semibold text-secondary">Note to Farmer (Optional)</label>
                            <input type="text" id="reqMessage" name="message" class="form-control" placeholder="e.g. Can load tomorrow morning at farm gate">
                        </div>

                        <!-- Live Order Total & Advance Payment Estimation -->
                        <div class="p-3 rounded-3 mb-3 bg-light border">
                            <div class="d-flex align-items-center justify-content-between mb-2">
                                <span class="text-secondary small fw-semibold">Total Order Value:</span>
                                <span class="fs-5 fw-bold text-dark" id="estimatedTotal">&#8377; 0</span>
                            </div>
                            <div class="d-flex align-items-center justify-content-between pt-2 border-top">
                                <div>
                                    <span class="text-success small fw-bold d-block"><i class="bi bi-shield-check"></i> Advance Booking (20%):</span>
                                    <span class="text-muted" style="font-size: 0.75rem;">Pay to Farmer's UPI ID to lock quantity</span>
                                </div>
                                <span class="fs-5 fw-bold text-success" id="advanceTotal">&#8377; 0</span>
                            </div>
                        </div>

                        <!-- Farmer UPI Details & Payment Section -->
                        <div class="card border-success-subtle shadow-none rounded-3 p-3 mb-3" style="background-color: #f0fdf4;">
                            <div class="d-flex align-items-center justify-content-between mb-2">
                                <span class="fw-bold text-success small text-uppercase letter-spacing-1">
                                    <i class="bi bi-qr-code-scan me-1"></i> Farmer Verified UPI ID
                                </span>
                                <span class="badge bg-success-subtle text-success border border-success-subtle">Instant Lock</span>
                            </div>

                            <div class="input-group mb-3">
                                <input type="text" class="form-control bg-white fw-bold text-dark font-monospace" id="farmerUpiId" value="<c:out value='${not empty listing.upiId ? listing.upiId : \"farmer@okhdfcbank\"}'/>" readonly>
                                <button class="btn btn-outline-success" type="button" onclick="navigator.clipboard.writeText(document.getElementById('farmerUpiId').value); alert('Farmer UPI ID copied!');">
                                    <i class="bi bi-clipboard"></i> Copy
                                </button>
                            </div>

                            <div class="row g-2 mb-2">
                                <div class="col-md-6">
                                    <label for="advAmountInput" class="form-label small fw-semibold text-secondary">Advance Paid (₹) *</label>
                                    <input type="number" id="advAmountInput" name="advanceAmount" class="form-control fw-bold" required>
                                </div>
                                <div class="col-md-6">
                                    <label for="upiRefInput" class="form-label small fw-semibold text-secondary">UPI / UTR Ref No. *</label>
                                    <input type="text" id="upiRefInput" name="upiRefId" class="form-control font-monospace" placeholder="e.g. 429182371923" required>
                                </div>
                            </div>
                            <div class="small text-muted" style="font-size: 0.74rem;">
                                <i class="bi bi-info-circle text-success me-1"></i>
                                Once you submit advance payment, <strong>the ordered quantity is automatically deducted</strong> from this farmer's listing inventory!
                            </div>
                        </div>

                        <button type="submit" class="btn btn-wtw-primary w-100 py-3 justify-content-center fw-bold shadow-sm">
                            <i class="bi bi-check2-circle me-1"></i> Confirm Advance & Deduct Stock
                        </button>
                    </form>

                    <script>
                        function updateTotal() {
                            const unitPrice = parseFloat(document.getElementById('unitPriceVal').value) || 0;
                            const qty = parseFloat(document.getElementById('reqQuantity').value) || 0;
                            const total = unitPrice * qty;
                            const advance = Math.round(total * 0.20);
                            document.getElementById('estimatedTotal').innerHTML = '&#8377; ' + total.toLocaleString('en-IN', {minimumFractionDigits: 0, maximumFractionDigits: 2});
                            document.getElementById('advanceTotal').innerHTML = '&#8377; ' + advance.toLocaleString('en-IN', {minimumFractionDigits: 0, maximumFractionDigits: 2});
                            document.getElementById('advAmountInput').value = advance;
                            if (!document.getElementById('upiRefInput').value) {
                                document.getElementById('upiRefInput').value = 'UTR' + Math.floor(100000000000 + Math.random() * 900000000000);
                            }
                        }
                        document.getElementById('reqQuantity').addEventListener('input', updateTotal);
                        updateTotal();
                    </script>
                </sec:authorize>

                <sec:authorize access="hasRole('FARMER')">
                    <div class="alert alert-info py-3 px-3 small rounded-3 mb-0">
                        <i class="bi bi-info-circle-fill me-1 text-primary"></i>
                        You are signed in as a <strong>Farmer</strong>. Farmers can list farm waste and accept purchase requests on their <a href="<c:url value='/farmer/dashboard'/>" class="fw-bold text-dark">Farmer Dashboard</a>.
                    </div>
                </sec:authorize>
            </div>

            <!-- Farmer Seller Card -->
            <div class="card border-0 shadow-sm rounded-4 p-4 bg-white">
                <h5 class="fw-bold text-dark mb-3">Farmer Details</h5>
                <div class="d-flex align-items-center gap-3 mb-3">
                    <div class="rounded-circle bg-success text-white d-flex align-items-center justify-content-center fs-4" style="width: 52px; height: 52px;">
                        <i class="bi bi-person-fill"></i>
                    </div>
                    <div>
                        <h6 class="mb-0 fw-bold text-dark"><c:out value="${listing.farmerName}"/></h6>
                        <small class="text-muted"><i class="bi bi-patch-check-fill text-success"></i> Registered Farmer Seller</small>
                    </div>
                </div>

                <div class="p-3 bg-light rounded-3 text-secondary small mb-3">
                    <p class="mb-1"><i class="bi bi-geo-alt text-danger me-2"></i><strong>Village:</strong> <c:out value="${listing.village}"/></p>
                    <p class="mb-1"><i class="bi bi-compass text-primary me-2"></i><strong>Taluka:</strong> <c:out value="${listing.taluka}"/></p>
                    <p class="mb-0"><i class="bi bi-pin-map text-warning me-2"></i><strong>District:</strong> <c:out value="${listing.district}"/>, <c:out value="${listing.state}"/></p>
                </div>

                <div class="alert alert-success d-flex align-items-center gap-2 mb-0 py-2 px-3 small">
                    <i class="bi bi-shield-lock-fill text-success fs-5"></i>
                    <span>Contact details & pickup address are shared immediately upon farmer request acceptance.</span>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="../common/footer.jsp"/>
