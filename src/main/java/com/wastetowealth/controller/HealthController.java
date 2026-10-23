package com.wastetowealth.controller;

import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;

/**
 * Lightweight health check endpoint for monitoring, Render keep-alive pings, and uptime monitors.
 */
@RestController
public class HealthController {

    @GetMapping({"/ping", "/health", "/api/health"})
    public ResponseEntity<Map<String, Object>> ping() {
        Map<String, Object> response = new HashMap<>();
        response.put("status", "UP");
        response.put("service", "Waste to Wealth Platform");
        response.put("timestamp", LocalDateTime.now().toString());
        return ResponseEntity.ok(response);
    }
}
