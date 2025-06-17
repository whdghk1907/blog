# AWS CLI 설치 및 설정 가이드

## Windows 환경 설치

### 1. AWS CLI 설치
```powershell
# MSI 인스토ller 다운로드 및 실행
# 또는 winget 사용
winget install Amazon.AWSCLI
```

### 2. 환경 변수 설정
- 시스템 PATH에 AWS CLI 경로 추가
- PowerShell 재시작 필요

### 3. 계정 설정
```bash
aws configure
```

필요한 정보:
- AWS Access Key ID
- AWS Secret Access Key  
- Default region name (예: ap-northeast-2)
- Default output format (json 권장)

## 주요 명령어

### 계정 및 리전 확인
```bash
# 현재 설정 확인
aws configure list

# 계정 정보 확인
aws sts get-caller-identity

# 사용 가능한 리전 목록
aws ec2 describe-regions --query 'Regions[].RegionName' --output table
```

### EC2 관련 명령어
```bash
# 모든 인스턴스 조회
aws ec2 describe-instances

# 실행 중인 인스턴스만 조회
aws ec2 describe-instances --filters "Name=instance-state-name,Values=running"

# 인스턴스 종료
aws ec2 terminate-instances --instance-ids i-xxxxxxxxx

# SSH 키페어 생성
aws ec2 create-key-pair --key-name mykey --output text --query 'KeyMaterial' > mykey.pem
```

### 리전별 리소스 스캔
```bash
# 모든 리전에서 실행 중인 인스턴스 확인
for region in $(aws ec2 describe-regions --query 'Regions[].RegionName' --output text); do
    echo "=== $region ==="
    aws ec2 describe-instances --region $region --filters "Name=instance-state-name,Values=running" --query 'Reservations[].Instances[].[InstanceId,Tags[?Key==`Name`].Value|[0],InstanceType,State.Name]' --output table
done
```

## 트러블슈팅

### 환경 변수 문제
- PowerShell에서 `$env:PATH` 확인
- 시스템 재시작 또는 새 셸 세션 시작

### 권한 문제
- IAM 정책 확인
- 액세스 키 유효성 검증

## 보안 Best Practices
- 루트 계정 대신 IAM 사용자 사용
- 액세스 키 정기적 로테이션
- 최소 권한 원칙 적용
- MFA(다중 인증) 활성화 권장 