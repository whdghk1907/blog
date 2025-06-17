# Jupyter Docker 환경 구축 가이드

## 개요
Docker를 활용한 Jupyter 환경 구축 방법과 MLOps 프로젝트에 최적화된 설정을 다룹니다.

## Jupyter Docker 이미지 비교

### 📦 공식 Jupyter 이미지 선택 가이드

| 이미지 | 크기 | 포함 라이브러리 | 용도 |
|--------|------|----------------|------|
| `jupyter/base-notebook` | ~1GB | Jupyter, Python | 최소 환경 |
| `jupyter/minimal-notebook` | ~2GB | + pandas, matplotlib | 기본 데이터 분석 |
| `jupyter/scipy-notebook` | ~3GB | + scipy, scikit-learn | 과학 계산 |
| `jupyter/datascience-notebook` | ~5-6GB | + R, Julia, 통계 패키지 | 전체 데이터 사이언스 |
| `jupyter/tensorflow-notebook` | ~4GB | + TensorFlow, Keras | 딥러닝 |
| `jupyter/pytorch-notebook` | ~4GB | + PyTorch | 딥러닝 |

### 🎯 MLOps 프로젝트 권장 선택

#### 상황별 추천
1. **학습/실험**: `datascience-notebook` (풍부한 라이브러리)
2. **프로덕션**: `minimal-notebook` + 필요 패키지만 추가
3. **ML 모델링**: `scipy-notebook` (균형잡힌 선택)
4. **딥러닝**: `tensorflow-notebook` or `pytorch-notebook`

## 실전 배포 명령어

### 🚀 기본 Jupyter 환경
```bash
# 최소 환경 (2GB)
docker run -d \
  --name jupyter-minimal \
  -p 8888:8888 \
  -v ~/MLOps/zoomcamp/jupyter:/home/jovyan/work \
  -e JUPYTER_ENABLE_LAB=yes \
  --restart unless-stopped \
  jupyter/minimal-notebook:latest

# 데이터 사이언스 환경 (5-6GB)
docker run -d \
  --name jupyter-datascience \
  -p 8888:8888 \
  -v ~/MLOps/zoomcamp/jupyter:/home/jovyan/work \
  -e JUPYTER_ENABLE_LAB=yes \
  --restart unless-stopped \
  jupyter/datascience-notebook:latest
```

### 🔧 고급 설정
```bash
# 메모리 제한 및 환경 변수 추가
docker run -d \
  --name jupyter-mlops \
  -p 8888:8888 \
  -v ~/MLOps/zoomcamp/jupyter:/home/jovyan/work \
  -v ~/.ssh:/home/jovyan/.ssh:ro \
  --memory="4g" \
  --cpus="2" \
  -e JUPYTER_ENABLE_LAB=yes \
  -e GRANT_SUDO=yes \
  -e CHOWN_HOME=yes \
  --user root \
  --restart unless-stopped \
  jupyter/datascience-notebook:latest
```

## 디렉토리 구조 설계

### 📁 권장 프로젝트 구조
```
~/MLOps/zoomcamp/jupyter/
├── notebooks/              # Jupyter 노트북 파일
│   ├── 01-data-preparation/
│   ├── 02-model-training/
│   ├── 03-model-deployment/
│   └── experiments/         # 실험용 노트북
├── data/                    # 데이터 파일
│   ├── raw/                 # 원본 데이터
│   ├── processed/           # 전처리된 데이터
│   └── external/            # 외부 데이터
├── models/                  # 저장된 모델
│   ├── trained/
│   └── experiments/
├── src/                     # 소스 코드
│   ├── preprocessing/
│   ├── training/
│   └── utils/
├── requirements.txt         # Python 패키지 목록
├── environment.yml          # Conda 환경 설정
└── README.md               # 프로젝트 설명
```

### 🛠️ 디렉토리 생성 스크립트
```bash
#!/bin/bash
# create-jupyter-structure.sh

BASE_DIR="~/MLOps/zoomcamp/jupyter"

# 디렉토리 생성
mkdir -p $BASE_DIR/{notebooks/{01-data-preparation,02-model-training,03-model-deployment,experiments},data/{raw,processed,external},models/{trained,experiments},src/{preprocessing,training,utils}}

# 기본 파일 생성
cat > $BASE_DIR/requirements.txt << EOF
pandas>=1.5.0
numpy>=1.21.0
matplotlib>=3.5.0
seaborn>=0.11.0
scikit-learn>=1.1.0
jupyterlab>=3.4.0
notebook>=6.4.0
ipywidgets>=7.7.0
mlflow>=1.30.0
prefect>=2.0.0
EOF

cat > $BASE_DIR/README.md << EOF
# MLOps Zoomcamp Jupyter Environment

## 개요
이 프로젝트는 MLOps Zoomcamp 강의를 위한 Jupyter 환경입니다.

## 구조
- \`notebooks/\`: Jupyter 노트북 파일
- \`data/\`: 데이터 파일
- \`models/\`: 저장된 모델
- \`src/\`: 소스 코드

## 사용법
1. Docker 컨테이너 실행
2. localhost:8888에서 JupyterLab 접속
3. 토큰 입력 후 작업 시작
EOF

echo "Jupyter 프로젝트 구조가 생성되었습니다: $BASE_DIR"
```

## 네트워크 및 접속 설정

### 🌐 VS Code 포트 포워딩
1. **VS Code 터미널** 열기 (`Ctrl + ~`)
2. **"포트"** 탭 클릭
3. **"포트 추가"** → `8888` 입력
4. **브라우저**에서 `localhost:8888` 접속

### 🔐 토큰 확인 및 설정
```bash
# 컨테이너 로그에서 토큰 확인
docker logs jupyter-mlops 2>&1 | grep token

# 또는 컨테이너 내부에서 토큰 생성
docker exec jupyter-mlops jupyter notebook list

# 비밀번호 설정 (보안 강화)
docker exec -it jupyter-mlops jupyter notebook password
```

### 🔧 Jupyter 설정 커스터마이징
```bash
# 컨테이너 내부에서 설정 파일 생성
docker exec -it jupyter-mlops bash

# Jupyter Lab 설정
jupyter lab --generate-config

# 설정 파일 위치: ~/.jupyter/jupyter_lab_config.py
```

## 패키지 관리

### 📦 실행 중인 컨테이너에 패키지 추가
```bash
# conda 사용 (권장)
docker exec jupyter-mlops conda install -c conda-forge package_name

# pip 사용
docker exec jupyter-mlops pip install package_name

# requirements.txt에서 일괄 설치
docker exec jupyter-mlops pip install -r /home/jovyan/work/requirements.txt
```

### 🔄 환경 영속성 확보
```bash
# 현재 환경을 requirements.txt로 저장
docker exec jupyter-mlops pip freeze > ~/MLOps/zoomcamp/jupyter/requirements.txt

# conda 환경 저장
docker exec jupyter-mlops conda env export > ~/MLOps/zoomcamp/jupyter/environment.yml
```

## 모니터링 및 관리

### 📊 리소스 사용량 모니터링
```bash
# Docker 컨테이너 상태 확인
docker stats jupyter-mlops

# 컨테이너 리소스 사용량
docker exec jupyter-mlops free -h
docker exec jupyter-mlops df -h
```

### 🔧 컨테이너 관리 명령어
```bash
# 컨테이너 시작/중지
docker start jupyter-mlops
docker stop jupyter-mlops
docker restart jupyter-mlops

# 로그 확인
docker logs -f jupyter-mlops

# 컨테이너 내부 접속
docker exec -it jupyter-mlops bash

# 컨테이너 제거 (데이터는 보존됨)
docker rm jupyter-mlops
```

## 백업 및 복구

### 💾 데이터 백업
```bash
# 전체 작업 디렉토리 백업
tar -czf jupyter-backup-$(date +%Y%m%d).tar.gz ~/MLOps/zoomcamp/jupyter/

# 노트북만 백업
tar -czf notebooks-backup-$(date +%Y%m%d).tar.gz ~/MLOps/zoomcamp/jupyter/notebooks/

# 모델만 백업
tar -czf models-backup-$(date +%Y%m%d).tar.gz ~/MLOps/zoomcamp/jupyter/models/
```

### 🔄 환경 복구
```bash
# 백업에서 복구
tar -xzf jupyter-backup-20241215.tar.gz

# Docker 이미지 재배포
docker run -d \
  --name jupyter-mlops-restored \
  -p 8888:8888 \
  -v ~/MLOps/zoomcamp/jupyter:/home/jovyan/work \
  -e JUPYTER_ENABLE_LAB=yes \
  --restart unless-stopped \
  jupyter/datascience-notebook:latest
```

## 트러블슈팅

### ❌ 일반적인 문제들

#### 1. 토큰/비밀번호 분실
```bash
# 새 토큰 생성
docker exec jupyter-mlops jupyter notebook list

# 비밀번호 재설정
docker exec -it jupyter-mlops jupyter notebook password
```

#### 2. 포트 충돌
```bash
# 다른 포트로 변경 (예: 8889)
docker run -d --name jupyter-alt -p 8889:8888 [다른 옵션들]
```

#### 3. 권한 문제
```bash
# 볼륨 권한 수정
sudo chown -R 1000:100 ~/MLOps/zoomcamp/jupyter/

# 또는 root 권한으로 실행
docker run --user root [다른 옵션들]
```

#### 4. 메모리 부족
```bash
# 메모리 사용량 확인
docker stats jupyter-mlops

# 메모리 제한 증가
docker update --memory="8g" jupyter-mlops
```

## 성능 최적화

### ⚡ 성능 튜닝 팁
1. **메모리 할당**: 시스템 메모리의 50-70% 할당
2. **CPU 제한**: CPU 코어 수에 맞춰 설정
3. **볼륨 최적화**: SSD 스토리지 사용
4. **네트워크**: 로컬 네트워크 사용으로 지연시간 최소화

### 🎯 MLOps 특화 설정
```bash
# MLOps 도구 포함 환경
docker run -d \
  --name jupyter-mlops-full \
  -p 8888:8888 \
  -v ~/MLOps/zoomcamp/jupyter:/home/jovyan/work \
  -v ~/.aws:/home/jovyan/.aws:ro \
  -v ~/.docker:/home/jovyan/.docker:ro \
  -e JUPYTER_ENABLE_LAB=yes \
  -e MLFLOW_TRACKING_URI=sqlite:///mlflow.db \
  --restart unless-stopped \
  jupyter/datascience-notebook:latest
```

## 참고 자료
- [Jupyter Docker Stacks Documentation](https://jupyter-docker-stacks.readthedocs.io/)
- [JupyterLab Documentation](https://jupyterlab.readthedocs.io/)
- [Docker Volume Management](https://docs.docker.com/storage/volumes/) 