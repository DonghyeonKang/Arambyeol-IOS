{
    "openapi": "3.0.1",
    "info": {
        "title": "아람별 API",
        "description": "아람별 식단 관리 시스템 API - Bearer 토큰 또는 쿠키 인증 지원",
        "version": "1.0.0"
    },
    "servers": [
        {
            "url": "https://api.arambyeol.com",
            "description": "Production Server"
        },
        {
            "url": "http://localhost:8080",
            "description": "Local Server"
        }
    ],
    "security": [
        {
            "bearerAuth": []
        },
        {
            "cookieAuth": []
        }
    ],
    "tags": [
        {
            "name": "Auth",
            "description": "인증 관련 API"
        },
        {
            "name": "Review",
            "description": "리뷰 관련 API"
        },
        {
            "name": "Plan",
            "description": "식단표 관련 API"
        },
        {
            "name": "Views",
            "description": "조회수 관련 API"
        }
    ],
    "paths": {
        "/reviews/{reviewId}": {
            "put": {
                "tags": [
                    "Review"
                ],
                "summary": "리뷰 수정",
                "description": "작성한 리뷰를 수정합니다.",
                "operationId": "updateReview",
                "parameters": [
                    {
                        "name": "reviewId",
                        "in": "path",
                        "description": "리뷰 ID",
                        "required": true,
                        "schema": {
                            "type": "integer",
                            "format": "int64"
                        },
                        "example": 1
                    }
                ],
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/ReviewRequestDto"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "400": {
                        "description": "잘못된 요청",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ReviewResponseDto"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "인증되지 않은 사용자",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ReviewResponseDto"
                                }
                            }
                        }
                    },
                    "404": {
                        "description": "리뷰를 찾을 수 없음",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ReviewResponseDto"
                                }
                            }
                        }
                    },
                    "200": {
                        "description": "리뷰 수정 성공",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ReviewResponseDto"
                                }
                            }
                        }
                    },
                    "403": {
                        "description": "리뷰 수정 권한 없음",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ReviewResponseDto"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/reviews/menus/{menuId}": {
            "post": {
                "tags": [
                    "Review"
                ],
                "summary": "리뷰 작성",
                "description": "특정 메뉴에 대한 리뷰를 작성합니다.",
                "operationId": "createReview",
                "parameters": [
                    {
                        "name": "menuId",
                        "in": "path",
                        "description": "메뉴 ID",
                        "required": true,
                        "schema": {
                            "type": "integer",
                            "format": "int32"
                        },
                        "example": 1
                    }
                ],
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/ReviewRequestDto"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "리뷰 작성 성공",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ReviewResponseDto"
                                }
                            }
                        }
                    },
                    "400": {
                        "description": "잘못된 요청",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ReviewResponseDto"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "인증되지 않은 사용자",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ReviewResponseDto"
                                }
                            }
                        }
                    },
                    "409": {
                        "description": "이미 리뷰가 존재함",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/ReviewResponseDto"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/auth/verify-code": {
            "post": {
                "tags": [
                    "Auth"
                ],
                "operationId": "verifyCode",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/EmailVerifyDto"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "OK",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "object"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/auth/send-verification": {
            "post": {
                "tags": [
                    "Auth"
                ],
                "operationId": "sendVerification",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/EmailRequestDto"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "OK",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "object"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/auth/register": {
            "post": {
                "tags": [
                    "Auth"
                ],
                "summary": "회원 가입",
                "description": "새로운 사용자를 등록합니다.",
                "operationId": "register",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/UserRequestDto"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "OK",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "object"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/auth/refresh": {
            "post": {
                "tags": [
                    "Auth"
                ],
                "summary": "토큰 갱신",
                "description": "Refresh Token을 사용하여 새로운 Access Token을 발급합니다.",
                "operationId": "refreshToken",
                "parameters": [
                    {
                        "name": "refresh_token",
                        "in": "cookie",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "object"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/auth/password/reset": {
            "post": {
                "tags": [
                    "Auth"
                ],
                "summary": "비밀번호 재설정",
                "description": "사용자의 비밀번호를 재설정합니다.",
                "operationId": "resetPassword",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/PasswordResetDto"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "OK",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "object"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/auth/logout": {
            "post": {
                "tags": [
                    "Auth"
                ],
                "summary": "로그아웃",
                "description": "사용자 로그아웃 및 쿠키 삭제",
                "operationId": "logout",
                "parameters": [
                    {
                        "name": "refresh_token",
                        "in": "cookie",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "object"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/auth/login": {
            "post": {
                "tags": [
                    "Auth"
                ],
                "summary": "로그인 (웹용)",
                "description": "사용자 인증 후 JWT 토큰을 HTTP Only 쿠키로 발급합니다.",
                "operationId": "login",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/LoginRequestDto"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "OK",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "object"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/auth/login/app": {
            "post": {
                "tags": [
                    "Auth"
                ],
                "summary": "로그인 (앱용)",
                "description": "사용자 인증 후 JWT 토큰을 응답 본문으로 발급합니다.",
                "operationId": "loginForApp",
                "requestBody": {
                    "content": {
                        "application/json": {
                            "schema": {
                                "$ref": "#/components/schemas/LoginRequestDto"
                            }
                        }
                    },
                    "required": true
                },
                "responses": {
                    "200": {
                        "description": "OK",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/TokenResponseDto"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/views/": {
            "get": {
                "tags": [
                    "Views"
                ],
                "summary": "조회수 조회",
                "description": "조회수를 조회합니다.",
                "operationId": "getViews",
                "responses": {
                    "200": {
                        "description": "OK",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "object"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/reviews/my": {
            "get": {
                "tags": [
                    "Review"
                ],
                "summary": "내 리뷰 목록 조회",
                "description": "사용자가 작성한 리뷰 목록을 페이지네이션과 함께 조회합니다.",
                "operationId": "getMyReviews",
                "parameters": [
                    {
                        "name": "page",
                        "in": "query",
                        "description": "페이지 번호 (0부터 시작)",
                        "required": false,
                        "schema": {
                            "type": "integer",
                            "format": "int32",
                            "default": 0
                        },
                        "example": 0
                    },
                    {
                        "name": "size",
                        "in": "query",
                        "description": "페이지 크기",
                        "required": false,
                        "schema": {
                            "type": "integer",
                            "format": "int32",
                            "default": 10
                        },
                        "example": 10
                    },
                    {
                        "name": "sort",
                        "in": "query",
                        "description": "정렬 기준 (reviewId)",
                        "required": false,
                        "schema": {
                            "type": "string",
                            "default": "reviewId"
                        },
                        "example": "reviewId"
                    },
                    {
                        "name": "direction",
                        "in": "query",
                        "description": "정렬 방향 (asc/desc)",
                        "required": false,
                        "schema": {
                            "type": "string",
                            "default": "desc"
                        },
                        "example": "desc"
                    }
                ],
                "responses": {
                    "200": {
                        "description": "리뷰 목록 조회 성공",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/PageResponseDtoReviewResponseDto"
                                }
                            }
                        }
                    },
                    "401": {
                        "description": "인증되지 않은 사용자",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/PageResponseDtoReviewResponseDto"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/plans": {
            "get": {
                "tags": [
                    "Plan"
                ],
                "summary": "향후 식단 조회",
                "description": "오늘 이후의 모든 식단과 메뉴별 평균 평점을 조회합니다.",
                "operationId": "getFuturePlans",
                "responses": {
                    "200": {
                        "description": "OK",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "array",
                                    "items": {
                                        "$ref": "#/components/schemas/PlanResponseDto"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        },
        "/plans/{date}": {
            "get": {
                "tags": [
                    "Plan"
                ],
                "summary": "특정 날짜 식단 조회",
                "description": "지정된 날짜의 식단과 메뉴별 평균 평점을 조회합니다.",
                "operationId": "getDailyPlan",
                "parameters": [
                    {
                        "name": "date",
                        "in": "path",
                        "description": "조회할 날짜 (형식: yyyy-MM-dd)",
                        "required": true,
                        "schema": {
                            "type": "string"
                        },
                        "example": "2024-03-20"
                    }
                ],
                "responses": {
                    "400": {
                        "description": "잘못된 날짜 형식",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/PlanResponseDto"
                                }
                            }
                        }
                    },
                    "404": {
                        "description": "해당 날짜의 식단이 없음",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/PlanResponseDto"
                                }
                            }
                        }
                    },
                    "200": {
                        "description": "식단 조회 성공",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "$ref": "#/components/schemas/PlanResponseDto"
                                }
                            }
                        }
                    }
                }
            }
        },
        "/plans/weekly/{date}": {
            "get": {
                "tags": [
                    "Plan"
                ],
                "summary": "주간 식단 조회",
                "description": "지정된 날짜가 포함된 주의 전체 식단을 조회합니다.",
                "operationId": "getWeeklyPlan",
                "parameters": [
                    {
                        "name": "date",
                        "in": "path",
                        "description": "조회할 기준 날짜 (형식: yyyy-MM-dd)",
                        "required": true,
                        "schema": {
                            "type": "string"
                        },
                        "example": "2024-03-20"
                    }
                ],
                "responses": {
                    "400": {
                        "description": "잘못된 날짜 형식",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "array",
                                    "items": {
                                        "$ref": "#/components/schemas/PlanResponseDto"
                                    }
                                }
                            }
                        }
                    },
                    "404": {
                        "description": "해당 주의 식단이 없음",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "array",
                                    "items": {
                                        "$ref": "#/components/schemas/PlanResponseDto"
                                    }
                                }
                            }
                        }
                    },
                    "200": {
                        "description": "주간 식단 조회 성공",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "array",
                                    "items": {
                                        "$ref": "#/components/schemas/PlanResponseDto"
                                    }
                                }
                            }
                        }
                    }
                }
            }
        },
        "/auth/check/{username}": {
            "get": {
                "tags": [
                    "Auth"
                ],
                "summary": "사용자명 중복 확인",
                "description": "사용자명의 중복 여부를 확인합니다.",
                "operationId": "checkUsername",
                "parameters": [
                    {
                        "name": "username",
                        "in": "path",
                        "required": true,
                        "schema": {
                            "type": "string"
                        }
                    }
                ],
                "responses": {
                    "200": {
                        "description": "OK",
                        "content": {
                            "application/json": {
                                "schema": {
                                    "type": "object"
                                }
                            }
                        }
                    }
                }
            }
        }
    },
    "components": {
        "schemas": {
            "ReviewRequestDto": {
                "required": [
                    "menuId",
                    "score"
                ],
                "type": "object",
                "properties": {
                    "menuId": {
                        "type": "integer",
                        "description": "메뉴 ID",
                        "format": "int32",
                        "example": 1
                    },
                    "score": {
                        "maximum": 5,
                        "minimum": 1,
                        "type": "integer",
                        "description": "평점 (1-5점)",
                        "format": "int32",
                        "example": 4
                    }
                },
                "description": "리뷰 작성 요청 DTO"
            },
            "ReviewResponseDto": {
                "type": "object",
                "properties": {
                    "reviewId": {
                        "type": "integer",
                        "description": "리뷰 ID",
                        "format": "int64",
                        "example": 1
                    },
                    "menuId": {
                        "type": "integer",
                        "description": "메뉴 ID",
                        "format": "int32",
                        "example": 1
                    },
                    "username": {
                        "type": "string",
                        "description": "사용자명",
                        "example": "user@example.com"
                    },
                    "menuName": {
                        "type": "string",
                        "description": "메뉴명",
                        "example": "김치찌개"
                    },
                    "imgPath": {
                        "type": "string",
                        "description": "이미지 경로",
                        "example": "/images/kimchi-jjigae.jpg"
                    },
                    "score": {
                        "type": "integer",
                        "description": "평점",
                        "format": "int32",
                        "example": 4
                    }
                },
                "description": "리뷰 응답 DTO"
            },
            "EmailVerifyDto": {
                "type": "object",
                "properties": {
                    "email": {
                        "type": "string"
                    },
                    "code": {
                        "type": "string"
                    }
                }
            },
            "EmailRequestDto": {
                "type": "object",
                "properties": {
                    "email": {
                        "type": "string"
                    }
                }
            },
            "UserRequestDto": {
                "required": [
                    "password",
                    "username"
                ],
                "type": "object",
                "properties": {
                    "username": {
                        "type": "string",
                        "description": "사용자 이메일",
                        "example": "user@example.com"
                    },
                    "password": {
                        "maxLength": 2147483647,
                        "minLength": 8,
                        "type": "string",
                        "description": "사용자 비밀번호",
                        "example": "password123"
                    }
                },
                "description": "회원가입 요청 DTO"
            },
            "PasswordResetDto": {
                "required": [
                    "newPassword",
                    "username"
                ],
                "type": "object",
                "properties": {
                    "username": {
                        "type": "string",
                        "description": "사용자 이메일",
                        "example": "user@example.com"
                    },
                    "newPassword": {
                        "maxLength": 2147483647,
                        "minLength": 8,
                        "type": "string",
                        "description": "새 비밀번호",
                        "example": "newpassword123"
                    }
                },
                "description": "비밀번호 재설정 요청 DTO"
            },
            "LoginRequestDto": {
                "required": [
                    "password",
                    "username"
                ],
                "type": "object",
                "properties": {
                    "username": {
                        "type": "string",
                        "description": "사용자 이메일",
                        "example": "user@example.com"
                    },
                    "password": {
                        "type": "string",
                        "description": "사용자 비밀번호",
                        "example": "password123"
                    }
                },
                "description": "로그인 요청 DTO"
            },
            "TokenResponseDto": {
                "type": "object",
                "properties": {
                    "accessToken": {
                        "type": "string",
                        "description": "액세스 토큰",
                        "example": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
                    },
                    "refreshToken": {
                        "type": "string",
                        "description": "리프레시 토큰",
                        "example": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..."
                    }
                },
                "description": "토큰 응답 DTO"
            },
            "PageResponseDtoReviewResponseDto": {
                "type": "object",
                "properties": {
                    "content": {
                        "type": "array",
                        "description": "데이터 목록",
                        "items": {
                            "$ref": "#/components/schemas/ReviewResponseDto"
                        }
                    },
                    "pageNumber": {
                        "type": "integer",
                        "description": "현재 페이지 번호",
                        "format": "int32",
                        "example": 0
                    },
                    "pageSize": {
                        "type": "integer",
                        "description": "페이지 크기",
                        "format": "int32",
                        "example": 10
                    },
                    "totalElements": {
                        "type": "integer",
                        "description": "전체 요소 개수",
                        "format": "int64",
                        "example": 100
                    },
                    "totalPages": {
                        "type": "integer",
                        "description": "전체 페이지 개수",
                        "format": "int32",
                        "example": 10
                    },
                    "hasNext": {
                        "type": "boolean",
                        "description": "다음 페이지 존재 여부",
                        "example": true
                    },
                    "hasPrevious": {
                        "type": "boolean",
                        "description": "이전 페이지 존재 여부",
                        "example": false
                    }
                },
                "description": "페이지 응답 DTO"
            },
            "DailyMenuDto": {
                "type": "object",
                "properties": {
                    "menuId": {
                        "type": "integer",
                        "description": "메뉴 ID",
                        "format": "int32",
                        "example": 1
                    },
                    "menuName": {
                        "type": "string",
                        "description": "메뉴명",
                        "example": "김치찌개"
                    },
                    "mealType": {
                        "type": "string",
                        "description": "식사 타입",
                        "example": "LUNCH",
                        "enum": [
                            "BREAKFAST",
                            "LUNCH",
                            "DINNER"
                        ]
                    },
                    "course": {
                        "type": "string",
                        "description": "코스",
                        "example": "메인"
                    },
                    "imgPath": {
                        "type": "string",
                        "description": "이미지 경로",
                        "example": "/images/kimchi-jjigae.jpg"
                    },
                    "averageScore": {
                        "type": "number",
                        "description": "평균 평점",
                        "format": "double",
                        "example": 4.5
                    },
                    "reviewCount": {
                        "type": "integer",
                        "description": "리뷰 개수",
                        "format": "int32",
                        "example": 10
                    }
                },
                "description": "일일 메뉴 DTO"
            },
            "PlanResponseDto": {
                "type": "object",
                "properties": {
                    "date": {
                        "type": "string",
                        "description": "날짜",
                        "example": "2024-03-20"
                    },
                    "menusByMealType": {
                        "type": "object",
                        "additionalProperties": {
                            "type": "array",
                            "description": "식사 타입별 메뉴 목록",
                            "items": {
                                "$ref": "#/components/schemas/DailyMenuDto"
                            }
                        },
                        "description": "식사 타입별 메뉴 목록"
                    }
                },
                "description": "식단 응답 DTO"
            }
        },
        "securitySchemes": {
            "bearerAuth": {
                "type": "http",
                "description": "Authorization 헤더에 Bearer 토큰을 포함",
                "scheme": "bearer",
                "bearerFormat": "JWT"
            },
            "cookieAuth": {
                "type": "apiKey",
                "description": "HTTP Only 쿠키로 설정된 Access Token",
                "name": "access_token",
                "in": "cookie"
            }
        }
    }
}