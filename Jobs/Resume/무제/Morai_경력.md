
# **🚘MORAI Inc (2023.10.31 ~ 2024.12.31)**

### **1.1 OpenDRIVE API 모듈 개발 및 최적화**
- **FastAPI 기반 API 서버 전환**: 기존 OpenDRIVE 변환 프로세스를 FastAPI 기반으로 재구성하여 API 호출을 통한 확장성과 재사용성 극대화.
- **비동기 병렬 처리 아키텍처 구현**: Celery + Redis + Kubernetes 기반의 분산 처리 구조를 설계하여 대용량 변환 요청을 효율적으로 처리.
- **모듈화 및 코드 관리 최적화**: 기존 HDMap Editor에서 OpenDRIVE 변환 로직을 분리하고, 독립 Submodule 설계로 코드 유지보수성 개선.
- **확장 가능성 고려한 구조 설계**: 단일 사용자용 프로토타입을 개발한 후, 동시 10~20명 이상의 사용자 요청을 처리할 수 있도록 API 서버 스케일링 계획.

### **1.2 GeoDjango / PostGIS 기반 GIS 서버 구축**
- **PostGIS 데이터베이스 설계**: 지리공간 데이터를 효율적으로 저장 및 관리하기 위해 PostGIS를 도입하고, 공간 인덱싱 및 최적화 적용.
- **GeoDjango 기반 GIS API 개발**: Django + GeoDjango를 활용하여 지리정보 데이터를 제공하는 API 서버 구축.
- **GIS 알고리즘 적용**: PostGIS의 공간 연산 기능을 활용해 공간 분석 및 최적화된 경로 탐색 기능 구현.
- **ISO 20524-2 기반 데이터 관리 모델 설계**: 국제 표준을 반영하여 Belt 개념을 도입한 데이터 관리 및 조회 성능 개선.

### **1.3 DevOps 및 CI/CD 환경 구축**
- **자동화된 CI/CD 파이프라인 구축**: Docker, Jenkins, GitLab Runner, Kubernetes를 활용하여 개발-테스트-배포 자동화 환경 구성.
- **Kubernetes HPA(Horizontal Pod Autoscaler) 적용**: CPU 사용량 기반으로 Pod 자동 확장, 트래픽 증가 시 안정적인 API 서비스 제공.
- **보안 강화 및 코드 보호**: Cython을 활용하여 코드 난독화 및 클라우드 배포 환경에서 보안성 강화.

### **1.4 Map Editor 서버 기능 개발 및 최적화**
- **교차로 충돌 탐지 API 개발**: Agent 팀 요청에 따라 교차로에서 발생할 수 있는 충돌 가능 링크 목록을 동적으로 제공하는 API 개발.
- **곡선 계수 데이터 저장 API 구현**: OpenDRIVE geometry 시스템을 활용하여 곡선화 계수를 저장 및 관리하는 API 개발.
- **속성 변환 모듈 개발**: MgeoPropertyConverter를 개발하여 GIS 데이터 속성 변환 및 표준화 진행.
- **SliceRoad 기능 개선**: 도로 데이터의 일관성을 유지하도록 중복 오류 수정 및 로직 최적화.
- **VWorld API 통합 준비**: 백그라운드 지도 기능 강화를 위해 VWorld API 기반의 지도 생성 및 편집 기능 확장.

### **1.5 Map Editor 리팩토링 및 성능 최적화**
- **데이터 정합성 확보를 위한 idx 중복 방지 로직 추가**: 중복 객체 생성 방지 및 데이터 무결성 강화
- **프로젝트 전반의 코드 품질 개선**: 선언되지 않은 입력값 처리, import 누락 수정 등 문법적 오류 제거 및 코드 스타일 개선.
- **충돌 링크 탐색 알고리즘 개선**: GIS DB 아키텍처를 최적화하여 공간 분석 성능 향상 및 Belt 개념을 반영한 데이터 구조 개선.


# **2. 기술 스택 및 도구**

| 카테고리       | 사용 기술                          |
| ---------- | ------------------------------ |
| **백엔드**    | FastAPI, Django, GeoDjango     |
| **DB**     | PostgreSQL, PostGIS            |
| **CI/CD**  | GitLab Runner, Docker, Jenkins |
| **DevOps** | Kubernetes, Minikube, HPA      |
| **버전 관리**  | Git, GitLab                    |
| **지도 데이터** | OpenDRIVE, VWorld API          |

# **3. 핵심 경험 및 기여**

- **API 서버 최적화**: OpenDRIVE 변환 API를 비동기 방식으로 전환하여 대규모 요청 처리 성능 향상.
- **공간 데이터 최적화**: PostGIS 활용 GIS 데이터 관리 및 최적화된 경로 탐색 기능 개발.
- **CI/CD 및 자동화 구축**: Docker 및 Kubernetes 기반으로 배포 및 스케일링 자동화.
- **지도 편집 기능 개선**: VWorld API 연계를 통한 백그라운드 지도 생성 및 도로 편집 기능 확장.
- **Map Editor 성능 최적화**: 데이터 정합성 강화 및 충돌 탐색 알고리즘 개선.

<div class="page-break"></div>

