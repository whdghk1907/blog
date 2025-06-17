# Windows에서 AWS EC2 SSH 접속 가이드

## 환경 요구사항
- **OS**: Windows 10/11
- **SSH 클라이언트**: OpenSSH (Windows 내장)
- **키 형식**: .pem 또는 .ppk
- **권한**: 관리자 권한 (권장)

## 실전 검증된 접속 방법

### 🔑 방법 1: PowerShell + .pem 키 (권장)

#### 1단계: SSH 키 파일 준비
```powershell
# 키 파일이 있는 디렉토리로 이동
cd C:\Users\whdgh\blog

# 키 파일 확인
dir *.pem
```

#### 2단계: 키 파일 권한 설정
```powershell
# 파일 소유권 변경
takeown /f mlops-zoomcamp-key.pem

# 권한 초기화
icacls mlops-zoomcamp-key.pem /reset
```

#### 3단계: SSH 접속
```powershell
# 기본 접속
ssh -i .\mlops-zoomcamp-key ubuntu@13.124.226.4

# verbose 모드 (문제 진단용)
ssh -v -i .\mlops-zoomcamp-key ubuntu@13.124.226.4
```

### 🔧 방법 2: PuTTY 사용

#### 1단계: PuTTY 설치
- [PuTTY 다운로드](https://www.putty.org/)
- PuTTY 및 PuTTYgen 설치

#### 2단계: 키 변환
1. **PuTTYgen 실행**
2. **"Load" 버튼 클릭**
3. **`.pem` 파일 선택**
4. **"Save private key" 클릭**
5. **`.ppk` 파일로 저장**

#### 3단계: PuTTY 접속
1. **Host Name**: `ubuntu@13.124.226.4`
2. **Port**: `22`
3. **Connection > SSH > Auth > Credentials**
4. **Private key file**: `.ppk` 파일 선택
5. **"Open" 클릭**

## 문제 해결 가이드

### ❌ 일반적인 오류들

#### 1. "Permission denied (publickey)"
**원인**: SSH 키 권한 문제 또는 잘못된 키 사용

**해결방법**:
```powershell
# 키 파일 권한 재설정
takeown /f your-key.pem
icacls your-key.pem /reset
icacls your-key.pem /inheritance:r
```

#### 2. "Load key: invalid format"
**원인**: 키 파일 형식 손상 또는 줄바꿈 문제

**해결방법**:
- AWS 콘솔에서 새 키 페어 생성
- PuTTYgen으로 키 변환 후 재변환

#### 3. "Connection timed out"
**원인**: 네트워크 또는 보안 그룹 설정 문제

**해결방법**:
- AWS 보안 그룹에서 SSH (포트 22) 허용 확인
- 퍼블릭 IP 주소 정확성 확인

### 🔍 디버깅 명령어

#### 상세한 연결 로그 확인
```powershell
ssh -vvv -i .\your-key.pem ubuntu@your-ip
```

#### 키 파일 권한 확인
```powershell
Get-Acl your-key.pem | Format-List
```

#### 네트워크 연결 테스트
```powershell
Test-NetConnection -ComputerName 13.124.226.4 -Port 22
```

## 성공 사례: 실제 작업 환경

### 작업 환경
- **OS**: Windows 10 (build 26100)
- **위치**: C:\Users\whdgh\blog
- **키 파일**: mlops-zoomcamp-key
- **대상 서버**: Ubuntu 22.04.5 LTS

### 성공한 명령어
```powershell
ssh -i .\mlops-zoomcamp-key ubuntu@13.124.226.4
```

### 원격 명령어 실행
```powershell
# Docker 상태 확인
ssh -i .\mlops-zoomcamp-key ubuntu@13.124.226.4 "docker ps -a"

# 시스템 정보 확인
ssh -i .\mlops-zoomcamp-key ubuntu@13.124.226.4 "uname -a"

# 여러 명령어 실행
ssh -i .\mlops-zoomcamp-key ubuntu@13.124.226.4 "docker ps; docker images; df -h"
```

## 보안 Best Practices

### 🔒 SSH 키 관리
1. **키 파일 권한**: 현재 사용자만 읽기 권한
2. **키 파일 위치**: 안전한 디렉토리에 보관
3. **키 백업**: 안전한 위치에 백업 보관
4. **키 순환**: 정기적인 키 교체

### 🛡️ 접속 보안
```powershell
# SSH 설정 파일 사용 (~/.ssh/config)
Host mlops-server
    HostName 13.124.226.4
    User ubuntu
    IdentityFile ~/.ssh/mlops-zoomcamp-key
    IdentitiesOnly yes
```

### 📋 체크리스트

#### 접속 전 확인사항
- [ ] SSH 키 파일 존재 여부
- [ ] 키 파일 권한 확인
- [ ] 대상 서버 IP 정확성
- [ ] 보안 그룹 SSH 포트 허용

#### 접속 후 확인사항
- [ ] 서버 상태 확인
- [ ] 서비스 동작 상태
- [ ] 로그 파일 확인
- [ ] 리소스 사용량 모니터링

## 참고 자료
- [AWS EC2 User Guide](https://docs.aws.amazon.com/ec2/)
- [OpenSSH Documentation](https://www.openssh.com/)
- [PuTTY Documentation](https://www.putty.org/) 