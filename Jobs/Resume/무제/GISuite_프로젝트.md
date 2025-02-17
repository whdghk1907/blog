## **🌍 GISuite (2025.01.01 ~ )**

🔗 **GitHub Repository**: [GISuite](https://github.com/whdghk1907/GISuite.git)

# **1. 프로젝트 개요**

### **1.1 GISuite**
- **설명**: GIS 초심자와 개발자를 위한 **OGC 표준 준수 Spring Boot 기반 GIS 데이터 관리 프레임워크**
- **목적**:
  - **JPA의 데이터베이스 마이그레이션 기능을 활용**하여 GIS 데이터베이스를 쉽고 직관적으로 사용할 수 있도록 지원
  - OGC 표준을 준수하는 **공간 데이터 모델 설계 및 관리 기능 제공**
  - **Spring Boot + JPA 환경**에서 공간 데이터 **CRUD 및 고급 공간 쿼리 지원**
  - **PostGIS 기반 GIS 데이터 저장 및 공간 분석 기능 제공**

---

# **2. 기술 스택 및 도구**

| 카테고리        | 사용 기술                       |
| ----------- | --------------------------- |
| **백엔드**     | Spring Boot, JPA            |
| **DB**      | PostgreSQL, PostGIS         |
| **GIS**     | Hibernate Spatial, GeoTools |
| **프로젝트 관리** | GitHub, Maven               |

---

# **3. 주요 기능 및 기여**

### **3.1 JPA 기반 GIS 데이터베이스 마이그레이션**
- **JPA의 Schema Generation 기능을 활용한 데이터 모델 자동화**
- **OGC 표준 준수 GIS 데이터베이스 설계 및 스키마 관리**
- **Hibernate Spatial을 활용한 PostGIS 연동 및 공간 데이터 저장 최적화**
- **데이터베이스 변경 사항 자동 반영 및 관리 (Flyway, Liquibase 지원)**

### **3.2 API 개발 및 성능 개선**
- **Spring Boot 3.x 최적화**: 최신 Spring Boot 기능을 활용한 성능 개선
- **JPA 기반 공간 데이터 CRUD API 개발**: 대용량 GIS 데이터의 효율적 처리 및 서비스 운영
- **GeoJSON, Shapefile 지원**: 다양한 GIS 데이터 포맷과의 호환성 확보
- **Swagger 기반 API 문서화**: 개발자 친화적인 API 문서 제공

### **3.3 DevOps 환경 구축 및 배포 자동화**
- **Docker 및 Kubernetes 기반 배포 환경 구축**: GIS 서버의 확장성 및 안정성 강화
- **CI/CD 파이프라인 적용**: GitHub Actions를 활용한 자동 빌드 및 배포
- **Minikube 기반 개발 환경 테스트**: 로컬 환경에서도 Kubernetes 배포 검증 가능

---

# **4. 핵심 경험 및 성과**

- **JPA 기반 데이터베이스 마이그레이션을 활용한 GIS 데이터 모델 관리 최적화**
- **OGC 표준 기반 공간 데이터 모델 설계 및 최적화**
- **PostGIS 및 Hibernate Spatial을 활용한 GIS 데이터 처리 성능 개선**
- **Spring Boot 기반 API 개발 및 대규모 GIS 데이터 운영**
- **Docker 및 Kubernetes를 활용한 배포 자동화 구축**
- **CI/CD 적용을 통한 개발-배포 효율성 증대**

---

# **5. 향후 계획**

- **JPA 마이그레이션 기능 확장을 통한 GIS 데이터 모델 관리 효율성 향상**
- **OpenAPI 문서화 및 개발자 친화적 환경 구축**
- **공간 분석 기능 추가 및 성능 최적화**
- **지속적인 오픈소스 기여 및 커뮤니티 활성화**

