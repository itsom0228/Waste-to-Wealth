package com.wastetowealth.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.net.URI;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.time.Duration;

/**
 * Automatically prevents Render Web Service from sleeping after 15 minutes of inactivity.
 * Pings its own public URL every 10 minutes so Render detects incoming HTTP traffic and stays awake 24/7.
 */
@Service
public class RenderKeepAliveService {

    private static final Logger log = LoggerFactory.getLogger(RenderKeepAliveService.class);

    private final HttpClient httpClient = HttpClient.newBuilder()
            .connectTimeout(Duration.ofSeconds(10))
            .build();

    // Render automatically provides RENDER_EXTERNAL_URL (e.g. https://waste-to-wealth.onrender.com)
    @Value("${RENDER_EXTERNAL_URL:#{null}}")
    private String renderExternalUrl;

    // Optional user override (e.g. https://my-custom-domain.com)
    @Value("${APP_URL:#{null}}")
    private String appUrl;

    // Run every 10 minutes (600,000 ms) with an initial delay of 2 minutes (120,000 ms)
    @Scheduled(initialDelay = 120000, fixedRate = 600000)
    public void pingSelfToPreventSleep() {
        String baseUrl = (appUrl != null && !appUrl.isBlank()) ? appUrl.trim() :
                (renderExternalUrl != null && !renderExternalUrl.isBlank() ? renderExternalUrl.trim() : null);

        if (baseUrl == null) {
            log.debug("Render keep-alive ping skipped: Neither APP_URL nor RENDER_EXTERNAL_URL is set (local dev environment).");
            return;
        }

        if (!baseUrl.endsWith("/")) {
            baseUrl += "/";
        }
        String pingUrl = baseUrl + "ping";

        try {
            HttpRequest request = HttpRequest.newBuilder()
                    .uri(URI.create(pingUrl))
                    .timeout(Duration.ofSeconds(15))
                    .header("User-Agent", "WasteToWealth-KeepAlive/1.0")
                    .GET()
                    .build();

            HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
            log.info("Render Keep-Alive ping to {} succeeded with HTTP {}", pingUrl, response.statusCode());
        } catch (Exception e) {
            log.warn("Render Keep-Alive ping to {} failed: {}", pingUrl, e.getMessage());
        }
    }
}
