# Waste to Wealth — Farm Waste to Money Platform

> **"Turn Farm Waste Into Wealth"**  
> *Give Agricultural Waste a Second Life.*

An agricultural waste marketplace that connects Indian farmers who have crop residue and biomass with buyers, bio-fuel plants, paper mills, and green industries.

---

## Architecture Overview

```
Browser
  ↓
JSP / HTML5 / CSS3 / Vanilla JavaScript / Bootstrap 5.3
  ↓
Spring MVC Controllers (com.wastetowealth.controller)
  ↓
Service Layer (com.wastetowealth.service)
  ↓
Spring Data JPA Repositories (com.wastetowealth.repository)
  ↓
Hibernate ORM 6.x
  ↓
MySQL 8.x Database (Flyway Migrations)
```

---

## Technology Stack

* **Language**: Java 17+ (compatible with modern JDKs)
* **Framework**: Spring Boot 3.4.2
* **Web**: Spring MVC with InternalResourceViewResolver for JSP
* **Template Engine**: Jakarta JSP 3.0 / JSTL (Glassfish Jakarta Implementation)
* **Embedded Server**: Tomcat 10.1 (WAR packaging with `tomcat-embed-jasper`)
* **Security**: Spring Security 6 (Session-based authentication, BCrypt, CSRF protection)
* **Persistence**: Spring Data JPA / Hibernate ORM
* **Validation**: Jakarta Bean Validation (Hibernate Validator)
* **Database**: MySQL 8.x with Flyway migration tooling
* **Frontend**: HTML5, CSS3 Custom Design System (Forest Green & Warm Amber theme), Bootstrap 5.3, Bootstrap Icons, Vanilla JS

---

## Phase 1 Deliverables

1. Complete Maven `pom.xml` configured with Spring Boot 3.4.2, embedded Tomcat Jasper, and Jakarta JSTL.
2. Explicit `WebMvcConfig` configuring `InternalResourceViewResolver` (`/WEB-INF/views/*.jsp`) and static resources (`/css/**`, `/js/**`, `/images/**`).
3. Spring Security 6 `SecurityConfig` with BCrypt password hashing, session migration protection, and public access for landing, static resources, and auth pages.
4. `HomeController` serving `/` and `/home` with active nav states and model attributes.
5. Reusable modular JSP fragments:
   * `common/header.jsp`
   * `common/navbar.jsp`
   * `common/footer.jsp`
   * `error/403.jsp`
6. Responsive landing page `home/index.jsp` featuring:
   * Headline: *"Turn Farm Waste Into Wealth"*
   * Subheadline: *"Give Agricultural Waste a Second Life"*
   * Farmer & Buyer CTAs
   * 8 agricultural waste categories (Wheat straw, Rice husk, Sugarcane trash, Cotton stalks, etc.)
   * 4-step marketplace workflow
   * Farmer vs. Buyer benefit breakdown
   * Sustainability impact section
7. `style.css` implementing CSS custom property design tokens (Forest Green `#1b4332`, Fresh Leaf Green `#52b788`, Warm Amber `#d97706`).
8. `main.js` providing navbar scroll behavior, alert dismissals, and smooth anchor scrolling.
9. Automated tests in `WasteToWealthApplicationTests.java`.

---

## Running the Application

### Prerequisites
* JDK 17+ installed
* Maven 3.8+ installed (or use provided `.\mvn.cmd`)
* MySQL 8.x running on port 3306

### Commands

1. **Compile and Run Tests**:
   ```powershell
   .\mvn.cmd clean test
   ```

2. **Run Application**:
   ```powershell
   .\mvn.cmd spring-boot:run
   ```

3. **Access Public Landing Page**:
   Open browser at: [http://localhost:8082](http://localhost:8082)

---

## Deployment on Render Web Service

This project is configured with a multi-stage `Dockerfile` and `render.yaml` ready for 1-click deployment on [Render](https://render.com):

1. **Create a MySQL Database**:
   - You can use a managed MySQL database on Aiven, PlanetScale, TiDB Cloud, or Render.
2. **Deploy the Web Service**:
   - Connect your GitHub repository: `https://github.com/sameermajanushaikh/Waste-to-Wealth.git`
   - Select **Docker** environment (or Blueprint `render.yaml`).
   - Configure Environment Variables:
     - `PORT`: `8080` (or leave default assigned by Render)
     - `DB_HOST`: `<your-mysql-host>`
     - `DB_PORT`: `3306`
     - `DB_NAME`: `waste_to_wealth`
     - `DB_USER`: `<your-mysql-user>`
     - `DB_PASSWORD`: `<your-mysql-password>`
     - `SPRING_PROFILES_ACTIVE`: `dev`
3. Flyway migrations (`V1`, `V2`, `V3`) will execute automatically on startup, establishing schemas, seed categories, UPI payment tracking, and demo users.

---

## Key Features

1. **Trilingual Support**: English (`en`), Marathi (`mr`), Hindi (`hi`) with cookie-based language switcher.
2. **Farmer Waste Posting with UPI**: Farmers specify their personal UPI ID when publishing lots.
3. **Buyer Advance Booking with Auto Stock Deduction**: Buyers book waste by paying a 20% advance token directly to the farmer's UPI ID, inputting their UTR reference. Available lot stock is automatically reduced by the purchased quantity, marking the listing as `SOLD` when exhausted.
4. **Role-Based Access Control**: Spring Security 6 session-protected areas for Farmer (`/farmer/**`), Buyer (`/buyer/**`), and Admin (`/admin/**`).
5. **Admin Operations**: Full user management (Farmer, Buyer, Admin) and waste listing CRUD controls.
