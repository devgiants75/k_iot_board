package org.example.boardback.dto.auth.response;

public record PasswordVerifyResponseDto(
        boolean valid,
        String email
) {
    public static PasswordVerifyResponseDto of(boolean valid, String email) {
        return new PasswordVerifyResponseDto(valid, email);
    }
}