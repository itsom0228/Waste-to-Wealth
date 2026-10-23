package com.wastetowealth;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;

import org.springframework.scheduling.annotation.EnableScheduling;

/**
 * Waste to Wealth - Farm Waste to Money Platform
 * 
 * Main entry point for the Spring Boot application.
 * Extends SpringBootServletInitializer for traditional WAR deployment compatibility
 * and embedded Tomcat JSP compilation.
 */
@SpringBootApplication
@EnableScheduling
public class WasteToWealthApplication extends SpringBootServletInitializer {

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder application) {
        return application.sources(WasteToWealthApplication.class);
    }

    public static void main(String[] args) {
        SpringApplication.run(WasteToWealthApplication.class, args);
    }
}
