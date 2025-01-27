
---
title:  GIS 업계에서 경험을 쌓아가고 있는 서버 개발자, Rumble 입니다 :)

---

 
# **프로필** 
<div align="center"> <img src="KakaoTalk_20250126_173647306.jpg" alt="프로필 사진" width="150" style="border-radius: 50%; margin-bottom: 20px;"> </div>
- **GitHub**: [github.com/whdghk1907](https://github.com/whdghk1907) 
- **이메일**: whdghk1907@naver.com


## **🗺️ Geotwo 정보기술**  
**2022.06.14 ~ 2023.10.20**  

### **▎ GIS 교육 및 실습 멘토링**  
- **Geotools, Geoserver 활용 교육**: OpenLayers, Geotools, Geoserver의 구조적 사용법에 대한 사내 교육 세션 진행.  
- **공간 분석 프로젝트 수행**: OpenLayers, Geoserver를 활용한 공간 분석 및 기능성 검증 프로젝트 진행.  
- **PostGIS DB 실습 진행**: 공간 데이터 관리 및 쿼리 작성.  
- **WMS, WFS, WCS, WPS 활용 실습**: GIS 표준 포맷 데이터를 WKT 타입으로 변환하는 실습 진행.  
- **WebProject 실습**: PostGIS 및 공간 분석 쿼리를 적용한 GIS 웹 프로젝트 구현.  

### **▎ 개발 업무 진행**  
**2022.09 ~ 2023.08**  
- **GIS SDK 개발**: OpenLayers, Geotools 기반 SDK 서버 관리 및 테스트 페이지 개발.  
  - SDK 샘플 페이지와 관련된 Docs 페이지 작성.  
  - 사용자 입력 parameter를 작성하고 전송한 결과를 검증할 수 있는 테스트 페이지 개발.  
- **RESTful API 개발 및 검증**: 데이터 전송과 구성에 대한 리뷰 및 리팩토링 진행.  
- **프론트엔드 개발**: React, TypeScript, Recoil, React-query 등을 활용한 게시판 개발 및 KanbanBoard 시스템 개발.  
- **해외 프로젝트 리팩토링 및 추가 개발**:  
  - Solution으로 기존 코드 재활용 및 패키징 작업 진행.  
  - 내부 및 외부 프로젝트 코드 리뷰와 리팩토링 수행.  
- **GIS 국내 프로젝트 유지보수**:  
  - 엘리베이션 요청 대량 관리 기능 개발.  
  - 200GB 이상의 공간 데이터 관리 스크립트 개발.  

## **🖥️ 대규모 서버 정리 및 리드**  
**2023.02 ~ 2023.03**  
- **배포 서버 정리**: Jenkins를 활용하여 배포 프로세스 통합.  
- **서버 데이터 정리**: PostGIS, Oracle 등 데이터베이스 구조 최적화 및 마이그레이션 진행.  
- **최적화 작업**: 서버 데이터 정리와 효율적 호출 구조 설계.  

## **⚙️ DevOps 환경 구축**  
**2023.05 ~ 2023.07**  
- **Docker 기반 개발 서버 구성**: Jenkins를 활용한 배포 서버 자동화 구축.  
- **Spring Boot 및 배포 환경 최적화**: React, Tomcat 환경에서 배포 프로세스 개선.  
- **CI/CD 자동화**: Nexus를 활용한 배포 패키지 관리 및 라이브러리 활용.  
- **SSL 인증서 오류 해결**: 인증서 만료 문제를 원격으로 해결.  
- **유틸리티 자동화**: utillkit nexus를 통한 배포 및 리소스 정리 프로세스 구축.  

---

## **🚘 MORAI Inc**  
**2023.10.30 ~ 2024.12.31**  

### **▎ OpenDRIVE API Module 개발 및 최적화**  
- **FastAPI 서버 기반 전환**: 기존 OpenDRIVE 변환 작업을 FastAPI 서버로 전환, 재사용성과 효율성을 300% 이상 향상.  
- **병렬 처리 워크플로우 설계**: Celery, Redis, Kubernetes를 활용하여 대규모 변환 작업 처리 효율화.  
- **코드 관리 효율화**: mgeo_editor와 변환 코드를 분리, submodule 구조 도입 및 전용 repository 생성으로 코드 유지보수 비용 절감.  
- **pylib_opendrive 레포지토리 생성 및 유지관리**: 독립적인 코드 관리를 위해 새로운 repository 설계.  
- **확장 가능성 고려한 설계**: 단독 사용자용 프로토타입 완성 후, 동시 10~20명 지원 가능한 구조 확장 중.

### **▎ GeoDjango / PostGIS 서버 설계 및 구현**  
- **지리정보 데이터 관리**: PostGIS를 데이터베이스로 채택하여 지리정보 저장 및 관리 기능을 강화. 
- **GIS 알고리즘 활용**: PostGIS에서 제공하는 GIS 알고리즘을 활용해 데이터 활용도를 극대화하고 API 서버의 기능을 분리.  
- **GeoDjango 채택**: 기존 개발자들의 적응 비용을 최소화하기 위해 Django와 GeoDjango를 Python 기반 서버 프레임워크로 채택.  
- **데이터 구조 설계**: Morai의 기존 데이터 구조와 연결성을 확보하며, 속성 데이터 간 관계성을 매칭하고 View를 활용해 인덱스 최적화.  
- **Belt 개념 도입**: ISO 20524-2에서 제시하는 Belt 개념을 기반으로 데이터 관리 모델과 View를 설계 및 구현.  

### **▎ DevOps 및 CI/CD 환경 구축**  
- **자동화 배포 환경 구축**: Docker, Jenkins, GitLab Runner, Kubernetes를 활용한 CI/CD 파이프라인 구축.  
- **Kubernetes HPA 도입**: CPU 부하 기반 복사본 자동 배포로 대규모 요청 처리 최적화.  
- **보안 강화**: Cython을 사용하여 클라우드 배포 환경에서 코드 암호화 및 보안 강화.  
- **효율적 배포 프로세스 구축**: Dockerfile, Shell Script, YAML 파일로 배포 및 설정 작업 자동화.  

### **▎ Map Editor 기능 개발 및 고도화**  
- **교차로 충돌 링크 목록화**: Agent 팀의 요청에 따라 충돌 가능한 링크 정보 제공.  
- **곡선 계수 정보 저장**: OpenDRIVE geometry 시스템 활용, spline 곡선화 계수 저장 기능 개발.  
- **속성 명칭 공통화**: MgeoPropertyConverter 모듈 개발, 속성 편집을 위한 사용자 친화적 widget 제공.  
- **SliceRoad 기능 고도화 및 개선**: 중복 오류 수정 및 로직 최적화로 데이터 일관성 확보.  
- **VWorld API 통합 준비**: 배경 지도 생성 및 편집 기능 향상을 위한 준비 작업 수행.  

### **▎ Map Editor 리팩토링 및 오류 수정**  
- **idx 중복 방지 로직 추가**: 중복 객체를 방지하여 데이터 정합성 및 유지보수 효율성 증대.  
- **문법적 오류 개선**: 선언되지 않은 입력값, 누락된 import 등 프로젝트 전반의 문법 오류를 수정하여 코드 품질 강화.  
- **충돌 링크 검색 및 GIS DB 구조 보완**: Belt 아키텍처를 적용, 성능 최적화 및 효율성 극대화.  

---

## **기술 스택 및 역량**

### **Backend Development**  
- **Python**: FastAPI, Flask, Django를 활용한 API 개발 및 Celery 기반 워크플로우 설계.  
- **GIS 기술**: GeoDjango, PostGIS, OpenLayers, Geotools, Geoserver 등 공간 분석 및 데이터 관리.  
  - WMS, WFS, WCS, WPS를 활용한 공간 데이터 처리 및 GIS 표준 포맷 변환.  
  - PostGIS DB 설계 및 최적화, 공간 데이터 쿼리 작성 및 관리.  
  - ISO 20524-2 기반 Belt 개념 설계를 통한 데이터 관리 모델 개발.  

### **DevOps**  
- Docker, Kubernetes, Jenkins, GitLab Runner를 통한 배포 및 유지보수 자동화.  
- Cython을 활용한 대규모 데이터 처리 및 코드 보안 강화.  
- **CI/CD 구축 경험**: Nexus를 활용한 패키지 관리와 SSL 인증 문제 해결.  

### **Frontend Development**  
- React, TypeScript 기반 UI 개발 및 상태 관리(Recoil, React-query).  
- GIS 관련 SDK 및 테스트 페이지 개발 경험.  

### **Database**  
- PostGIS, MySQL, Redis 등 데이터베이스 설계 및 최적화.  
- 200GB 이상의 공간 데이터를 효율적으로 관리하는 스크립트 설계 및 구현.  

