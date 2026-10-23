<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<jsp:include page="../common/header.jsp"/>
<jsp:include page="../common/navbar.jsp"/>

<!-- ==============================================================================
     HERO SECTION
     ============================================================================== -->
<section class="hero-section">
    <div class="container">
        <div class="row align-items-center g-5">
            <!-- Left Column: Copy & Actions -->
            <div class="col-lg-7">
                <div class="hero-badge">
                    <i class="bi bi-patch-check-fill text-success fs-5"></i>
                    <span><spring:message code="app.hero.badge"/></span>
                </div>
                <h1 class="hero-title mb-3">
                    <spring:message code="app.tagline"/>
                </h1>
                <p class="hero-subtitle mb-3" style="color: var(--color-warm-600); font-weight: 700; font-size: 1.35rem;">
                    <spring:message code="app.subtagline"/>
                </p>
                <p class="hero-description text-secondary fs-5 mb-4">
                    <spring:message code="app.hero.desc"/>
                </p>

                <div class="d-flex flex-wrap gap-3 pt-2">
                    <a href="<c:url value='/register?role=FARMER'/>" class="btn btn-wtw-primary btn-lg shadow">
                        <i class="bi bi-plus-circle-fill"></i> <spring:message code="btn.sellWaste"/>
                    </a>
                    <a href="<c:url value='/marketplace'/>" class="btn btn-wtw-secondary btn-lg shadow-sm">
                        <i class="bi bi-shop text-warning"></i> <spring:message code="btn.exploreMarketplace"/>
                    </a>
                </div>

                <!-- Live Pillars Strip -->
                <div class="hero-stats-strip">
                    <div class="stat-item">
                        <h4><spring:message code="stat.directPayouts"/></h4>
                        <p><spring:message code="stat.directPayouts.desc"/></p>
                    </div>
                    <div class="stat-item">
                        <h4><spring:message code="stat.zeroBurning"/></h4>
                        <p><spring:message code="stat.zeroBurning.desc"/></p>
                    </div>
                    <div class="stat-item">
                        <h4><spring:message code="stat.verifiedTrades"/></h4>
                        <p><spring:message code="stat.verifiedTrades.desc"/></p>
                    </div>
                </div>
            </div>

            <!-- Right Column: Visual Hero with Farmer Image & Floating Preview -->
            <div class="col-lg-5">
                <div class="position-relative">
                    <!-- Main Authentic Farmer Image -->
                    <div class="rounded-4 overflow-hidden shadow-lg border border-3 border-white" style="height: 400px;">
                        <img src="<c:url value='/images/farmer_hero.jpg'/>" alt="Indian Farmer with Harvested Agricultural Biomass" class="w-100 h-100 object-fit-cover">
                    </div>

                    <!-- Floating Verified Farmer Badge -->
                    <div class="position-absolute top-0 start-0 m-3 px-3 py-2 rounded-pill bg-white shadow border d-flex align-items-center gap-2">
                        <i class="bi bi-patch-check-fill text-success fs-5"></i>
                        <span class="small fw-bold text-dark"><spring:message code="preview.verified"/></span>
                    </div>

                    <!-- Overlaying Active Listing Card -->
                    <div class="mt-n4 mx-2 position-relative z-1 shadow-lg bg-white p-3 rounded-4 border" style="margin-top: -3.5rem !important;">
                        <div class="d-flex align-items-center justify-content-between mb-2">
                            <span class="badge bg-success-subtle text-success border border-success-subtle px-2 py-1 rounded-pill small">
                                <i class="bi bi-lightning-charge-fill me-1"></i> <spring:message code="preview.badge"/>
                            </span>
                            <small class="text-muted"><i class="bi bi-geo-alt-fill text-danger"></i> Nashik, Maharashtra</small>
                        </div>
                        <h6 class="fw-bold text-dark mb-1">High Density Wheat Straw (Baled)</h6>
                        <div class="d-flex justify-content-between align-items-center mt-2 pt-2 border-top">
                            <div>
                                <span class="text-muted small d-block"><spring:message code="preview.available"/></span>
                                <strong class="text-dark">45 Tons</strong>
                            </div>
                            <div class="text-center">
                                <span class="text-muted small d-block"><spring:message code="preview.price"/></span>
                                <strong class="text-success">&#8377; 2,400 / Ton</strong>
                            </div>
                            <a href="<c:url value='/marketplace/listing/1'/>" class="btn btn-wtw-primary btn-sm px-3">
                                <spring:message code="btn.viewDetails"/> <i class="bi bi-arrow-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ==============================================================================
     COLORFUL AGRICULTURAL WASTE CATEGORIES
     ============================================================================== -->
<section class="py-5" style="background-color: var(--bg-surface);">
    <div class="container py-4">
        <div class="text-center max-w-700 mx-auto mb-5">
            <span class="badge bg-success-subtle text-success px-3 py-2 rounded-pill fw-semibold mb-2">
                <spring:message code="categories.badge"/>
            </span>
            <h2 class="display-6 fw-bold"><spring:message code="categories.title"/></h2>
            <p class="text-muted fs-6"><spring:message code="categories.desc"/></p>
        </div>

        <div class="row g-4">
            <!-- Wheat Straw -->
            <div class="col-lg-3 col-md-4 col-sm-6">
                <a href="<c:url value='/marketplace?category=Wheat+Straw'/>" class="text-decoration-none">
                    <div class="category-card cat-wheat">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-feather"></i>
                        </div>
                        <h5 class="category-title"><spring:message code="cat.wheat"/></h5>
                        <p class="category-desc"><spring:message code="cat.wheat.desc"/></p>
                    </div>
                </a>
            </div>

            <!-- Rice Husk -->
            <div class="col-lg-3 col-md-4 col-sm-6">
                <a href="<c:url value='/marketplace?category=Rice+Husk'/>" class="text-decoration-none">
                    <div class="category-card cat-rice">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-fire"></i>
                        </div>
                        <h5 class="category-title"><spring:message code="cat.rice"/></h5>
                        <p class="category-desc"><spring:message code="cat.rice.desc"/></p>
                    </div>
                </a>
            </div>

            <!-- Sugarcane Leaves -->
            <div class="col-lg-3 col-md-4 col-sm-6">
                <a href="<c:url value='/marketplace?category=Sugarcane+Leaves'/>" class="text-decoration-none">
                    <div class="category-card cat-sugarcane">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-layers-half"></i>
                        </div>
                        <h5 class="category-title"><spring:message code="cat.sugarcane"/></h5>
                        <p class="category-desc"><spring:message code="cat.sugarcane.desc"/></p>
                    </div>
                </a>
            </div>

            <!-- Cotton Stalks -->
            <div class="col-lg-3 col-md-4 col-sm-6">
                <a href="<c:url value='/marketplace?category=Cotton+Stalks'/>" class="text-decoration-none">
                    <div class="category-card cat-cotton">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-tree"></i>
                        </div>
                        <h5 class="category-title"><spring:message code="cat.cotton"/></h5>
                        <p class="category-desc"><spring:message code="cat.cotton.desc"/></p>
                    </div>
                </a>
            </div>

            <!-- Corn Residue -->
            <div class="col-lg-3 col-md-4 col-sm-6">
                <a href="<c:url value='/marketplace?category=Corn+Residue'/>" class="text-decoration-none">
                    <div class="category-card cat-corn">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-boxes"></i>
                        </div>
                        <h5 class="category-title"><spring:message code="cat.corn"/></h5>
                        <p class="category-desc"><spring:message code="cat.corn.desc"/></p>
                    </div>
                </a>
            </div>

            <!-- Soybean Stems -->
            <div class="col-lg-3 col-md-4 col-sm-6">
                <a href="<c:url value='/marketplace?category=Soybean+Stems'/>" class="text-decoration-none">
                    <div class="category-card cat-soybean">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-flower2"></i>
                        </div>
                        <h5 class="category-title"><spring:message code="cat.soybean"/></h5>
                        <p class="category-desc"><spring:message code="cat.soybean.desc"/></p>
                    </div>
                </a>
            </div>

            <!-- Banana Waste -->
            <div class="col-lg-3 col-md-4 col-sm-6">
                <a href="<c:url value='/marketplace?category=Banana+Waste'/>" class="text-decoration-none">
                    <div class="category-card cat-banana">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-scissors"></i>
                        </div>
                        <h5 class="category-title"><spring:message code="cat.banana"/></h5>
                        <p class="category-desc"><spring:message code="cat.banana.desc"/></p>
                    </div>
                </a>
            </div>

            <!-- Other Agri Waste -->
            <div class="col-lg-3 col-md-4 col-sm-6">
                <a href="<c:url value='/marketplace'/>" class="text-decoration-none">
                    <div class="category-card cat-other">
                        <div class="category-icon-wrapper">
                            <i class="bi bi-plus-slash-minus"></i>
                        </div>
                        <h5 class="category-title"><spring:message code="cat.other"/></h5>
                        <p class="category-desc"><spring:message code="cat.other.desc"/></p>
                    </div>
                </a>
            </div>
        </div>

        <div class="text-center mt-5">
            <a href="<c:url value='/marketplace'/>" class="btn btn-wtw-secondary px-4 py-2">
                <i class="bi bi-grid-3x3-gap text-success"></i> <spring:message code="categories.browseAll"/>
            </a>
        </div>
    </div>
</section>

<!-- ==============================================================================
     HOW IT WORKS SECTION
     ============================================================================== -->
<section id="how-it-works" class="py-5" style="background-color: var(--bg-page);">
    <div class="container py-4">
        <div class="text-center max-w-700 mx-auto mb-5">
            <span class="badge bg-warning text-dark px-3 py-2 rounded-pill fw-semibold mb-2">
                <spring:message code="workflow.badge"/>
            </span>
            <h2 class="display-6 fw-bold"><spring:message code="workflow.title"/></h2>
            <p class="text-muted"><spring:message code="workflow.desc"/></p>
        </div>

        <div class="row g-4">
            <!-- Step 1 -->
            <div class="col-lg-3 col-md-6">
                <div class="step-card">
                    <div class="step-number">1</div>
                    <div class="step-icon text-success fs-1 mb-2"><i class="bi bi-clipboard-plus"></i></div>
                    <h5 class="fw-bold mb-2"><spring:message code="step1.title"/></h5>
                    <p class="text-muted small mb-0"><spring:message code="step1.desc"/></p>
                </div>
            </div>

            <!-- Step 2 -->
            <div class="col-lg-3 col-md-6">
                <div class="step-card">
                    <div class="step-number">2</div>
                    <div class="step-icon text-warning fs-1 mb-2"><i class="bi bi-search-heart"></i></div>
                    <h5 class="fw-bold mb-2"><spring:message code="step2.title"/></h5>
                    <p class="text-muted small mb-0"><spring:message code="step2.desc"/></p>
                </div>
            </div>

            <!-- Step 3 -->
            <div class="col-lg-3 col-md-6">
                <div class="step-card">
                    <div class="step-number">3</div>
                    <div class="step-icon text-primary fs-1 mb-2"><i class="bi bi-check2-circle"></i></div>
                    <h5 class="fw-bold mb-2"><spring:message code="step3.title"/></h5>
                    <p class="text-muted small mb-0"><spring:message code="step3.desc"/></p>
                </div>
            </div>

            <!-- Step 4 -->
            <div class="col-lg-3 col-md-6">
                <div class="step-card">
                    <div class="step-number">4</div>
                    <div class="step-icon text-success fs-1 mb-2"><i class="bi bi-cash-stack"></i></div>
                    <h5 class="fw-bold mb-2"><spring:message code="step4.title"/></h5>
                    <p class="text-muted small mb-0"><spring:message code="step4.desc"/></p>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ==============================================================================
     BENEFITS COMPARISON (FARMER VS BUYER)
     ============================================================================== -->
<section class="py-5" style="background-color: var(--bg-surface);">
    <div class="container py-4">
        <div class="row g-4">
            <!-- Farmer Benefits -->
            <div class="col-lg-6">
                <div class="benefit-card farmer-theme">
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <i class="bi bi-sun-fill text-success fs-2"></i>
                        <h3 class="h4 mb-0 fw-bold"><spring:message code="benefits.farmer.title"/></h3>
                    </div>
                    <p class="text-muted small mb-3"><spring:message code="benefits.farmer.subtitle"/></p>
                    <ul class="benefit-list list-unstyled">
                        <li class="mb-3 d-flex gap-2">
                            <i class="bi bi-check-circle-fill text-success fs-5"></i>
                            <div><strong><spring:message code="benefits.farmer.item1.title"/></strong> <spring:message code="benefits.farmer.item1.desc"/></div>
                        </li>
                        <li class="mb-3 d-flex gap-2">
                            <i class="bi bi-check-circle-fill text-success fs-5"></i>
                            <div><strong><spring:message code="benefits.farmer.item2.title"/></strong> <spring:message code="benefits.farmer.item2.desc"/></div>
                        </li>
                        <li class="mb-3 d-flex gap-2">
                            <i class="bi bi-check-circle-fill text-success fs-5"></i>
                            <div><strong><spring:message code="benefits.farmer.item3.title"/></strong> <spring:message code="benefits.farmer.item3.desc"/></div>
                        </li>
                        <li class="mb-3 d-flex gap-2">
                            <i class="bi bi-check-circle-fill text-success fs-5"></i>
                            <div><strong><spring:message code="benefits.farmer.item4.title"/></strong> <spring:message code="benefits.farmer.item4.desc"/></div>
                        </li>
                    </ul>
                    <div class="mt-4 pt-2">
                        <a href="<c:url value='/register?role=FARMER'/>" class="btn btn-wtw-primary">
                            <i class="bi bi-person-check-fill"></i> <spring:message code="btn.farmerRegister"/>
                        </a>
                    </div>
                </div>
            </div>

            <!-- Buyer Benefits -->
            <div class="col-lg-6">
                <div class="benefit-card buyer-theme">
                    <div class="d-flex align-items-center gap-2 mb-2">
                        <i class="bi bi-building-check text-warning fs-2"></i>
                        <h3 class="h4 mb-0 fw-bold"><spring:message code="benefits.buyer.title"/></h3>
                    </div>
                    <p class="text-muted small mb-3"><spring:message code="benefits.buyer.subtitle"/></p>
                    <ul class="benefit-list list-unstyled">
                        <li class="mb-3 d-flex gap-2">
                            <i class="bi bi-check-circle-fill text-warning fs-5"></i>
                            <div><strong><spring:message code="benefits.buyer.item1.title"/></strong> <spring:message code="benefits.buyer.item1.desc"/></div>
                        </li>
                        <li class="mb-3 d-flex gap-2">
                            <i class="bi bi-check-circle-fill text-warning fs-5"></i>
                            <div><strong><spring:message code="benefits.buyer.item2.title"/></strong> <spring:message code="benefits.buyer.item2.desc"/></div>
                        </li>
                        <li class="mb-3 d-flex gap-2">
                            <i class="bi bi-check-circle-fill text-warning fs-5"></i>
                            <div><strong><spring:message code="benefits.buyer.item3.title"/></strong> <spring:message code="benefits.buyer.item3.desc"/></div>
                        </li>
                        <li class="mb-3 d-flex gap-2">
                            <i class="bi bi-check-circle-fill text-warning fs-5"></i>
                            <div><strong><spring:message code="benefits.buyer.item4.title"/></strong> <spring:message code="benefits.buyer.item4.desc"/></div>
                        </li>
                    </ul>
                    <div class="mt-4 pt-2">
                        <a href="<c:url value='/register?role=BUYER'/>" class="btn btn-wtw-accent">
                            <i class="bi bi-building"></i> <spring:message code="btn.buyerRegister"/>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ==============================================================================
     SUSTAINABILITY & ENVIRONMENTAL IMPACT
     ============================================================================== -->
<section id="sustainability" class="py-5" style="background-color: var(--bg-page);">
    <div class="container py-4">
        <div class="impact-banner">
            <div class="row align-items-center g-4">
                <div class="col-lg-7">
                    <span class="badge bg-warning text-dark px-3 py-1 rounded-pill fw-semibold mb-2">
                        <spring:message code="impact.badge"/>
                    </span>
                    <h2 class="display-6 fw-bold mb-3 text-white"><spring:message code="impact.title"/></h2>
                    <p class="text-white-50 mb-4" style="font-size: 1.1rem; line-height: 1.7;">
                        <spring:message code="impact.desc"/>
                    </p>
                    <div class="d-flex flex-wrap gap-4 text-white">
                        <div>
                            <h3 class="h4 text-warning mb-0 fw-bold">90M+ Tons</h3>
                            <small class="text-white-50"><spring:message code="impact.stat1"/></small>
                        </div>
                        <div>
                            <h3 class="h4 text-warning mb-0 fw-bold">100% Circular</h3>
                            <small class="text-white-50"><spring:message code="impact.stat2"/></small>
                        </div>
                        <div>
                            <h3 class="h4 text-warning mb-0 fw-bold">Local Soil Health</h3>
                            <small class="text-white-50"><spring:message code="impact.stat3"/></small>
                        </div>
                    </div>
                </div>
                <div class="col-lg-5 text-center text-lg-end">
                    <div class="rounded-4 overflow-hidden border border-white border-opacity-25 shadow mb-3" style="height: 240px;">
                        <img src="<c:url value='/images/farm_bales.jpg'/>" alt="Baled Crop Residue on Farm" class="w-100 h-100 object-fit-cover">
                    </div>
                    <a href="<c:url value='/marketplace'/>" class="btn btn-light btn-lg px-4 py-3 fw-bold text-dark shadow w-100 justify-content-center">
                        <i class="bi bi-arrow-right-circle-fill text-success me-2"></i> <spring:message code="btn.joinMovement"/>
                    </a>
                </div>
            </div>
        </div>
    </div>
</section>

<!-- ==============================================================================
     CALL TO ACTION
     ============================================================================== -->
<section class="py-5 text-center" style="background: linear-gradient(180deg, var(--bg-surface) 0%, var(--color-primary-50) 100%);">
    <div class="container py-4">
        <div class="max-w-700 mx-auto">
            <h2 class="display-6 fw-bold mb-3"><spring:message code="cta.title"/></h2>
            <p class="text-muted fs-5 mb-4">
                <spring:message code="cta.desc"/>
            </p>
            <div class="d-flex justify-content-center gap-3 flex-wrap">
                <a href="<c:url value='/register?role=FARMER'/>" class="btn btn-wtw-primary btn-lg px-4 shadow">
                    <i class="bi bi-person-plus-fill"></i> <spring:message code="btn.farmerRegister"/>
                </a>
                <a href="<c:url value='/register?role=BUYER'/>" class="btn btn-wtw-accent btn-lg px-4 shadow">
                    <i class="bi bi-cart-plus-fill"></i> <spring:message code="btn.buyerRegister"/>
                </a>
            </div>
        </div>
    </div>
</section>

<jsp:include page="../common/footer.jsp"/>
