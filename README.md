# Arambyeol iOS

경상국립대학교 학생생활관을 위한 통합 서비스 iOS 앱

## 📱 프로젝트 소개

Arambyeol은 경상국립대학교 학생생활관 학생들을 위한 통합 서비스 플랫폼입니다.
식단 확인, 채팅, 룸메이트 매칭 등 생활관 생활에 필요한 모든 기능을 제공합니다.

## 🎯 주요 기능

### 1. 식단 (Meal Menu)
- 일별 식단 조회
- 조식/중식/석식 구분
- 메뉴 상세 정보 제공
- 날짜 선택 기능

### 2. 전체 채팅방 (Chat)
- 생활관 전체 채팅방
- 실시간 메시지 전송
- 채팅방 설정 및 관리

### 3. 룸메 매칭 (Roommate Matching)
- 룸메이트 프로필 탐색
- 성별/학년 필터링
- 상세 프로필 조회
- 매칭 신청 기능

### 4. 설정 (Settings)
- 프로필 관리
- 알림 설정
- 앱 정보 및 고객센터
- 계정 관리

## 🏗️ 프로젝트 구조

### 아키텍처 패턴
- **MVVM (Model-View-ViewModel)** 패턴을 사용
- **Combine** 프레임워크를 활용한 반응형 프로그래밍
- **Protocol-Oriented Programming** 적용

### 폴더 구조
```
Arambyeol/
├── Models/                      # 데이터 모델
│   ├── BaseModel.swift          # 기본 모델 프로토콜
│   └── User.swift               # 사용자 모델
├── ViewModels/                  # 뷰모델
│   ├── BaseViewModel.swift      # 기본 뷰모델
│   └── HomeViewModel.swift      # 홈 화면 뷰모델
├── Views/                       # 뷰 컴포넌트
│   ├── HomeView.swift           # 홈 화면 (레거시)
│   ├── MealMenuView.swift       # 식단 화면
│   ├── ChatView.swift           # 채팅 화면
│   ├── RoommateMatchingView.swift # 룸메 매칭 화면
│   └── ComponentsView.swift     # 재사용 컴포넌트
├── Services/                    # 서비스 레이어
│   ├── UserServiceProtocol.swift # 사용자 서비스 프로토콜
│   ├── UserService.swift        # 사용자 서비스
│   └── NetworkService.swift     # 네트워크 서비스
├── Utils/                       # 유틸리티
│   ├── Extensions.swift         # 확장 기능
│   ├── Constants.swift          # 상수 정의
│   └── Logger.swift             # 로깅 시스템
├── ContentView.swift            # 메인 컨텐츠 뷰 (탭바 포함)
└── ArambyeolApp.swift           # 앱 진입점
```

## 🎨 화면 구성

### 탭바 구조
1. **식단 탭** 🍽️
   - 날짜별 식단 조회
   - 조식/중식/석식 선택
   - 메뉴 상세 정보

2. **채팅 탭** 💬
   - 생활관 전체 채팅방
   - 실시간 메시지 송수신
   - 메시지 입력 및 전송

3. **룸메 탭** 👥
   - 룸메이트 프로필 목록
   - 성별 필터링
   - 상세 프로필 및 매칭 신청

4. **설정 탭** ⚙️
   - 내 프로필
   - 알림 설정
   - 앱 설정
   - 계정 관리

## 🛠️ 기술 스택

- **SwiftUI**: 모던 UI 프레임워크
- **Combine**: 반응형 프로그래밍
- **Foundation**: 기본 프레임워크
- **OSLog**: 시스템 로깅

## 📋 개발 환경

- Xcode 14.0 이상
- iOS 16.0 이상
- Swift 5.9 이상

## 🚀 시작하기

### 1. 프로젝트 클론
```bash
git clone [repository-url]
cd Arambyeol-IOS
```

### 2. Xcode에서 열기
```bash
open Arambyeol.xcodeproj
```

### 3. 빌드 및 실행
- Xcode에서 프로젝트를 열고 실행
- 시뮬레이터 또는 실제 기기에서 테스트

## 📝 개발 가이드

### 새로운 기능 추가하기
1. `Views/` 폴더에 새로운 View 파일 생성
2. 필요시 `ViewModels/` 폴더에 ViewModel 생성
3. `Models/` 폴더에 필요한 데이터 모델 추가
4. `Services/` 폴더에 필요한 서비스 구현

### 서비스 구현하기
1. `Services/` 폴더에 프로토콜과 구현체 생성
2. 의존성 주입을 통해 ViewModel에서 사용
3. Mock 데이터로 먼저 테스트 후 실제 API 연동

## 🎯 향후 계획

### 구현 예정 기능
- [ ] 실제 식단 API 연동
- [ ] 실시간 채팅 기능 (WebSocket)
- [ ] 룸메이트 매칭 알고리즘
- [ ] 푸시 알림
- [ ] 사용자 인증 시스템
- [ ] 오프라인 지원
- [ ] 다크 모드 지원

### 개선 사항
- [ ] UI/UX 개선
- [ ] 성능 최적화
- [ ] 코드 리팩토링
- [ ] 테스트 코드 작성
- [ ] 문서화

## 📝 코딩 컨벤션

- **파일명**: PascalCase 사용
- **클래스/구조체**: PascalCase 사용
- **함수/변수**: camelCase 사용
- **상수**: UPPER_SNAKE_CASE 사용
- **MARK 주석**: 코드 섹션 구분

## 🤝 기여하기

1. 이슈 생성 또는 기존 이슈 확인
2. 기능 브랜치 생성 (`git checkout -b feature/AmazingFeature`)
3. 변경사항 커밋 (`git commit -m 'Add some AmazingFeature'`)
4. 브랜치에 푸시 (`git push origin feature/AmazingFeature`)
5. Pull Request 생성

## 📄 라이선스

이 프로젝트는 MIT 라이선스 하에 있습니다.

## 📞 문의

프로젝트 관련 문의사항은 이슈를 생성해주세요.

---

**Made with ❤️ for Gyeongsang National University Students**
