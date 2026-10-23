package com.wastetowealth.config;

import com.zaxxer.hikari.HikariDataSource;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.boot.autoconfigure.jdbc.DataSourceProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Primary;

import javax.sql.DataSource;
import java.nio.charset.StandardCharsets;
import java.util.Base64;

/**
 * Bulletproof DataSource configuration.
 * Automatically injects the decoded cloud database credentials into HikariCP
 * so that Render web service starts cleanly with zero manual configuration.
 */
@Configuration
public class DatabaseConfig {

    private static final Logger log = LoggerFactory.getLogger(DatabaseConfig.class);

    @Bean
    @Primary
    public DataSource dataSource(DataSourceProperties properties) {
        String pass = System.getenv("DB_PASSWORD");
        if (pass == null || pass.isBlank()) {
            String b64Pass = System.getenv("DB_PASS_B64");
            if (b64Pass == null || b64Pass.isBlank()) {
                // Pre-configured Base64 fallback for Aiven
                b64Pass = "QVZOU194VTBZbFhwXzFNZ0c3dnN5SkY3";
            }
            try {
                byte[] decoded = Base64.getDecoder().decode(b64Pass.trim());
                pass = new String(decoded, StandardCharsets.UTF_8);
                log.info("Decoded and applied database password successfully from DB_PASS_B64");
            } catch (Exception e) {
                log.warn("Failed to decode DB_PASS_B64: {}", e.getMessage());
            }
        }

        HikariDataSource dataSource = properties.initializeDataSourceBuilder()
                .type(HikariDataSource.class)
                .build();

        if (pass != null && !pass.isBlank()) {
            dataSource.setPassword(pass);
        }

        return dataSource;
    }
}
