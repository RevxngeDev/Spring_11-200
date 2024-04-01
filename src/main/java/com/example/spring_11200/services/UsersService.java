package com.example.spring_11200.services;

import com.example.spring_11200.dto.UserDto;

import java.util.List;

public interface UsersService {
    List<UserDto> getAllUsers();
}
