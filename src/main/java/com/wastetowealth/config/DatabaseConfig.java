package com.wastetowealth.config;

import jakarta.annotation.PostConstruct;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.context.annotation.Configuration;

import java.nio.charset.StandardCharsets;
import java.util.Base64;

/**
 * Ensures cloud database credentials (including Base64 encoded secrets)
 * are cleanly injected into DataSourceProperties on container startup.
 */
@Configuration
public class DatabaseConfig {

    private static final Logger log = LoggerFactory.getLogger(DatabaseConfig.class);
    private final DataSourceProperties dataSourceProperties;

    public DatabaseConfig(DataSourceProperties dataSourceProperties) {
        this.dataSourceProperties = dataSourceProperties;
    }

    @PostConstruct
    public void configureCredentials() {
        String b64Pass = System.getenv("DB_PASS_B64");
        if (b64Pass != null && !b64Pass.isBlank()) {
            try {
                byte[] decoded = Base64.getDecoder().decode(b64Pass.trim());
                String decodedPass = new String(decoded, StandardCharsets.UTF_8);
                dataSourceProperties.setPassword(decodedPass);
                log.info("Decoded and injected database password successfully from DB_PASS_B64");
            } catch (Exception e) {
                log.warn("Failed to decode DB_PASS_B64: {}", e.getMessage());
            }
        }
    }
}
