# AIHub Shell

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Version](https://img.shields.io/badge/version-0.5-blue.svg)](https://github.com/az5app/aihubshell/releases)
[![Platform](https://img.shields.io/badge/platform-macOS%20%7C%20Linux-lightgrey.svg)](https://github.com/az5app/aihubshell)

[AIHub Korea](https://aihub.or.kr)의 AI 데이터셋에 접근하고 다운로드할 수 있는 커맨드라인 인터페이스 도구입니다.

## 주요 기능

- 🚀 커맨드라인을 통한 AIHub Korea 데이터셋 간편 접근
- 📥 자동 파일 병합 기능이 포함된 데이터셋 다운로드
- 📋 사용 가능한 데이터셋 및 파일 구조 목록 조회
- 🔐 안전한 API 키 인증
- 🛠 간단하고 직관적인 명령어 구조

## 설치 방법

### macOS Homebrew 설치 (권장)

macOS에서 AIHub Shell을 설치하는 가장 쉬운 방법은 Homebrew를 사용하는 것입니다:

```bash
# Tap 추가
brew tap az5app/tap

# aihubshell 설치
brew install aihubshell
```

### 수동 설치

1. 최신 릴리즈 다운로드:
```bash
curl -L https://github.com/az5app/aihubshell/releases/latest/download/aihubshell-v0.5.tar.gz -o aihubshell.tar.gz
```

2. 압축 해제:
```bash
tar -xzf aihubshell.tar.gz
```

3. PATH에 이동:
```bash
chmod +x aihubshell-v0.5/aihubshell
sudo mv aihubshell-v0.5/aihubshell /usr/local/bin/
```

## 설정

### API 키 설정

AIHub Shell을 사용하기 전에 [AIHub Korea](https://aihub.or.kr)에서 API 키를 발급받아야 합니다.

API 키는 두 가지 방법으로 제공할 수 있습니다:

1. **환경 변수 (권장):**
```bash
export AIHUB_APIKEY="your-api-key-here"
```

영구적으로 설정하려면 이 줄을 쉘 설정 파일(`~/.bashrc`, `~/.zshrc` 등)에 추가하세요.

2. **명령어 매개변수:**
```bash
aihubshell -aihubapikey "your-api-key" -mode l
```

## 사용법

### 기본 명령어

#### 도움말 표시
```bash
aihubshell -help
```

#### 모든 데이터셋 목록 조회
```bash
aihubshell -mode l
```

#### 데이터셋 파일 구조 보기
```bash
aihubshell -mode l [dataset-key]
```

#### 데이터셋 다운로드
```bash
aihubshell -mode d -datasetkey [dataset-key]
```

#### 특정 파일 다운로드
```bash
aihubshell -mode d -datasetkey [dataset-key] -filekey [file-keys]
```

### 사용 예시

1. **사용 가능한 데이터셋 목록 조회:**
```bash
aihubshell -mode l
```

2. **데이터셋 71265의 파일 구조 보기:**
```bash
aihubshell -mode l 71265
```

3. **전체 데이터셋 다운로드:**
```bash
aihubshell -mode d -datasetkey 71265
```

4. **데이터셋에서 특정 파일 다운로드:**
```bash
aihubshell -mode d -datasetkey 71265 -filekey "1,2,3"
```

### 매개변수

| 매개변수 | 설명 | 필수 여부 | 예시 |
|----------|------|-----------|------|
| `-aihubapikey` | AIHub API 키 | 아니오 (AIHUB_APIKEY 환경 변수 설정 시) | `-aihubapikey "abc123"` |
| `-mode` | 작업 모드 (`l`: 목록, `d`: 다운로드) | 예 | `-mode l` |
| `-datasetkey` | 데이터셋 식별자 | 예 (다운로드 모드에서) | `-datasetkey 71265` |
| `-filekey` | 다운로드할 특정 파일 키 | 아니오 (기본값: 전체) | `-filekey "1,2,3"` |

## 상세 기능

### 자동 파일 병합
분할된 대용량 데이터셋을 다운로드할 때 AIHub Shell은 자동으로:
- 모든 파트를 다운로드
- 올바른 순서로 병합
- 임시 파일 정리
- 진행 상황 피드백 제공

### 중단 처리
- `Ctrl+C`로 다운로드를 안전하게 중단 가능
- 부분 다운로드의 자동 정리
- 중단된 다운로드의 재개 기능

### 오류 처리
- 일반적인 문제에 대한 명확한 오류 메시지
- HTTP 상태 코드 보고
- 재개 지원을 통한 자동 재시도

## 문제 해결

### 일반적인 문제

1. **"Error: datasetkey is required when mode is 'd'"**
   - 해결책: 다운로드 모드 사용 시 데이터셋 키를 제공하세요
   ```bash
   aihubshell -mode d -datasetkey [your-dataset-key]
   ```

2. **인증 실패**
   - API 키가 올바른지 확인하세요
   - API 키에 필요한 권한이 있는지 확인하세요
   - API 키가 만료되지 않았는지 확인하세요

3. **다운로드 중단**
   - 도구가 자동으로 기존 다운로드를 백업합니다
   - 동일한 명령을 다시 실행하여 재개하세요

## 개발

### 소스에서 빌드

```bash
# 저장소 클론
git clone https://github.com/az5app/aihubshell.git
cd aihubshell

# 메인 스크립트 사용 준비
chmod +x aihubshell
./aihubshell -help
```

### 릴리즈 생성

```bash
# 릴리즈 준비 스크립트 사용
./prepare-release.sh
```

## 기여하기

기여를 환영합니다! Pull Request를 자유롭게 제출해 주세요.

1. 저장소 포크
2. 기능 브랜치 생성 (`git checkout -b feature/AmazingFeature`)
3. 변경사항 커밋 (`git commit -m 'Add some AmazingFeature'`)
4. 브랜치에 푸시 (`git push origin feature/AmazingFeature`)
5. Pull Request 열기

## 라이선스

이 프로젝트는 MIT 라이선스로 배포됩니다 - 자세한 내용은 [LICENSE](LICENSE) 파일을 참조하세요.
