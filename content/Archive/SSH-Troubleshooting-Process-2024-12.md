# SSH 접속 문제 해결 과정 (2024년 12월)

## 문제 개요
- **발생일**: 2024년 12월
- **환경**: Windows 10 → AWS EC2 (Ubuntu 22.04.5 LTS)
- **목표**: MLOps 컨테이너 접속을 위한 SSH 연결 구축
- **최종 결과**: ✅ 성공적으로 해결

## 시도한 해결 방법들

### 1️⃣ 첫 번째 시도: 기본 SSH 접속
```powershell
ssh -i mlops-zoomcamp-key.pem ubuntu@13.124.226.4
```
**결과**: `Load key "mlops-zoomcamp-key.pem": Permission denied`

### 2️⃣ 두 번째 시도: 파일 권한 수정
```powershell
icacls mlops-zoomcamp-key.pem /inheritance:r
icacls mlops-zoomcamp-key.pem /grant:r "$env:USERNAME:(R)"
```
**결과**: 권한 설정 오류 발생

### 3️⃣ 세 번째 시도: 관리자 권한으로 실행
- Windows PowerShell(관리자) 실행
- 동일한 권한 설정 명령어 실행
**결과**: 여전히 권한 문제 지속

### 4️⃣ 네 번째 시도: 파일 소유권 변경
```powershell
takeown /f mlops-zoomcamp-key.pem
icacls mlops-zoomcamp-key.pem /reset
```
**결과**: `Load key: invalid format` 오류로 변경

### 5️⃣ 다섯 번째 시도: 키 파일 형식 확인
```powershell
type mlops-zoomcamp-key.pem
```
**발견**: 키 파일이 불완전하게 복사됨 (내용 잘림)

### 6️⃣ 여섯 번째 시도: PuTTY 사용 검토
- PuTTYgen으로 .pem → .ppk 변환 시도
- PuTTY를 통한 접속 계획
**결과**: Windows 환경에서 복잡성 증가

### 7️⃣ 일곱 번째 시도: 새 키 파일 준비
- 올바른 키 파일 (`mlops-zoomcamp-key`) 확보
- 확장자 없는 파일로 준비
**결과**: ✅ 성공!

## 최종 해결 방법

### 🎯 성공한 명령어
```powershell
ssh -i .\mlops-zoomcamp-key ubuntu@13.124.226.4
```

### 📋 성공 요인 분석
1. **올바른 키 파일**: 완전하고 손상되지 않은 SSH 키
2. **적절한 파일명**: 확장자 문제 해결
3. **권한 설정**: Windows에서의 적절한 파일 권한
4. **경로 지정**: 상대 경로 (`.\`) 사용

## 학습한 교훈

### ❌ 실패 원인들
1. **파일 손상**: 복사 과정에서 키 파일 내용 손실
2. **권한 복잡성**: Windows SSH 키 권한 설정의 복잡성
3. **파일 형식**: .pem vs 키 파일 확장자 문제
4. **경로 문제**: 절대 경로 vs 상대 경로

### ✅ 성공 요소들
1. **체계적 접근**: 단계별로 문제 원인 분석
2. **다양한 시도**: 여러 해결 방법 검토
3. **환경 이해**: Windows ↔ Linux 환경 차이점 학습
4. **최종 검증**: 올바른 키 파일 확보 후 재시도

## 기술적 세부사항

### Windows SSH 키 권한 설정
```powershell
# 파일 소유권 가져오기
takeown /f key-file.pem

# 권한 초기화
icacls key-file.pem /reset

# 상속 권한 제거
icacls key-file.pem /inheritance:r
```

### 키 파일 형식 확인
```powershell
# 파일 내용 확인
type key-file.pem | Select-Object -First 5

# 파일 크기 확인
Get-ChildItem key-file.pem | Select-Object Name, Length
```

### 연결 테스트
```powershell
# verbose 모드로 디버깅
ssh -v -i .\key-file ubuntu@server-ip

# 연결 후 명령어 실행 테스트
ssh -i .\key-file ubuntu@server-ip "whoami"
```

## 문제 해결 체크리스트

### 🔍 진단 단계
- [ ] SSH 키 파일 존재 확인
- [ ] 파일 권한 상태 확인
- [ ] 키 파일 내용 완전성 확인
- [ ] 대상 서버 접근성 확인
- [ ] 네트워크 연결 상태 확인

### 🛠️ 해결 단계
- [ ] 파일 소유권 확보
- [ ] 권한 초기화 및 재설정
- [ ] 키 파일 형식 검증
- [ ] 다양한 접속 방법 시도
- [ ] 최종 연결 테스트

## 향후 예방 방안

### 📚 문서화
1. **성공한 명령어 보관**: 향후 참조용
2. **문제 해결 과정 기록**: 유사 문제 대비
3. **환경별 차이점 정리**: Windows/Linux 차이점

### 🔧 도구 준비
1. **PuTTY 설치**: 대체 접속 방법 확보
2. **WSL 활용**: Linux 호환 환경 구축
3. **키 파일 백업**: 안전한 위치에 보관

### 🎯 베스트 프랙티스
1. **단계별 접근**: 한 번에 하나씩 문제 해결
2. **로그 확인**: verbose 모드 활용
3. **다중 방법**: 여러 접속 방법 숙지
4. **정기 점검**: SSH 연결 상태 정기 확인

## 결론
Windows 환경에서 AWS EC2 SSH 접속은 Linux 환경에 비해 복잡하지만, 체계적인 접근과 올바른 키 파일 관리를 통해 해결 가능합니다. 이번 경험을 통해 얻은 지식은 향후 유사한 문제 해결에 큰 도움이 될 것입니다.

---
*이 문서는 실제 문제 해결 과정을 기록한 아카이브입니다. 향후 참조 및 교육 목적으로 활용됩니다.* 