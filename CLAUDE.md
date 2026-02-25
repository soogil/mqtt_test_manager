# 🎯 MQTT Connection Manager Lightweight Architecture Guide

## 1. 프로젝트 아키텍처 대원칙 (NO OVER-ENGINEERING)
이 모듈은 하드웨어 및 서버와의 실시간 통신을 위한 MQTT 테스트 모듈입니다.
**경고: 절대로 Domain, Data, UseCase 계층을 나누는 무거운 클린 아키텍처를 적용하지 마십시오.** 브로커 연결, 토픽 구독, 메시지 발행 등은 비즈니스 로직이 아닌 인프라 제어입니다. 오직 **[MqttManager + 경량화된 ViewModel(Presenter)]** 구조만 허용합니다.

## 2. 폴더 및 계층 구조 (Strict Rules)
```text
lib/
├── core/
│   └── mqtt/                         # ⭐️ 통신 제어 핵심 계층 (단일 진실 공급원)
│       ├── mqtt_manager.dart         # mqtt_client 패키지를 직접 다루는 유일한 싱글톤/Provider
│       ├── mqtt_state.dart           # 연결 상태(Connected/Disconnected) 및 수신 메시지 모델 (Freezed)
│       └── mqtt_exceptions.dart      # 타임아웃, 인증 실패 등 커스텀 에러
│
└── feature/
    └── mqtt_tester/                  # 📱 UI 및 테스트 화면 계층
        ├── mqtt_tester_view_model.dart # MqttManager를 호출하여 상태를 UI로 전달
        └── view/
            ├── mqtt_tester_page.dart   # 브로커 정보 입력, 토픽 구독, 로그 출력 화면
            └── widgets/                # 메시지 로그 리스트 위젯 등
```

## 3 **코드 제너레이션 (build_runner) 자동 실행:**
    - 네가 작성하거나 수정한 코드에 `@freezed`, `@riverpod`, `part 'xxx.g.dart'`, `part 'xxx.freezed.dart'`가 단 하나라도 포함되어 있다면, 코드를 저장한 직후 **반드시 터미널에서 아래 명령어를 스스로 실행**하라.
    - 실행 명령어: `dart run build_runner build --delete-conflicting-outputs`, 'flutter pub get', 'mkdir -p'
    - 명령어를 실행한 후, 터미널 로그를 확인하여 에러가 났다면 스스로 코드를 수정하고 다시 실행하라. 성공(Succeeded) 로그를 확인하기 전까지는 작업을 완료하지 마라.
    - 
