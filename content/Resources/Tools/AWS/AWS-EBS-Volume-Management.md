# AWS EBS 볼륨 관리 가이드

## 개요
이 가이드는 AWS EC2 인스턴스의 EBS 볼륨 크기 확장 과정을 실제 경험을 바탕으로 정리한 문서입니다.

## 사전 이해: 인스턴스 타입 vs 스토리지

### 🔍 흔한 오해
```
❌ t2.large = 8GB 메모리 = 8GB 스토리지
✅ t2.large = 8GB 메모리 + 별도 EBS 볼륨
```

### 📊 인스턴스 타입별 사양
| 타입 | vCPU | 메모리 | 기본 EBS | 네트워크 |
|------|------|--------|----------|----------|
| t2.micro | 1 | 1GB | 8GB | 저속 |
| t2.small | 1 | 2GB | 8GB | 저속-중간 |
| t2.medium | 2 | 4GB | 8GB | 중간 |
| **t2.large** | **2** | **8GB** | **8GB** | **중간-고속** |

**핵심**: 모든 t2 패밀리는 **기본 8GB EBS** 볼륨 사용

## EBS 볼륨 확장 프로세스

### 1단계: AWS 콘솔에서 볼륨 수정

#### A. 볼륨 찾기
1. **AWS 콘솔** → **EC2 대시보드**
2. 왼쪽 메뉴 **"볼륨"** 클릭
3. 대상 인스턴스에 연결된 볼륨 확인

#### B. 볼륨 수정
```
작업 → 볼륨 수정 → 크기 변경 → 수정 → 확인
```

**예시**: 8GB → 30GB 변경

### 2단계: 인스턴스에서 확인

#### 현재 상태 진단
```bash
# 볼륨 크기 확인 (AWS에서 변경한 크기)
sudo fdisk -l

# 파티션 상태 확인
lsblk

# 파일시스템 사용량 확인
df -h
```

#### 상태 해석
```bash
# 예시 출력
Disk /dev/xvda: 30 GiB    # ✅ 볼륨 확장됨
├─xvda1  7.9G             # ❌ 파티션 미확장
/dev/root  7.6G           # ❌ 파일시스템 미확장
```

### 3단계: 파티션 확장

#### 자동 확장 명령어
```bash
# xvda 디스크의 첫 번째 파티션 확장
sudo growpart /dev/xvda 1

# NVMe 디스크인 경우
sudo growpart /dev/nvme0n1 1
```

#### 확장 결과 확인
```bash
lsblk
# 예상 결과: xvda1이 30G로 확장됨
```

### 4단계: 파일시스템 확장

#### ext4 파일시스템 (Ubuntu 기본)
```bash
sudo resize2fs /dev/xvda1

# NVMe인 경우
sudo resize2fs /dev/nvme0n1p1
```

#### XFS 파일시스템 (Amazon Linux)
```bash
sudo xfs_growfs -d /
```

#### 최종 확인
```bash
df -h
# 예상 결과: /dev/root가 29G로 확장됨
```

## 실전 케이스 스터디

### 🎯 실제 상황: Jupyter 컨테이너 배포 실패

#### 문제 상황
```bash
# Docker 이미지 다운로드 중 오류
docker: failed to register layer: write /opt/conda/lib/libarrow.so.1300.0.0: 
no space left on device.
```

#### 원인 분석
- **필요 공간**: jupyter/datascience-notebook (5-6GB)
- **사용 중**: 시스템 + 기존 컨테이너 (3.9GB)
- **남은 공간**: 3.8GB
- **결과**: 공간 부족으로 설치 실패

#### 해결 과정
1. **진단**: `df -h`로 공간 부족 확인
2. **확장**: AWS 콘솔에서 8GB → 30GB
3. **적용**: `growpart` + `resize2fs`
4. **재시도**: Jupyter 컨테이너 설치 성공

## 자동화 스크립트

### 🚀 원클릭 확장 스크립트
```bash
#!/bin/bash
# ebs-expand.sh - EBS 볼륨 확장 자동화 스크립트

echo "=== EBS 볼륨 확장 시작 ==="

# 1. 현재 상태 확인
echo "현재 디스크 상태:"
df -h | grep "/"
echo ""

# 2. 디스크 정보 확인
echo "디스크 및 파티션 정보:"
lsblk | grep -E "xvda|nvme"
echo ""

# 3. 파티션 확장 (xvda 또는 nvme 자동 감지)
if lsblk | grep -q "xvda"; then
    DISK="xvda"
    PARTITION="xvda1"
elif lsblk | grep -q "nvme"; then
    DISK="nvme0n1"
    PARTITION="nvme0n1p1"
else
    echo "지원되지 않는 디스크 타입"
    exit 1
fi

echo "감지된 디스크: $DISK"
echo "대상 파티션: $PARTITION"
echo ""

# 4. 파티션 확장
echo "파티션 확장 중..."
sudo growpart /dev/$DISK 1

# 5. 파일시스템 확장
echo "파일시스템 확장 중..."
sudo resize2fs /dev/$PARTITION

# 6. 결과 확인
echo ""
echo "=== 확장 완료 ==="
echo "최종 디스크 상태:"
df -h | grep "/"
lsblk | grep -E "xvda|nvme"

echo ""
echo "성공! 이제 대용량 Docker 이미지를 설치할 수 있습니다."
```

### 실행 방법
```bash
# 스크립트 생성
cat > ebs-expand.sh << 'EOF'
[위 스크립트 내용]
EOF

# 실행 권한 부여
chmod +x ebs-expand.sh

# 실행
./ebs-expand.sh
```

## 모니터링 및 관리

### 📊 디스크 사용량 모니터링
```bash
# 디스크 사용량 확인
df -h

# 디렉토리별 사용량 확인
du -sh /var/lib/docker
du -sh /home
du -sh /tmp

# 실시간 사용량 모니터링
watch -n 5 'df -h | grep "/"'
```

### 🧹 공간 정리 명령어
```bash
# Docker 정리
docker system prune -a -f

# 시스템 정리
sudo apt-get clean
sudo apt-get autoremove -y

# 로그 정리
sudo journalctl --vacuum-time=3d
```

## 비용 최적화

### 💰 EBS 요금 계산
| 볼륨 크기 | gp3 월 요금 | gp2 월 요금 |
|-----------|-------------|-------------|
| 8GB       | $0.64       | $0.80       |
| 20GB      | $1.60       | $2.00       |
| 30GB      | $2.40       | $3.00       |
| 50GB      | $4.00       | $5.00       |

### 📈 권장 크기
- **개발/테스트**: 20-30GB
- **프로덕션**: 50GB+
- **데이터 집약적**: 100GB+

## 트러블슈팅

### ❌ 일반적인 오류들

#### 1. "No space left on device"
```bash
# 원인: 파일시스템 공간 부족
# 해결: EBS 볼륨 확장

df -h  # 공간 확인
# AWS 콘솔에서 볼륨 확장 후
sudo growpart /dev/xvda 1
sudo resize2fs /dev/xvda1
```

#### 2. "growpart: FAILED: failed to resize"
```bash
# 원인: 잘못된 디스크/파티션 지정
# 해결: 올바른 디스크 확인

lsblk  # 디스크 구조 확인
sudo fdisk -l  # 디스크 정보 확인
```

#### 3. 파티션은 확장되었으나 파일시스템 미확장
```bash
# 확인
lsblk  # 파티션 크기 확인
df -h  # 파일시스템 크기 확인

# 해결
sudo resize2fs /dev/xvda1
```

## 베스트 프랙티스

### 🏆 권장사항
1. **사전 백업**: 중요한 데이터 백업 후 작업
2. **단계별 확인**: 각 단계마다 결과 검증
3. **적절한 크기**: 여유 공간 20% 이상 유지
4. **모니터링**: 정기적인 사용량 체크

### 🚫 주의사항
1. **운영 중 확장**: 가능하지만 성능 영향 있음
2. **스냅샷 생성**: 확장 전 스냅샷 권장
3. **비용 고려**: 필요 이상 크게 확장하지 말 것

## 참고 자료
- [AWS EBS User Guide](https://docs.aws.amazon.com/ebs/)
- [Linux 파일시스템 관리](https://tldp.org/LDP/sag/html/filesystems.html)
- [EC2 인스턴스 스토리지](https://docs.aws.amazon.com/ec2/latest/userguide/storage.html) 