package com.wastetowealth;

import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;

@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("dev")
class WasteToWealthApplicationTests {

    @Autowired
    private MockMvc mockMvc;

    @Test
    @DisplayName("Context loads successfully")
    void contextLoads() {
        // Confirms Spring Boot application context bootstraps cleanly
    }

    @Test
    @DisplayName("Public home page returns 200 and loads home/index view")
    void testPublicHomePage() throws Exception {
        mockMvc.perform(get("/"))
                .andExpect(status().isOk())
                .andExpect(view().name("home/index"))
                .andExpect(model().attributeExists("pageTitle"))
                .andExpect(model().attribute("activeNav", "home"));
    }

    @Test
    @DisplayName("Public access-denied page returns 200 and loads error/403 view")
    void testAccessDeniedPage() throws Exception {
        mockMvc.perform(get("/access-denied"))
                .andExpect(status().isOk())
                .andExpect(view().name("error/403"))
                .andExpect(model().attributeExists("pageTitle"));
    }

    @Test
    @DisplayName("Login page returns 200 and loads auth/login view")
    void testLoginPage() throws Exception {
        mockMvc.perform(get("/login"))
                .andExpect(status().isOk())
                .andExpect(view().name("auth/login"))
                .andExpect(model().attributeExists("pageTitle"));
    }

    @Test
    @DisplayName("Register page returns 200 and loads auth/register view")
    void testRegisterPage() throws Exception {
        mockMvc.perform(get("/register"))
                .andExpect(status().isOk())
                .andExpect(view().name("auth/register"))
                .andExpect(model().attributeExists("pageTitle"))
                .andExpect(model().attribute("selectedRole", "FARMER"));
    }

    @Test
    @DisplayName("Marketplace browse returns 200 with listings, categories, and districts")
    void testMarketplaceBrowse() throws Exception {
        mockMvc.perform(get("/marketplace"))
                .andExpect(status().isOk())
                .andExpect(view().name("marketplace/index"))
                .andExpect(model().attributeExists("listings"))
                .andExpect(model().attributeExists("categories"))
                .andExpect(model().attributeExists("districts"))
                .andExpect(model().attribute("activeNav", "marketplace"));
    }

    @Test
    @DisplayName("Marketplace listing detail returns 200 with listing attributes")
    void testMarketplaceDetail() throws Exception {
        mockMvc.perform(get("/marketplace/listing/1"))
                .andExpect(status().isOk())
                .andExpect(view().name("marketplace/detail"))
                .andExpect(model().attributeExists("listing"))
                .andExpect(model().attribute("activeNav", "marketplace"));
    }

    @Test
    @DisplayName("Marketplace listing not found returns 200 and loads error/404 view")
    void testMarketplaceNotFound() throws Exception {
        mockMvc.perform(get("/marketplace/listing/9999"))
                .andExpect(status().isOk())
                .andExpect(view().name("error/404"))
                .andExpect(model().attributeExists("errorMessage"));
    }

    @Test
    @DisplayName("Home page supports Marathi language switch (?lang=mr)")
    void testMarathiLanguageSwitch() throws Exception {
        mockMvc.perform(get("/").param("lang", "mr"))
                .andExpect(status().isOk())
                .andExpect(view().name("home/index"))
                .andExpect(cookie().exists("PREFERRED_LANGUAGE"));
    }

    @Test
    @DisplayName("Home page supports Hindi language switch (?lang=hi)")
    void testHindiLanguageSwitch() throws Exception {
        mockMvc.perform(get("/").param("lang", "hi"))
                .andExpect(status().isOk())
                .andExpect(view().name("home/index"))
                .andExpect(cookie().exists("PREFERRED_LANGUAGE"));
    }
}
