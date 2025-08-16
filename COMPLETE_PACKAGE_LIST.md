# macSetup3-default 전체 패키지 및 설정 목록

## 🍺 Homebrew Formulae (33개)

### Core Development Tools
- **git**: 분산 버전 관리 시스템
- **neovim**: 현대적인 vim 에디터, 플러그인 생태계가 뛰어남
- **wezterm**: GPU 가속 크로스플랫폼 터미널 에뮬레이터
- **zellij**: Rust로 작성된 터미널 멀티플렉서 (tmux 대안)
- **starship**: 크로스 셸 프롬프트, 빠르고 설정 가능

### Essential Command Line Tools
- **eza**: ls의 현대적 대체품, 색상과 아이콘 지원
- **bat**: cat의 향상된 버전, 구문 강조와 Git 통합
- **fd**: find의 빠른 대체품, 직관적인 문법
- **ripgrep**: grep의 빠른 대체품, 재귀 검색 최적화
- **fzf**: 명령줄 퍼지 파인더, 히스토리/파일 검색
- **zoxide**: cd의 스마트한 대체품, 사용 빈도 기반 이동
- **delta**: Git diff 출력을 아름답게 렌더링
- **gh**: GitHub CLI, 저장소 관리와 PR/이슈 처리
- **jq**: JSON 데이터 처리를 위한 명령줄 도구
- **htop**: 인터랙티브 프로세스 뷰어 (top 대체)
- **tree**: 디렉토리 구조를 트리 형태로 표시
- **curl**: 데이터 전송 도구, HTTP/HTTPS 요청

### Programming Languages & Tools
- **python@3.12**: Python 3.12 버전
- **pipx**: Python 애플리케이션을 격리된 환경에서 설치
- **gcc**: GNU 컴파일러 컬렉션 (C/C++ 컴파일러)
- **cmake**: 크로스플랫폼 빌드 시스템
- **node**: Node.js JavaScript 런타임
- **rust**: Rust 프로그래밍 언어와 Cargo 패키지 매니저
- **go**: Go 프로그래밍 언어
- **openjdk**: OpenJDK Java 개발 키트

### Debugging Tools
- **llvm**: LLVM 컴파일러 인프라스트럭처 (lldb 디버거 포함)
- **gdb**: GNU 디버거

### Language Servers
- **lua-language-server**: Lua LSP 서버 (Neovim 설정용)
- **rust-analyzer**: Rust LSP 서버
- **typescript-language-server**: TypeScript/JavaScript LSP 서버
- **pyright**: Python LSP 서버 (타입 체킹 및 IntelliSense)

### Database
- **sqlite**: 경량 SQL 데이터베이스 엔진

### Version Control & Formatting
- **lazygit**: Git을 위한 터미널 UI
- **shfmt**: 셸 스크립트 포맷터
- **shellcheck**: 셸 스크립트 정적 분석 도구

## 📱 Homebrew Casks (4개)

- **aerospace**: macOS용 타일링 윈도우 매니저
- **raycast**: Spotlight 대체품, 확장 가능한 런처
- **visual-studio-code**: Microsoft의 코드 에디터
- **font-jetbrains-mono-nerd-font**: 개발자용 Nerd Font 패치된 JetBrains Mono

## 🐍 Python Tools (pipx로 설치, 6개)

- **poetry**: Python 의존성 관리 및 패키징 도구
- **black**: Python 코드 포맷터 (PEP 8 준수)
- **ruff**: 빠른 Python 린터 (Flake8, isort 등 대체)
- **pytest**: Python 테스팅 프레임워크
- **virtualenv**: Python 가상환경 생성 도구
- **debugpy**: Python 디버깅 어댑터 (VS Code, Neovim DAP용)

## 🟨 Node.js Global Packages (5개)

- **typescript**: TypeScript 컴파일러
- **ts-node**: TypeScript를 직접 실행하는 도구
- **nodemon**: 파일 변경 감지 시 자동 재시작
- **eslint**: JavaScript/TypeScript 린터
- **prettier**: 코드 포맷터 (JS/TS/JSON/CSS 등)

## 🔧 Go Tools (자동 설치)

- **delve (dlv)**: Go 디버거

## 📝 VS Code Extensions (6개)

- **ms-python.python**: Python 지원 (IntelliSense, 린팅, 디버깅)
- **ms-python.vscode-pylance**: Python LSP 클라이언트 (빠른 타입 체킹)
- **vscodevim.vim**: Vim 키바인딩 에뮬레이션
- **ms-vscode.cpptools**: C/C++ IntelliSense, 디버깅, 브라우징
- **vscjava.vscode-java-pack**: Java 개발 확장 팩
- **eamodio.gitlens**: Git 코드 렌즈와 풍부한 Git 기능
- **esbenp.prettier-vscode**: Prettier 코드 포맷터 통합

## 🎨 LazyVim Plugins (9개)

### UI & Theme
- **folke/tokyonight.nvim**: Tokyo Night 컬러 스킴 (투명 배경, 터미널 색상 지원)

### Navigation & Input
- **max397574/better-escape.nvim**: 더 나은 Escape 키 매핑 ("jk", "jj"로 insert 모드 탈출)
- **karb94/neoscroll.nvim**: 부드러운 스크롤링 애니메이션

### Git Integration
- **lewis6991/gitsigns.nvim**: Git 변경사항을 gutter에 표시

### AI Assistance
- **github/copilot.vim**: GitHub Copilot AI 코드 완성

### Debugging & Development
- **mfussenegger/nvim-dap**: Debug Adapter Protocol 클라이언트
  - **rcarriga/nvim-dap-ui**: 디버깅 UI
  - **theHamsta/nvim-dap-virtual-text**: 변수 값을 가상 텍스트로 표시
  - **nvim-telescope/telescope-dap.nvim**: Telescope와 DAP 통합

### Terminal & Build
- **akinsho/toggleterm.nvim**: 통합 터미널 관리 (플로팅, 수평, 수직)
- **stevearc/overseer.nvim**: 빌드 작업 관리 (언어별 빌드 템플릿)

### Markdown & Documentation
- **iamcco/markdown-preview.nvim**: 마크다운 실시간 미리보기

### Code Execution
- **CRAG666/code_runner.nvim**: 다양한 언어의 빠른 코드 실행

### Productivity
- **Pocco81/auto-save.nvim**: 자동 저장 기능 (토글 가능)

## 🐚 Zsh Plugins (13개)

- **git**: Git 명령어 별칭과 프롬프트 정보
- **zsh-autosuggestions**: 히스토리 기반 자동 완성 제안
- **zsh-syntax-highlighting**: 명령어 구문 강조
- **zsh-completions**: 추가 자동 완성 정의
- **zsh-vi-mode**: Vim 키바인딩 모드
- **python**: Python 관련 별칭과 함수
- **golang**: Go 관련 별칭과 함수
- **rust**: Rust 관련 별칭과 함수
- **fzf**: 퍼지 파인더 키바인딩과 자동 완성
- **macos**: macOS 특화 명령어와 별칭
- **colored-man-pages**: man 페이지 색상 표시
- **extract**: 다양한 아카이브 파일 압축 해제 함수
- **sudo**: 더블 ESC로 sudo 추가

## ⚙️ 주요 Configuration Settings

### WezTerm Settings
- **font**: JetBrainsMono Nerd Font (14pt, line_height 1.2)
- **color_scheme**: Tokyo Night
- **window_background_opacity**: 0.95 (반투명)
- **tab_bar**: 하나의 탭만 있을 때 숨김
- **cursor**: BlinkingBar (500ms 깜빡임)
- **scrollback_lines**: 10000

### Vim Settings (.vimrc)
- **encoding**: utf-8
- **number & relativenumber**: 라인 번호 표시
- **expandtab, tabstop=4**: 탭을 4칸 스페이스로 변환
- **autoindent, smartindent**: 자동 들여쓰기
- **hlsearch, incsearch**: 검색 강조, 증분 검색
- **wrap, linebreak**: 자동 줄바꿈 (단어 경계)
- **scrolloff=8**: 커서 위아래 8줄 여백 유지
- **clipboard=unnamed**: 시스템 클립보드 사용

### LazyVim Key Bindings
#### Execution & Compilation
- `<leader>r`: 컴파일 & 실행
- `<leader>lr`: CodeRunner 실행
- `<leader>lc`: 언어별 컴파일
- `<leader>lt`: 언어별 테스트

#### Debugging
- `<F5>`: 디버깅 시작/계속
- `<F10>/<F11>/<F12>`: Step Over/Into/Out
- `<leader>db`: 브레이크포인트 토글
- `<leader>du`: 디버그 UI 토글

#### Build Management
- `<leader>bb`: 빌드 작업 실행
- `<leader>bt`: 작업 목록 토글

#### Terminal
- `<Ctrl-\>`: 플로팅 터미널
- `<leader>tf/th/tv`: 플로팅/수평/수직 터미널

### Zellij Layouts
#### 언어별 전용 레이아웃 제공:
- **python.kdl**: Editor + Python REPL + Test + Jupyter 탭
- **c.kdl**: Editor + Build + Debug + Memory Analysis
- **java.kdl**: Editor + Build + Test + Dependencies
- **go.kdl**: Editor + Build + Test + Modules
- **rust.kdl**: Editor + Cargo + Test + Documentation

### Starship Prompt
- **format**: 사용자 정의 프롬프트 형식
- **git 정보**: 브랜치, 상태, 커밋 정보 표시
- **언어 버전**: Python, Node, Rust, Go 버전 표시

### AeroSpace (Window Manager)
- **타일링**: 자동 윈도우 배치
- **워크스페이스**: 멀티 데스크톱 관리
- **키바인딩**: Vim 스타일 윈도우 네비게이션

## 🔄 Auto-Installation Features

### 환경 감지
- **Python 가상환경**: venv, .venv 자동 활성화
- **프로젝트 타입**: package.json, Cargo.toml, go.mod 등 감지
- **Git 저장소**: lazygit 자동 실행

### 오류 처리
- **이미 설치된 패키지**: 건너뛰기
- **설치 실패**: 경고 표시 후 계속 진행
- **의존성 확인**: 필수 도구 존재 확인

이 설정으로 C, Python, Java, Go, Rust 개발을 위한 완전한 IDE 환경이 구축됩니다.