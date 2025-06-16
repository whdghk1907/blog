# MLOps Zoomcamp Jupyter 환경 구축

## 프로젝트 개요
- **목표**: MLOps Zoomcamp 강의를 위한 Jupyter 노트북 환경 구축
- **상태**: 🚧 진행 중 (EBS 볼륨 확장 단계)
- **기간**: 2024년 12월
- **접근 방식**: Docker 컨테이너 기반 Jupyter 환경

## 프로젝트 요구사항

### 📚 강의 요구사항
- **프로젝트 위치**: `~/MLOps/zoomcamp/jupyter`
- **도구**: Jupyter Notebook/Lab
- **접속 방법**: 포트 포워딩을 통한 로컬 브라우저 접속 (localhost:8888)
- **라이브러리**: pandas, numpy, matplotlib, scikit-learn 등

### 🎯 기술적 목표
- Docker 컨테이너로 격리된 Jupyter 환경
- 볼륨 마운트로 데이터 영속성 확보
- VS Code 포트 포워딩 활용
- MLOps 도구 체인 통합

## 진행 상황

### ✅ 완료된 작업
1. **프로젝트 디렉토리 구조 설계**
   ```
   ~/MLOps/zoomcamp/jupyter/
   ├── notebooks/
   ├── data/
   └── requirements.txt
   ```

2. **Docker 전략 수립**
   - 초기 계획: `jupyter/datascience-notebook:latest`
   - 대안 계획: `jupyter/minimal-notebook:latest`

### 🚧 현재 진행 중
1. **인프라 문제 해결**
   - EBS 볼륨 8GB → 30GB 확장 (AWS 콘솔 완료)
   - 파티션 및 파일시스템 확장 대기 중

### 🔄 다음 단계
1. **파티션 확장**
   ```bash
   sudo growpart /dev/xvda 1
   sudo resize2fs /dev/xvda1
   ```

2. **Jupyter 컨테이너 배포**
   ```bash
   docker run -d \
     --name jupyter-mlops \
     -p 8888:8888 \
     -v ~/MLOps/zoomcamp/jupyter:/home/jovyan/work \
     -e JUPYTER_ENABLE_LAB=yes \
     --restart unless-stopped \
     jupyter/datascience-notebook:latest
   ```

3. **VS Code 포트 포워딩 설정**
   - Ctrl + ~ (터미널 열기)
   - "포트" 탭에서 8888 포트 포워딩
   - localhost:8888로 접속 테스트

## 발견된 문제와 해결책

### 🚨 디스크 공간 부족 문제
**문제**: 
- t2.large 인스턴스 기본 EBS: 8GB
- jupyter/datascience-notebook 이미지: ~5-6GB
- 기존 시스템 사용량: 3.9GB
- 결과: 공간 부족으로 설치 실패

**해결책**:
- AWS 콘솔에서 EBS 볼륨 30GB로 확장
- 파티션 및 파일시스템 확장 진행 중

### 💡 인스턴스 타입 vs 스토리지 이해
**학습 내용**:
- t2.large = 메모리 8GB, vCPU 2개
- 기본 EBS 볼륨은 인스턴스 타입과 무관하게 8GB
- 스토리지는 별도로 확장해야 함

## 기술 아키텍처

### 🐳 Docker 환경
```yaml
서비스: jupyter-mlops
이미지: jupyter/datascience-notebook:latest
포트: 8888:8888
볼륨: ~/MLOps/zoomcamp/jupyter:/home/jovyan/work
환경: JUPYTER_ENABLE_LAB=yes
재시작: unless-stopped
```

### 🌐 네트워크 구성
```
로컬 브라우저 → VS Code 포트 포워딩 → EC2:8888 → Docker 컨테이너
```

### 💾 데이터 구조
```
Host: ~/MLOps/zoomcamp/jupyter/
Container: /home/jovyan/work/
브라우저: localhost:8888/lab
```

## 성능 및 비용 고려사항

### 📊 리소스 사용량
- **CPU**: 2 vCPU (t2.large)
- **메모리**: 8GB (충분한 Jupyter 환경)
- **스토리지**: 30GB (확장 후)
- **네트워크**: 포트 8888 노출

### 💰 추가 비용
- **EBS 확장**: 8GB → 30GB (+22GB)
- **월 추가 비용**: ~$1.76 (gp3 기준)
- **총 예상 비용**: ~$69/월

## 예상 결과물

### 📓 Jupyter 환경
- JupyterLab 인터페이스
- Python 3.x 환경
- 사전 설치된 데이터 사이언스 라이브러리
- 터미널 접근 가능

### 🔗 통합 환경
- Git 연동 가능
- 패키지 추가 설치 가능
- 노트북 파일 영속성 보장
- VS Code와 연동

## 위험 요소 및 대응

### ⚠️ 잠재적 문제
1. **네트워크 연결 불안정**: SSH 원격 명령어 실행 이슈
2. **메모리 부족**: 대용량 데이터 처리 시
3. **포트 충돌**: 기존 서비스와의 포트 충돌

### 🛡️ 대응 방안
1. **직접 SSH 접속**으로 수동 설정
2. **메모리 모니터링** 및 필요시 인스턴스 업그레이드
3. **포트 매핑 유연성** 확보 (8888 외 대안 포트)

## 다음 마일스톤
- [ ] EBS 볼륨 확장 완료
- [ ] Jupyter 컨테이너 성공적 배포
- [ ] 포트 포워딩 설정 및 테스트
- [ ] 첫 번째 노트북 생성 및 pandas 테스트
- [ ] MLOps Zoomcamp 강의 진행 