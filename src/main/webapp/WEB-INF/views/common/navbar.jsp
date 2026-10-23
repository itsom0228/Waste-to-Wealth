<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<nav class="navbar navbar-expand-lg navbar-wtw sticky-top">
    <div class="container">
        <!-- Brand Logo -->
        <a class="navbar-brand d-flex align-items-center gap-2" href="<c:url value='/'/>">
            <span class="brand-icon-box">
                <i class="bi bi-recycle"></i>
            </span>
            <span class="fw-bold" style="letter-spacing: -0.02em;">Waste to Wealth</span>
        </a>

        <!-- Mobile Toggle Button -->
        <button class="navbar-toggler border-0" type="button" data-bs-toggle="collapse" data-bs-target="#navbarMain" aria-controls="navbarMain" aria-expanded="false" aria-label="Toggle navigation">
            <i class="bi bi-list fs-2 text-dark"></i>
        </button>

        <!-- Navbar Links -->
        <div class="collapse navbar-collapse" id="navbarMain">
            <ul class="navbar-nav mx-auto mb-2 mb-lg-0">
                <li class="nav-item">
                    <a class="nav-link nav-link-wtw ${activeNav == 'home' ? 'active' : ''}" href="<c:url value='/'/>">
                        <i class="bi bi-house-door me-1"></i><spring:message code="nav.home"/>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-link-wtw ${activeNav == 'marketplace' ? 'active' : ''}" href="<c:url value='/marketplace'/>">
                        <i class="bi bi-shop me-1 text-warning"></i><spring:message code="nav.marketplace"/>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-link-wtw" href="<c:url value='/#how-it-works'/>">
                        <i class="bi bi-gear me-1"></i><spring:message code="nav.howItWorks"/>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-link-wtw" href="<c:url value='/#sustainability'/>">
                        <i class="bi bi-flower1 me-1 text-success"></i><spring:message code="nav.impact"/>
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link nav-link-wtw ${activeNav == 'contact' ? 'active' : ''}" href="<c:url value='/contact'/>">
                        <i class="bi bi-telephone me-1"></i><spring:message code="nav.contact"/>
                    </a>
                </li>
            </ul>

            <!-- Right Controls: Language Switcher & Auth Actions -->
            <div class="d-flex align-items-center gap-2 flex-wrap">
                <!-- Regional Language Switcher Dropdown (English, Marathi, Hindi) -->
                <c:set var="curLang" value="${not empty param.lang ? param.lang : (not empty cookie['PREFERRED_LANGUAGE'].value ? cookie['PREFERRED_LANGUAGE'].value : 'en')}"/>
                <div class="dropdown">
                    <button class="btn btn-lang-switcher dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                        <i class="bi bi-translate text-success"></i>
                        <span>
                            <c:choose>
                                <c:when test="${curLang == 'mr'}">मराठी</c:when>
                                <c:when test="${curLang == 'hi'}">हिंदी</c:when>
                                <c:otherwise>English</c:otherwise>
                            </c:choose>
                        </span>
                    </button>
                    <ul class="dropdown-menu dropdown-menu-end shadow border-0 rounded-3 mt-1">
                        <li>
                            <a class="dropdown-item d-flex align-items-center justify-content-between py-2 ${curLang == 'en' ? 'active fw-bold' : ''}" href="?lang=en">
                                <span>🇬🇧 English</span>
                                <c:if test="${curLang == 'en'}"><i class="bi bi-check-lg text-success"></i></c:if>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item d-flex align-items-center justify-content-between py-2 ${curLang == 'mr' ? 'active fw-bold' : ''}" href="?lang=mr">
                                <span>🇮🇳 मराठी (Marathi)</span>
                                <c:if test="${curLang == 'mr'}"><i class="bi bi-check-lg text-success"></i></c:if>
                            </a>
                        </li>
                        <li>
                            <a class="dropdown-item d-flex align-items-center justify-content-between py-2 ${curLang == 'hi' ? 'active fw-bold' : ''}" href="?lang=hi">
                                <span>🇮🇳 हिंदी (Hindi)</span>
                                <c:if test="${curLang == 'hi'}"><i class="bi bi-check-lg text-success"></i></c:if>
                            </a>
                        </li>
                    </ul>
                </div>

                <!-- Auth Buttons -->
                <sec:authorize access="isAnonymous()">
                    <a href="<c:url value='/login'/>" class="btn btn-wtw-secondary btn-sm px-3">
                        <i class="bi bi-box-arrow-in-right"></i> <spring:message code="nav.login"/>
                    </a>
                    <a href="<c:url value='/register'/>" class="btn btn-wtw-primary btn-sm px-3">
                        <i class="bi bi-person-plus"></i> <spring:message code="nav.register"/>
                    </a>
                </sec:authorize>

                <sec:authorize access="isAuthenticated()">
                    <sec:authorize access="hasRole('FARMER')">
                        <a href="<c:url value='/farmer/dashboard'/>" class="btn btn-wtw-primary btn-sm px-3">
                            <i class="bi bi-speedometer2"></i> Dashboard
                        </a>
                    </sec:authorize>
                    <sec:authorize access="hasRole('BUYER')">
                        <a href="<c:url value='/buyer/dashboard'/>" class="btn btn-wtw-primary btn-sm px-3">
                            <i class="bi bi-speedometer2"></i> Dashboard
                        </a>
                    </sec:authorize>
                    <sec:authorize access="hasRole('ADMIN')">
                        <a href="<c:url value='/admin/dashboard'/>" class="btn btn-wtw-accent btn-sm px-3">
                            <i class="bi bi-shield-lock"></i> Admin
                        </a>
                    </sec:authorize>
                    <form action="<c:url value='/logout'/>" method="post" class="d-inline m-0">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <button type="submit" class="btn btn-outline-secondary btn-sm px-2" title="Logout">
                            <i class="bi bi-power"></i>
                        </button>
                    </form>
                </sec:authorize>
            </div>
        </div>
    </div>
</nav>
