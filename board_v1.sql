DROP DATABASE IF EXISTS `board_v1`;
CREATE DATABASE IF NOT EXISTS `board_v1`
	CHARACTER SET utf8mb4
    COLLATE utf8mb4_general_ci;
USE `board_v1`;

SET NAMES utf8mb4;				# 클라이언트와 MySQL 서버 간의 문자 인코딩 설정
SET FOREIGN_KEY_CHECKS = 0;		# 외래 키 제약 조건 검사를 일시적으로 끄는 설정

# === USERS (사용자) === #
DROP TABLE IF EXISTS user_roles;
DROP TABLE IF EXISTS roles;
DROP TABLE IF EXISTS refresh_tokens;
DROP TABLE IF EXISTS users;

CREATE TABLE users (
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
    
    username VARCHAR(50) NOT NULL COMMENT '로그인 ID',
    password VARCHAR(255) NOT NULL COMMENT 'Bcrypt 암호화 비밀번호',
    email VARCHAR(255) NOT NULL COMMENT '사용자 이메일',
    nickname VARCHAR(50) NOT NULL COMMENT '닉네임',
    
    gender VARCHAR(10) COMMENT '성별',
    
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    
    CONSTRAINT `uk_users_username` UNIQUE(username),
    CONSTRAINT `uk_users_email` UNIQUE(email),
    CONSTRAINT `uk_users_nickname` UNIQUE(nickname),
    CONSTRAINT `chk_users_gender` CHECK(gender IN ('MALE', 'FEMALE', 'OTHER', 'NONE'))
)
	ENGINE=InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_unicode_ci
    COMMENT = '사용자 기본 정보 테이블';

# === ROLES (권한) === #
CREATE TABLE roles (
	role_name VARCHAR(30) PRIMARY KEY,
    CONSTRAINT `chk_roles_role_name` CHECK(role_name IN ('ROLE_USER', 'ROLE_ADMIN', 'ROLE_MANAGER'))
)
	ENGINE=InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_unicode_ci
    COMMENT = '사용자 권한 테이블';

# === USER_ROLES (유저-권한 매핑) === #
CREATE TABLE user_roles (
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL,
    role_name VARCHAR(30) NOT NULL,
    
    UNIQUE KEY `uk_user_roles_user_id_role_name` (user_id, role_name),
    INDEX `idx_user_roles_user_id` (user_id),
    INDEX `idx_user_roles_role_name` (role_name),
    
    CONSTRAINT `fk_user_role_user` FOREIGN KEY (user_id) REFERENCES users(id),
    CONSTRAINT `fk_user_role_role` FOREIGN KEY (role_name) REFERENCES roles(role_name)
)
	ENGINE=InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_unicode_ci
    COMMENT = '유저-권한 매핑 테이블';

# === REFRESH TOKENS (1:1 관계) === #
CREATE TABLE refresh_tokens (
	id BIGINT AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT NOT NULL UNIQUE COMMENT '사용자 ID',
    token VARCHAR(350) NOT NULL COMMENT '리프레시 토큰 값',
    expiry DATETIME(6) NOT NULL COMMENT '만료 시간',
    
    created_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6),
    updated_at DATETIME(6) NOT NULL DEFAULT CURRENT_TIMESTAMP(6) ON UPDATE CURRENT_TIMESTAMP(6),
    
    INDEX `idx_refresh_token_user_id` (user_id),
    
    CONSTRAINT `fk_refresh_token_user` FOREIGN KEY (user_id) REFERENCES users(id)
)
	ENGINE=InnoDB
    DEFAULT CHARSET = utf8mb4
    COLLATE = utf8mb4_unicode_ci
    COMMENT = '리프레시 토큰 저장 테이블';








SET FOREIGN_KEY_CHECKS = 1;