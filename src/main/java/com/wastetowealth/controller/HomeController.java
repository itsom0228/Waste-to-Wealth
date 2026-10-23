package com.wastetowealth.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Controller handling the public landing page and informational views.
 */
@Controller
public class HomeController {

    @GetMapping({"/", "/home"})
    public String home(Model model) {
        model.addAttribute("pageTitle", "Turn Farm Waste Into Wealth — Waste to Wealth Platform");
        model.addAttribute("activeNav", "home");
        return "home/index";
    }

    @GetMapping("/access-denied")
    public String accessDenied(Model model) {
        model.addAttribute("pageTitle", "Access Denied — Waste to Wealth");
        return "error/403";
    }
}
