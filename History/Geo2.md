### 🗺️ Geotwo 정보기술

2022.06.14 ~ 2023.10.20

### **▎ 실습**

- OpenLayers, Geotools, Geoserver의 구조와 사용법에 대한 사내 교육시스템 진행
- OpenLayers, Geotools, Geoserver를 활용하여 공간분석, 기능구현 등 과제를 수행하며 개인 프로젝트 수행
- PostGIS 공간 DB에 대한 교육과 실습 진행
- WMS, WFS, WCS, WPS 등 GIS 표준 통신방식 및 WKT 데이터 타입에 대한 실습 진행
- 공간분석 WebProject에 투입되어, PostGIS 공간분석 쿼리 작성

**▎ 개발**

- GIS 공간분석에 사용되는 OpenLayers, Geotools 기반의 SDK 서버의 관리 및 예제 / 테스트 페이지 개발
    - SDK 서버의 코드 분석하여 Docs 페이지 작성
    - parameter를 작성하고 요청을 보낸후 결과값을 확인할 수 있는 test 페이지 개발
- 사내 QA 시스템의 기획 및 개발 투입
    - RESTful API 규칙을 철저히 준수하여 데이터를 통신하고, 규칙에 대한 리뷰 및 리팩토링 진행
    - React, TypeScript, Recoil, React-query 등을 활용하여 게시판 개발 및 일정관리를 위한 KanbanBoard 시스템 개발
- GIS 해외 프로젝트 리팩토링 및 추가개발 투입
    - 해외 프로젝트를 Solution으로 이용하기 위해 패키징 진행
    - 자사의 해외지사에서 수행한 프로젝트 내부의 오류 수정 및 리팩토링 진행
    - 필요한 추가 기능 개발 및 불필요 코드 제거
- GIS 국내 프로젝트 개발 및 유지보수
    - 엑셀 활용한 공원 대장관리 기능 개발
    - 200GB용량의 파일 관리 서버 관리용 유틸성 스크립트 개발

### **▎ Devops**

- 개발서버 Docker 활용
    - 내부에 Jenkins 배포하여 개발서버 배포전략 구성
    - SpringBoot, React, Tomcat 프로젝트 배포
    - 내부에 Nexus 배포하여 사내 라이브러리로써 활용
    - 프로젝트 진행시 빈번하게 사용되는 util성 클래스들 정리하여 utilkit nexus로 배포
    - 배포과정중 발생한 SSL 인증문제 해결

### **▎ 대규모 서버 정리 작업 리드**

- Jenkins 활용하여 배포방식 통일화 예시
- 대규모 서버 정리 작업 총괄 및 코드 리뷰
- 데이터베이스 마이그레이션 파일 정리