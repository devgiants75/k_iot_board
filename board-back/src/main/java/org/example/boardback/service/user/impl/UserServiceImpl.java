package org.example.boardback.service.user.impl;

import org.example.boardback.dto.ResponseDto;
import org.example.boardback.dto.user.request.UserProfileUpdateRequest;
import org.example.boardback.dto.user.response.MeResponseDto;
import org.example.boardback.dto.user.response.UserResponseDto;
import org.example.boardback.service.user.UserService;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Override
    public ResponseDto<MeResponseDto> getMe(Long userId) {
        return null;
    }

    @Override
    public ResponseDto<UserResponseDto> getUserById(Long userId) {
        return null;
    }

    @Override
    public ResponseDto<UserResponseDto> updateProfile(Long userId, UserProfileUpdateRequest request) {
        return null;
    }
}
