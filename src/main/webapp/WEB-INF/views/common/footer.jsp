<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<footer class="footer-wtw">
    <div class="container">
        <div class="row g-4">
            <!-- Brand Column -->
            <div class="col-lg-4 col-md-6">
                <div class="d-flex align-items-center gap-2 mb-3">
                    <span class="brand-icon-box">
                        <i class="bi bi-recycle"></i>
                    </span>
                    <span class="h4 text-white mb-0 font-weight-bold">Waste to Wealth</span>
                </div>
                <p class="text-white-50 mb-3" style="font-size: 0.95rem;">
                    "Turn Farm Waste Into Wealth" — Give agricultural waste a second life. Connecting Indian farmers directly with industries and bio-energy enterprises.
                </p>
                <div class="d-flex gap-2 text-white-50">
                    <span class="badge bg-dark border border-secondary px-2 py-1"><i class="bi bi-shield-check text-success"></i> Verified Farmers</span>
                    <span class="badge bg-dark border border-secondary px-2 py-1"><i class="bi bi-truck text-warning"></i> Direct Logistics</span>
                </div>
            </div>

            <!-- Quick Links -->
            <div class="col-lg-2 col-md-3 col-6">
                <h5>Platform</h5>
                <ul class="footer-links">
                    <li><a href="<c:url value='/'/>"><i class="bi bi-chevron-right me-1 small"></i> Home</a></li>
                    <li><a href="<c:url value='/marketplace'/>"><i class="bi bi-chevron-right me-1 small"></i> Marketplace</a></li>
                    <li><a href="<c:url value='/#how-it-works'/>"><i class="bi bi-chevron-right me-1 small"></i> How It Works</a></li>
                    <li><a href="<c:url value='/register'/>"><i class="bi bi-chevron-right me-1 small"></i> Register</a></li>
                    <li><a href="<c:url value='/login'/>"><i class="bi bi-chevron-right me-1 small"></i> Sign In</a></li>
                </ul>
            </div>

            <!-- Categories -->
            <div class="col-lg-3 col-md-3 col-6">
                <h5>Waste Categories</h5>
                <ul class="footer-links">
                    <li><a href="<c:url value='/marketplace?category=wheat'/>"><i class="bi bi-chevron-right me-1 small"></i> Wheat Straw & Stubble</a></li>
                    <li><a href="<c:url value='/marketplace?category=rice'/>"><i class="bi bi-chevron-right me-1 small"></i> Rice Husk & Paddy Straw</a></li>
                    <li><a href="<c:url value='/marketplace?category=sugarcane'/>"><i class="bi bi-chevron-right me-1 small"></i> Sugarcane Trash & Bagasse</a></li>
                    <li><a href="<c:url value='/marketplace?category=cotton'/>"><i class="bi bi-chevron-right me-1 small"></i> Cotton Stalks</a></li>
                    <li><a href="<c:url value='/marketplace?category=biomass'/>"><i class="bi bi-chevron-right me-1 small"></i> Biomass Pellets Raw Material</a></li>
                </ul>
            </div>

            <!-- Support & Contact -->
            <div class="col-lg-3 col-md-6">
                <h5>Contact & Support</h5>
                <ul class="footer-links">
                    <li class="text-white-50"><i class="bi bi-geo-alt text-success me-2"></i> Agricultural Innovation Hub, India</li>
                    <li class="text-white-50"><i class="bi bi-envelope text-success me-2"></i> support@wastetowealth.com</li>
                    <li class="text-white-50"><i class="bi bi-telephone text-success me-2"></i> +91 1800-FARM-WEALTH</li>
                    <li class="text-white-50"><i class="bi bi-clock text-success me-2"></i> Mon - Sat: 8:00 AM - 7:00 PM</li>
                </ul>
            </div>
        </div>

        <!-- Bottom Strip -->
        <div class="footer-bottom d-flex flex-column flex-md-row justify-content-between align-items-center gap-3">
            <div>
                &copy; 2026 <strong>Waste to Wealth</strong>. All rights reserved. Promoting sustainable agriculture and circular economy.
            </div>
            <div class="d-flex gap-3">
                <a href="#" class="text-white-50 text-decoration-none">Privacy Policy</a>
                <span class="text-secondary">&bull;</span>
                <a href="#" class="text-white-50 text-decoration-none">Terms of Service</a>
                <span class="text-secondary">&bull;</span>
                <a href="#" class="text-white-50 text-decoration-none">Security</a>
            </div>
        </div>
    </div>
</footer>

<!-- Bootstrap 5.3 Bundle with Popper JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-YvpcrYf0tY3lHB60NNkmXc5s9fDVZLESaAA55NDzOxhy9GkcIdslK1eN7N6jIeHz" crossorigin="anonymous"></script>

<!-- Custom App JS -->
<script src="<c:url value='/js/main.js'/>"></script>

</body>
</html>
