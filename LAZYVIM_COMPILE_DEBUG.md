# LazyVim 컴파일 & 디버깅 기능 가이드

## 🚀 개요
LazyVim에서 C, Python, Java, Go, Rust 프로젝트를 바로 컴파일하고 디버깅할 수 있도록 설정이 완료되었습니다.

## 📋 설치된 플러그인
- **nvim-dap**: 디버깅 어댑터 프로토콜
- **nvim-dap-ui**: 디버깅 UI
- **nvim-dap-virtual-text**: 가상 텍스트로 변수 값 표시
- **code_runner.nvim**: 빠른 코드 실행
- **overseer.nvim**: 빌드 작업 관리
- **toggleterm.nvim**: 터미널 통합
- **auto-save.nvim**: 자동 저장 (토글 가능)

## 🔧 디버깅 도구
- **Python**: debugpy (자동 설치)
- **C/C++**: lldb-vscode, gdb
- **Rust**: lldb-vscode 
- **Go**: delve (dlv)
- **Java**: JDT.LS 통합

## ⌨️ 키바인딩

### 🏃 실행 & 컴파일
| 키바인딩 | 설명 | 
|---------|------|
| `<leader>r` | 현재 파일 컴파일 & 실행 |
| `<leader>lr` | CodeRunner로 실행 |
| `<leader>lc` | 언어별 컴파일 |
| `<leader>lt` | 언어별 테스트 실행 |

### 🐛 디버깅
| 키바인딩 | 설명 |
|---------|------|
| `<F5>` | 디버깅 시작/계속 |
| `<F10>` | Step Over |
| `<F11>` | Step Into |
| `<F12>` | Step Out |
| `<leader>db` | 브레이크포인트 토글 |
| `<leader>dc` | 모든 브레이크포인트 삭제 |
| `<leader>dt` | 디버깅 종료 |
| `<leader>du` | 디버그 UI 토글 |
| `<leader>dr` | REPL 열기 |

### 🔨 빌드 관리
| 키바인딩 | 설명 |
|---------|------|
| `<leader>bb` | 빌드 작업 실행 |
| `<leader>bt` | 작업 목록 토글 |
| `<leader>bc` | 커스텀 명령 실행 |

### 💾 기타
| 키바인딩 | 설명 |
|---------|------|
| `<leader>as` | 자동 저장 토글 |
| `<Ctrl-\>` | 플로팅 터미널 |
| `<leader>tf` | 플로팅 터미널 |
| `<leader>th` | 수평 터미널 |
| `<leader>tv` | 수직 터미널 |

## 🎯 언어별 사용법

### Python
```bash
# 실행: <leader>r 또는 <leader>lr
# 디버깅: <F5> (자동으로 가상환경 감지)
# 테스트: <leader>lt (pytest 실행)
```

### C/C++
```bash
# 컴파일: <leader>lc (gcc -g로 디버그 심볼 포함)
# 실행: <leader>r 
# 디버깅: <F5> (lldb 사용)
```

### Rust
```bash
# 빌드: <leader>lc (cargo build)
# 실행: <leader>r (cargo run)
# 테스트: <leader>lt (cargo test)
# 디버깅: <F5> (lldb + cargo integration)
```

### Go
```bash
# 빌드: <leader>lc (go build)
# 실행: <leader>r (go run)
# 테스트: <leader>lt (go test)
# 디버깅: <F5> (delve 사용)
```

### Java
```bash
# 컴파일: <leader>lc (javac)
# 실행: <leader>r 
# 테스트: <leader>lt (mvn test)
# 디버깅: 원격 디버깅 포트 5005
```

## 🔍 디버깅 워크플로우

### 1. 브레이크포인트 설정
```
1. 원하는 라인에 커서 위치
2. <leader>db로 브레이크포인트 토글
```

### 2. 디버깅 시작
```
1. <F5>로 디버깅 시작
2. 설정에 따라 프로그램 경로 입력 (필요시)
3. Debug UI가 자동으로 열림
```

### 3. 디버깅 제어
```
- <F10>: 다음 라인 (Step Over)
- <F11>: 함수 내부로 (Step Into)  
- <F12>: 함수 밖으로 (Step Out)
- <F5>: 다음 브레이크포인트까지 실행
```

### 4. 변수 확인
- 커서를 변수 위에 올리면 값이 가상 텍스트로 표시
- Debug UI에서 Variables 패널 확인
- REPL에서 표현식 평가

## 🛠️ 빌드 템플릿

Overseer 플러그인으로 각 언어별 빌드 템플릿이 제공됩니다:

- **cpp_build**: g++ 컴파일
- **rust_build**: cargo build
- **go_build**: go build
- **java_build**: javac 컴파일

## 📝 사용 예시

### C 프로그램 디버깅
```c
// hello.c
#include <stdio.h>

int main() {
    int x = 10;
    printf("Hello: %d\n", x);  // 여기에 브레이크포인트
    return 0;
}
```

1. 브레이크포인트 설정: `<leader>db`
2. 컴파일: `<leader>lc` 
3. 디버깅 시작: `<F5>`
4. 실행 파일 경로 입력: `./hello`

### Python 스크립트 디버깅
```python
# hello.py
def main():
    x = "Hello World"
    print(x)  # 브레이크포인트

if __name__ == "__main__":
    main()
```

1. 브레이크포인트 설정: `<leader>db`
2. 디버깅 시작: `<F5>` (자동으로 python3 사용)

## 🔧 고급 설정

### 커스텀 빌드 명령
`:OverseerRunCmd`로 사용자 정의 명령 실행 가능

### 자동 저장
개발 중 자동 저장이 필요하면 `<leader>as`로 토글

### 터미널 통합
- `<Ctrl-\>`: 빠른 플로팅 터미널
- 다양한 방향의 터미널 지원

이제 LazyVim에서 완전한 IDE 수준의 컴파일과 디버깅이 가능합니다!