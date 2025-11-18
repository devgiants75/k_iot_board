// user.type.ts

// 1) 도메인 (Table, Entity 기준)
//    + Omit, Partial 방법
// 2) 도메인
//    + DTO 타입 정의 분리
export interface User {

}

export interface UserDetail {

}

export interface UserListData {

}

export type UserList =  UserListData[];
