# MQTT Test Manager

Flutter 기반 MQTT 브로커 연결 테스트 모듈입니다. HiveMQ로 테스트 토픽 구독/발행 및 실시간 메시지 수신 로그를 확인할 수 있습니다.

---

## 개요

**폴더 구조**

```
lib/
├── core/mqtt/
│   ├── mqtt_manager.dart       # MQTT 클라이언트 제어 (단일 진실 공급원)
│   ├── mqtt_state.dart         # 연결 상태 및 메시지 모델 (Freezed)
│   └── mqtt_exceptions.dart    # 커스텀 예외
└── feature/mqtt_tester/
    ├── mqtt_tester_view_model.dart
    └── view/
        ├── mqtt_tester_page.dart
        └── widgets/
            └── message_log_widget.dart
```

---

## 사용된 패키지

| 패키지 | 용도 |
|--------|------|
| [`mqtt_client`](https://pub.dev/packages/mqtt_client) | MQTT 브로커 연결, 구독, 발행 |
| [`flutter_riverpod`](https://pub.dev/packages/flutter_riverpod) | 상태 관리 |
| [`riverpod_annotation`](https://pub.dev/packages/riverpod_annotation) | Riverpod 코드 생성 어노테이션 |
| [`freezed_annotation`](https://pub.dev/packages/freezed_annotation) | 불변 상태 모델 생성 |
| [`build_runner`](https://pub.dev/packages/build_runner) | 코드 생성 실행 도구 |
| [`freezed`](https://pub.dev/packages/freezed) | Freezed 코드 생성기 |
| [`riverpod_generator`](https://pub.dev/packages/riverpod_generator) | Riverpod 코드 생성기 |

---

## 기본 사용 예제

### 1. 브로커 연결

```dart
// MqttManager에 직접 접근
await ref.read(mqttManagerProvider.notifier).connect(
  host: 'your-broker.hivemq.cloud',
  port: 8883,
  clientId: 'my_client_001',
  username: 'your_username',
  password: 'your_password',
);
```

### 2. 토픽 구독

```dart
ref.read(mqttManagerProvider.notifier).subscribe('sensor/temperature');
```

### 3. 메시지 발행

```dart
ref.read(mqttManagerProvider.notifier).publish(
  'sensor/temperature',
  '{"value": 23.5}',
);
```

### 4. 연결 상태 및 메시지 수신 감지

```dart
// 연결 상태 감지
final status = ref.watch(mqttManagerProvider.select((s) => s.connectionStatus));

// 수신 메시지 목록 감지
final messages = ref.watch(mqttManagerProvider.select((s) => s.messages));
```

### 5. 연결 해제

```dart
ref.read(mqttManagerProvider.notifier).disconnect();
```
