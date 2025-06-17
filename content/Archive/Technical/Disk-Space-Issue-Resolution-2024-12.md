# 디스크 공간 부족 문제 해결 과정 - 2024년 12월

## 문제 발생 개요
- **일시**: 2024년 12월 15일
- **상황**: MLOps Zoomcamp Jupyter 환경 구축 중
- **증상**: Docker 이미지 다운로드 실패 ("no space left on device")
- **영향**: Jupyter 컨테이너 배포 불가

## 초기 상황 분석

### 🚨 오류 메시지
```bash
docker: failed to register layer: write /opt/conda/lib/libarrow.so.1300.0.0: 
no space left on device.
See 'docker run --help'.
```

### 📊 시스템 상태 (문제 발생 시점)
```bash
$ df -h
Filesystem      Size  Used Avail Use% Mounted on
/dev/root       7.6G  3.9G  3.8G  51% /
devtmpfs        3.8G     0  3.8G   0% /dev
tmpfs           3.8G     0  3.8G   0% /dev/shm
tmpfs           765M  876K  765M   1% /run
tmpfs           5.0M     0  5.0M   0% /run/lock
/dev/xvda15     105M  6.1M   99M   6% /boot/efi
tmpfs           765M     0  765M   0% /run/user/1000
```

### 🔍 근본 원인 파악
1. **인스턴스 타입**: t2.large (2 vCPU, 8GB RAM)
2. **기본 스토리지**: 8GB EBS 볼륨
3. **시스템 사용량**: 3.9GB (운영체제 + Docker + 기존 컨테이너)
4. **남은 공간**: 3.8GB
5. **필요 공간**: jupyter/datascience-notebook (~5-6GB)

**결론**: 공간 부족으로 대용량 이미지 설치 불가

## 해결 과정 상세

### 1단계: 인스턴스 타입 vs 스토리지 이해

#### 💡 중요한 깨달음
```
❌ t2.large = 8GB 메모리 = 8GB 스토리지 (잘못된 이해)
✅ t2.large = 8GB 메모리 + 독립적인 EBS 볼륨 (올바른 이해)
```

#### 📚 학습 내용
- 인스턴스 타입은 **컴퓨팅 리소스** (CPU, 메모리) 정의
- EBS 볼륨은 **스토리지** 별도 관리
- 모든 t2 패밀리 기본 EBS: 8GB
- 스토리지는 인스턴스 타입과 독립적으로 확장 가능

### 2단계: AWS 콘솔에서 볼륨 확장

#### A. 볼륨 찾기 및 확인
1. **AWS 콘솔** → **EC2 대시보드**
2. 왼쪽 메뉴 **"볼륨"** 선택
3. 인스턴스 ID: `i-0fa5d460cffbbc640`에 연결된 볼륨 확인
4. 현재 크기: **8GB**

#### B. 볼륨 수정 과정
```
볼륨 선택 → 작업 → 볼륨 수정 → 크기: 8 → 30으로 변경 → 수정 → 확인
```

#### C. 확장 결과
- **변경 전**: 8GB
- **변경 후**: 30GB
- **상태**: "수정 중" → "최적화 중" → "사용 중 - 완료됨"

### 3단계: 서버에서 파티션 확장 필요성 확인

#### 🔧 확장 후 상태 점검
```bash
# 물리적 볼륨 크기 (AWS에서 확장된 크기)
$ sudo fdisk -l
Disk /dev/xvda: 30 GiB, 32212254720 bytes

# 파티션 크기 (아직 확장되지 않음)
$ lsblk
NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
xvda      202:0    0   30G  0 disk 
└─xvda1   202:1    0  7.9G  0 part /

# 파일시스템 크기 (사용 가능한 공간)
$ df -h
/dev/root       7.6G  3.9G  3.8G  51% /
```

#### 📋 상황 분석
- **볼륨**: 30GB로 확장됨 ✅
- **파티션**: 7.9GB (확장 필요) ❌
- **파일시스템**: 7.6GB (확장 필요) ❌

### 4단계: 파티션 및 파일시스템 확장 계획

#### 🛠️ 필요한 명령어 정리
```bash
# 1. 파티션 확장
sudo growpart /dev/xvda 1

# 2. 파일시스템 확장  
sudo resize2fs /dev/xvda1

# 3. 결과 확인
df -h
```

## 비용 영향 분석

### 💰 EBS 요금 계산
- **기존**: 8GB × $0.08/GB/월 = $0.64/월
- **확장**: 30GB × $0.08/GB/월 = $2.40/월
- **추가 비용**: $1.76/월

### 📈 전체 인프라 비용
- **EC2 t2.large**: ~$67/월
- **EBS 30GB**: $2.40/월
- **총 예상 비용**: ~$69.40/월
- **추가 비용 비율**: 2.6% 증가

## 학습한 모범 사례

### 🏆 성공 포인트
1. **사전 계획**: 필요 공간 미리 계산
2. **단계별 접근**: AWS 콘솔 → 파티션 → 파일시스템 순서
3. **상태 확인**: 각 단계마다 결과 검증
4. **비용 고려**: 필요한 만큼만 확장

### 🚫 피해야 할 실수
1. **무계획 확장**: 과도한 크기로 확장하여 비용 낭비
2. **단계 생략**: 파티션/파일시스템 확장 누락
3. **백업 없음**: 중요한 작업 전 백업 미실시
4. **모니터링 부족**: 공간 사용량 정기 체크 안함

## 향후 예방 조치

### 📊 모니터링 시스템 구축
```bash
# 디스크 사용량 경고 스크립트
#!/bin/bash
# disk-monitor.sh

THRESHOLD=80
USAGE=$(df / | grep -vE '^Filesystem' | awk '{print $5}' | sed 's/%//')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "WARNING: Disk usage is ${USAGE}%"
    echo "Current disk usage:"
    df -h /
    echo ""
    echo "Top space consumers:"
    du -sh /var/lib/docker /home /tmp 2>/dev/null | sort -hr
fi
```

### 🔄 정기 점검 체크리스트
- [ ] 주간 디스크 사용량 확인 (`df -h`)
- [ ] Docker 정리 (`docker system prune`)
- [ ] 로그 파일 정리 (`journalctl --vacuum-time=7d`)
- [ ] 임시 파일 정리 (`/tmp`, `/var/tmp`)

## 사용된 도구 및 명령어 정리

### 🔧 진단 명령어
```bash
df -h              # 파일시스템 사용량
lsblk              # 블록 디바이스 목록
sudo fdisk -l      # 디스크 파티션 정보
du -sh /path       # 디렉토리 크기
docker system df   # Docker 공간 사용량
```

### ⚙️ 확장 명령어
```bash
sudo growpart /dev/xvda 1    # 파티션 확장
sudo resize2fs /dev/xvda1    # ext4 파일시스템 확장
sudo xfs_growfs -d /         # XFS 파일시스템 확장 (Amazon Linux)
```

### 🧹 정리 명령어
```bash
docker system prune -a -f       # Docker 전체 정리
sudo apt-get clean              # 패키지 캐시 정리
sudo apt-get autoremove -y      # 불필요한 패키지 제거
sudo journalctl --vacuum-time=3d # 로그 파일 정리
```

## 다른 환경에서의 적용

### 🌐 클라우드 플랫폼별 차이점
- **AWS**: EBS 볼륨 → `growpart` → `resize2fs`
- **GCP**: Persistent Disk → 자동 확장 가능
- **Azure**: Managed Disk → PowerShell 스크립트 사용

### 💻 로컬 환경
- **VirtualBox**: 가상 디스크 크기 조정 필요
- **VMware**: vmdk 파일 확장 후 게스트 OS 작업
- **Docker Desktop**: 설정에서 디스크 할당량 조정

## 참고 자료 및 링크
- [AWS EBS 볼륨 크기 조정](https://docs.aws.amazon.com/ebs/latest/userguide/modify-volume.html)
- [Linux 파티션 확장](https://docs.aws.amazon.com/ebs/latest/userguide/recognize-expanded-volume-linux.html)
- [Docker 공간 관리](https://docs.docker.com/config/pruning/)

## 결론
이번 디스크 공간 부족 문제는 클라우드 인프라의 기본 개념을 이해하는 좋은 기회였습니다. 인스턴스 타입과 스토리지의 독립성, EBS 볼륨 확장 과정, 그리고 비용 고려사항까지 실전 경험을 통해 학습할 수 있었습니다. 향후 유사한 상황에서는 사전 계획과 모니터링을 통해 예방할 수 있을 것입니다. 