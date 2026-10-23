package com.wastetowealth.service;

import com.wastetowealth.dto.UserRegistrationDto;
import com.wastetowealth.entity.User;

import java.util.Optional;

public interface UserService {
    User registerUser(UserRegistrationDto dto);
    Optional<User> findByEmail(String email);
    void updateLastLogin(String email);
}
