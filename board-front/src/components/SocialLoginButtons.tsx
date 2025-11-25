import React from "react";

const API_BASE_URL =
  import.meta.env.VITE_API_BASE_URL ?? "http://localhost:8080";
const FRONT_REDIRECT_URL =
  import.meta.env.VITE_OAUTH2_REDIRECT_URL ??
  "http://localhost:5173/oauth2/callback";

/**
 * 소셜 로그인 버튼
 * - 클릭 시 Spring Security OAuth2 엔드포인트로 리다이렉트
 * - 백엔드: /oauth2/authorization/{provider}
 */
export const SocialLoginButtons: React.FC = () => {
  const handleSocialLogin = (provider: "google" | "kakao" | "naver") => {
    const authUrl = `${API_BASE_URL}/oauth2/authorization/${provider}?redirect_uri=${encodeURIComponent(
      FRONT_REDIRECT_URL
    )}`;
    window.location.href = authUrl;
  };

  return (
    <div style={{ display: "flex", flexDirection: "column", gap: 8, marginTop: 16 }}>
      <button onClick={() => handleSocialLogin("google")}>Google로 로그인</button>
      <button onClick={() => handleSocialLogin("kakao")}>Kakao로 로그인</button>
      <button onClick={() => handleSocialLogin("naver")}>Naver로 로그인</button>
    </div>
  );
};