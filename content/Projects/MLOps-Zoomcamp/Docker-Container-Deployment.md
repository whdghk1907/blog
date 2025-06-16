# MLOps Zoomcamp Docker 컨테이너 배포

## 프로젝트 개요
- **목표**: MLOps Zoomcamp을 위한 Docker 컨테이너 배포 및 운영
- **상태**: ✅ 운영 중 (5일째)
- **기간**: 2024년 12월
- **플랫폼**: AWS EC2 (Seoul 리전)

## 배포 현황

### 🖥️ 인스턴스 정보
- **인스턴스 ID**: `i-0fa5d460cffbbc640`
- **타입**: t2.large (2 vCPU, 8GB RAM)
- **운영체제**: Ubuntu 22.04.5 LTS
- **아키텍처**: x86_64
- **퍼블릭 IP**: `13.124.226.4`
- **리전**: ap-northeast-2 (Seoul)

### 🐳 Docker 환경
- **Docker 버전**: 27.5.1
- **스토리지 드라이버**: overlay2
- **로깅 드라이버**: json-file
- **Cgroup 드라이버**: systemd

### 📦 배포된 컨테이너
- **컨테이너명**: `mlops-app`
- **이미지**: nginx:latest (192MB)
- **포트 매핑**: 
  - 80:80 (HTTP)
  - 8080:8080 (대시보드)
- **상태**: Running (5일 연속 실행)

## 접속 정보

### SSH 접속
```bash
ssh -i .\mlops-zoomcamp-key ubuntu@13.124.226.4
```

### 웹 접속
- **메인**: http://13.124.226.4
- **대시보드**: http://13.124.226.4:8080

## Docker 관리 명령어

### 컨테이너 관리
```bash
# 컨테이너 상태 확인
docker ps -a

# 컨테이너 로그 확인
docker logs mlops-app

# 컨테이너 재시작
docker restart mlops-app

# 컨테이너 정지
docker stop mlops-app
```

### 시스템 모니터링
```bash
# Docker 시스템 정보
docker info

# 리소스 사용량 확인
docker stats

# 디스크 사용량 확인
docker system df
```

## 성과 및 교훈

### ✅ 성공 요소
1. **안정적인 배포**: 5일간 무중단 운영
2. **효율적인 리소스 사용**: t2.large로 충분한 성능
3. **접근성**: SSH 및 웹 접근 모두 가능
4. **모니터링**: Docker 상태를 실시간으로 확인 가능

### 📚 학습 내용
1. **AWS EC2 관리**: 인스턴스 생성부터 운영까지
2. **Docker 컨테이너 운영**: 실제 프로덕션 환경에서의 컨테이너 관리
3. **SSH 접속 설정**: Windows 환경에서의 SSH 키 관리
4. **네트워크 설정**: 포트 매핑 및 보안 그룹 관리

## 향후 계획
- [ ] 모니터링 도구 추가 (Prometheus, Grafana)
- [ ] CI/CD 파이프라인 구축
- [ ] 로드 밸런싱 설정
- [ ] 백업 및 복구 전략 수립

## 비용 관리
- **현재 비용**: ~$0.0928/시간 (~$67/월)
- **최적화 방안**: 사용하지 않을 때 인스턴스 중지 