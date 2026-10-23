package com.wastetowealth.controller;

import com.wastetowealth.dto.UserRegistrationDto;
import com.wastetowealth.service.UserService;
import jakarta.validation.Valid;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

/**
 * Controller handling authentication routes: /login, /register, and /register-process.
 */
@Controller
public class AuthController {

    private final UserService userService;

    public AuthController(UserService userService) {
        this.userService = userService;
    }

    @GetMapping("/login")
    public String login(
            @RequestParam(value = "error", required = false) String error,
            @RequestParam(value = "logout", required = false) String logout,
            @RequestParam(value = "registered", required = false) String registered,
            Model model) {
        
        model.addAttribute("pageTitle", "Sign In — Waste to Wealth");
        if (registered != null) {
            model.addAttribute("registeredSuccess", true);
        }
        if (error != null) {
            model.addAttribute("errorMessage", "Invalid email or password. Please try again.");
        }
        if (logout != null) {
            model.addAttribute("logoutMessage", "You have been logged out successfully.");
        }
        return "auth/login";
    }

    @GetMapping("/register")
    public String register(
            @RequestParam(value = "role", required = false, defaultValue = "FARMER") String role,
            Model model) {
        
        model.addAttribute("pageTitle", "Create an Account — Waste to Wealth");
        model.addAttribute("selectedRole", role.toUpperCase());
        if (!model.containsAttribute("user")) {
            UserRegistrationDto dto = new UserRegistrationDto();
            dto.setRole(role.toUpperCase());
            model.addAttribute("user", dto);
        }
        return "auth/register";
    }

    @PostMapping("/register-process")
    public String registerProcess(
            @Valid @ModelAttribute("user") UserRegistrationDto dto,
            BindingResult bindingResult,
            RedirectAttributes redirectAttributes,
            Model model) {

        if (bindingResult.hasErrors()) {
            model.addAttribute("pageTitle", "Create an Account — Waste to Wealth");
            model.addAttribute("selectedRole", dto.getRole() != null ? dto.getRole() : "FARMER");
            return "auth/register";
        }

        try {
            userService.registerUser(dto);
            redirectAttributes.addFlashAttribute("registeredSuccess", true);
            return "redirect:/login?registered=true";
        } catch (IllegalArgumentException ex) {
            model.addAttribute("errorMessage", ex.getMessage());
            model.addAttribute("pageTitle", "Create an Account — Waste to Wealth");
            model.addAttribute("selectedRole", dto.getRole() != null ? dto.getRole() : "FARMER");
            return "auth/register";
        } catch (Exception ex) {
            model.addAttribute("errorMessage", "Registration failed: " + ex.getMessage());
            model.addAttribute("pageTitle", "Create an Account — Waste to Wealth");
            model.addAttribute("selectedRole", dto.getRole() != null ? dto.getRole() : "FARMER");
            return "auth/register";
        }
    }
}
