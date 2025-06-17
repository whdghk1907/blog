# Docker 컨테이너 관리 가이드

## 개요
이 가이드는 실제 MLOps 프로젝트에서 사용된 Docker 관리 명령어와 베스트 프랙티스를 정리한 문서입니다.

## 기본 정보

### 환경 사양
- **Docker 버전**: 27.5.1
- **운영체제**: Ubuntu 22.04.5 LTS
- **스토리지 드라이버**: overlay2
- **로깅 드라이버**: json-file
- **Cgroup 드라이버**: systemd

## 컨테이너 관리 명령어

### 📦 컨테이너 상태 확인

#### 기본 상태 확인
```bash
# 실행 중인 컨테이너만 표시
docker ps

# 모든 컨테이너 표시 (중지된 것 포함)
docker ps -a

# 컨테이너 ID만 표시
docker ps -q
```

#### 상세 정보 확인
```bash
# 특정 컨테이너 상세 정보
docker inspect mlops-app

# 컨테이너 리소스 사용량 실시간 모니터링
docker stats

# 컨테이너 리소스 사용량 (한 번만)
docker stats --no-stream
```

### 🔍 로그 관리

#### 로그 확인
```bash
# 기본 로그 확인
docker logs mlops-app

# 실시간 로그 모니터링
docker logs -f mlops-app

# 최근 로그만 확인 (마지막 100줄)
docker logs --tail 100 mlops-app

# 타임스탬프와 함께 로그 확인
docker logs -t mlops-app
```

#### 로그 관리
```bash
# 로그 파일 크기 확인
docker system df

# 로그 정리 (시스템 전체)
docker system prune

# 특정 기간 이전 로그 정리
docker logs --since="2024-12-01" mlops-app
```

### 🎮 컨테이너 제어

#### 시작/중지/재시작
```bash
# 컨테이너 시작
docker start mlops-app

# 컨테이너 중지
docker stop mlops-app

# 컨테이너 재시작
docker restart mlops-app

# 컨테이너 강제 종료
docker kill mlops-app
```

#### 컨테이너 내부 접근
```bash
# 컨테이너 내부 셸 접근
docker exec -it mlops-app /bin/bash

# 특정 명령어 실행
docker exec mlops-app ls -la /usr/share/nginx/html

# 파일 복사 (컨테이너 → 호스트)
docker cp mlops-app:/var/log/nginx/access.log ./access.log

# 파일 복사 (호스트 → 컨테이너)
docker cp ./index.html mlops-app:/usr/share/nginx/html/
```

## 이미지 관리

### 🖼️ 이미지 작업

#### 이미지 확인
```bash
# 이미지 목록 확인
docker images

# 특정 이미지 상세 정보
docker inspect nginx:latest

# 이미지 히스토리 확인
docker history nginx:latest
```

#### 이미지 관리
```bash
# 이미지 다운로드
docker pull nginx:latest

# 이미지 삭제
docker rmi nginx:latest

# 사용하지 않는 이미지 정리
docker image prune

# 모든 미사용 이미지 삭제
docker image prune -a
```

## 네트워크 및 볼륨

### 🌐 네트워크 관리

#### 네트워크 확인
```bash
# 네트워크 목록 확인
docker network ls

# 특정 네트워크 상세 정보
docker network inspect bridge

# 컨테이너 네트워크 정보
docker inspect mlops-app | grep -A 20 "NetworkSettings"
```

#### 포트 매핑 확인
```bash
# 컨테이너 포트 매핑 확인
docker port mlops-app

# 호스트에서 포트 사용 상태 확인
netstat -tlnp | grep :80
netstat -tlnp | grep :8080
```

### 💾 볼륨 관리

#### 볼륨 확인
```bash
# 볼륨 목록 확인
docker volume ls

# 볼륨 상세 정보
docker volume inspect volume_name

# 컨테이너 마운트 정보 확인
docker inspect mlops-app | grep -A 10 "Mounts"
```

## 시스템 관리

### 🧹 시스템 정리

#### 디스크 사용량 확인
```bash
# Docker 전체 디스크 사용량
docker system df

# 상세한 디스크 사용량
docker system df -v
```

#### 시스템 정리
```bash
# 미사용 리소스 정리 (안전)
docker system prune

# 모든 미사용 리소스 정리 (주의)
docker system prune -a

# 특정 기간 이전 데이터 정리
docker system prune --filter "until=24h"
```

### 📊 모니터링

#### 실시간 모니터링
```bash
# 컨테이너 리소스 사용량
docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}\t{{.NetIO}}\t{{.BlockIO}}"

# 시스템 이벤트 모니터링
docker events

# 특정 컨테이너 이벤트만 모니터링
docker events --filter container=mlops-app
```

#### 헬스체크
```bash
# 컨테이너 상태 확인
docker inspect --format='{{.State.Health.Status}}' mlops-app

# 웹 서비스 응답 확인
curl -I http://localhost:80
curl -I http://localhost:8080
```

## 실전 사례

### 🚀 MLOps 컨테이너 관리 사례

#### 현재 운영 중인 컨테이너
```bash
# 컨테이너 정보
CONTAINER ID: aff91c384434
IMAGE: nginx:latest
STATUS: Up 5 days
PORTS: 0.0.0.0:80->80/tcp, 0.0.0.0:8080->8080/tcp
NAME: mlops-app
```

#### 일일 점검 루틴
```bash
#!/bin/bash
# daily_check.sh

echo "=== Docker 일일 점검 ==="
echo "1. 컨테이너 상태 확인"
docker ps -a

echo -e "\n2. 리소스 사용량 확인"
docker stats --no-stream

echo -e "\n3. 디스크 사용량 확인"
docker system df

echo -e "\n4. 최근 로그 확인"
docker logs --tail 50 mlops-app

echo -e "\n5. 웹 서비스 응답 확인"
curl -I http://localhost:80 2>/dev/null | head -1
curl -I http://localhost:8080 2>/dev/null | head -1
```

## 트러블슈팅

### 🔧 일반적인 문제들

#### 컨테이너가 시작되지 않을 때
```bash
# 컨테이너 로그 확인
docker logs mlops-app

# 컨테이너 설정 확인
docker inspect mlops-app

# 이미지 문제 확인
docker run --rm nginx:latest nginx -t
```

#### 포트 충돌 문제
```bash
# 포트 사용 중인 프로세스 확인
netstat -tlnp | grep :80
lsof -i :80

# 다른 포트로 실행
docker run -d -p 8081:80 nginx:latest
```

#### 디스크 공간 부족
```bash
# 디스크 사용량 확인
df -h
docker system df

# 정리 작업
docker system prune -a
docker volume prune
```

## 베스트 프랙티스

### 🏆 운영 권장사항

1. **정기적인 모니터링**
   - 일일 컨테이너 상태 점검
   - 리소스 사용량 모니터링
   - 로그 파일 관리

2. **백업 전략**
   - 중요한 데이터 볼륨 백업
   - 컨테이너 설정 문서화
   - 이미지 버전 관리

3. **보안 관리**
   - 정기적인 이미지 업데이트
   - 불필요한 포트 노출 금지
   - 로그 접근 권한 관리

4. **성능 최적화**
   - 적절한 리소스 제한 설정
   - 로그 로테이션 설정
   - 미사용 리소스 정기 정리

## 참고 자료
- [Docker 공식 문서](https://docs.docker.com/)
- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Docker 보안 가이드](https://docs.docker.com/engine/security/) 