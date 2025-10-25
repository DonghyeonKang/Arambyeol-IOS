# Arambyeol iOS

iOS 개발을 위한 기본적인 MVVM 아키텍처가 구현된 SwiftUI 프로젝트입니다.

## 📱 프로젝트 구조

### 아키텍처 패턴
- **MVVM (Model-View-ViewModel)** 패턴을 사용
- **Combine** 프레임워크를 활용한 반응형 프로그래밍
- **Protocol-Oriented Programming** 적용

### 폴더 구조
```
Arambyeol/
├── Models/                 # 데이터 모델
│   ├── BaseModel.swift     # 기본 모델 프로토콜 및 구현
│   └── User.swift          # 사용자 모델
├── ViewModels/             # 뷰모델
│   ├── BaseViewModel.swift # 기본 뷰모델 프로토콜 및 구현
│   └── HomeViewModel.swift # 홈 화면 뷰모델
├── Views/                  # 뷰 컴포넌트
│   ├── HomeView.swift      # 홈 화면
│   └── ComponentsView.swift # 재사용 가능한 컴포넌트들
├── Services/               # 서비스 레이어
│   ├── UserServiceProtocol.swift # 사용자 서비스 프로토콜
│   ├── UserService.swift   # 사용자 서비스 구현
│   └── NetworkService.swift # 네트워크 서비스
├── Utils/                  # 유틸리티
│   ├── Extensions.swift    # 확장 기능들
│   ├── Constants.swift     # 상수 정의
│   └── Logger.swift        # 로깅 시스템
├── ContentView.swift       # 메인 컨텐츠 뷰
└── ArambyeolApp.swift     # 앱 진입점
```

## 🏗️ 주요 컴포넌트

### 1. Models
- **BaseModel**: 모든 모델이 구현해야 하는 기본 프로토콜
- **User**: 사용자 정보를 담는 모델

### 2. ViewModels
- **BaseViewModel**: 공통 기능을 제공하는 기본 뷰모델
- **HomeViewModel**: 홈 화면의 비즈니스 로직 처리

### 3. Services
- **UserServiceProtocol**: 사용자 관련 서비스 인터페이스
- **UserService**: 사용자 데이터 관리 (현재는 Mock 데이터 사용)
- **NetworkService**: 네트워크 요청 처리

### 4. Views
- **HomeView**: 사용자 정보를 표시하는 홈 화면
- **ComponentsView**: 재사용 가능한 UI 컴포넌트들
- **SettingsView**: 앱 설정 화면

### 5. Utils
- **Extensions**: Date, String, Color, View 확장
- **Constants**: 앱 전반에서 사용되는 상수들
- **Logger**: 디버깅을 위한 로깅 시스템

## 🚀 주요 기능

### 현재 구현된 기능
- ✅ MVVM 아키텍처 기반 구조
- ✅ 탭 기반 네비게이션
- ✅ 사용자 정보 표시 (Mock 데이터)
- ✅ 로딩 상태 관리
- ✅ 에러 처리
- ✅ 재사용 가능한 UI 컴포넌트
- ✅ 설정 화면
- ✅ 로깅 시스템

### 향후 확장 가능한 기능
- 🔄 실제 API 연동
- 🔄 사용자 인증 시스템
- 🔄 데이터 캐싱
- 🔄 오프라인 지원
- 🔄 푸시 알림
- 🔄 다국어 지원

## 🛠️ 기술 스택

- **SwiftUI**: UI 프레임워크
- **Combine**: 반응형 프로그래밍
- **Foundation**: 기본 프레임워크
- **OSLog**: 시스템 로깅

## 📋 사용 방법

1. Xcode에서 프로젝트를 열기
2. 시뮬레이터 또는 실제 기기에서 실행
3. 탭을 통해 각 화면 탐색

## 🔧 개발 가이드

### 새로운 화면 추가하기
1. `Views/` 폴더에 새로운 View 파일 생성
2. `ViewModels/` 폴더에 해당 ViewModel 생성
3. 필요시 `Models/` 폴더에 데이터 모델 추가
4. `Services/` 폴더에 필요한 서비스 구현

### 새로운 서비스 추가하기
1. `Services/` 폴더에 프로토콜과 구현체 생성
2. 의존성 주입을 통해 ViewModel에서 사용
3. Mock 데이터로 먼저 테스트 후 실제 API 연동

## 📝 코딩 컨벤션

- **파일명**: PascalCase 사용
- **클래스/구조체**: PascalCase 사용
- **함수/변수**: camelCase 사용
- **상수**: UPPER_SNAKE_CASE 사용
- **MARK 주석**: 코드 섹션 구분에 사용

## 🤝 기여하기

1. 이슈 생성 또는 기존 이슈 확인
2. 기능 브랜치 생성
3. 코드 작성 및 테스트
4. Pull Request 생성

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 있습니다.