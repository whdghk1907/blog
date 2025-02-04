

### GeoAPI 구현 사항 (GeoAPI Implementaion Specification)


### 1. 개요

GeoAPI 구현 표준(GeoAPI Implementation Standard)은 GeoAPI 라이브러리를 통해 
Java 언어의 애플리케이션 프로그래밍 인터페이스(API)를 정의하며, 여기에는 기술위원회 211(Technical Committee 211)과 국제표준화기구(ISO), 그리고 Open Geospatial Consortium(OGC)이 채택한 사양에 따라 구조화된 지리 정보를 조작하는 데 사용할 수 있는 타입 및 메서드의 집합이 포함됩니다. 

이 표준은 공개된 API를 기반으로 정규화된 지리 정보 데이터 구조를 조작하는 클라이언트 코드와, 공개된 API 및 ISO와 OGC 표준이 요구하는 규칙에 따라 이러한 데이터 구조를 인스턴스화하고 이를 운영할 수 있는 라이브러리 코드 간의 정보 계약을 표준화합니다.


### 2. 머릿말

이 GeoAPI 표준은 Open Geospatial Consortium(OGC)과 자유 소프트웨어 커뮤니티에서 진행된 장기간의 노력에서 발전하였습니다. 이 노력은 OGC 추상 명세서(OGC Abstract Specification)에서 정의된 데이터 모델을 기반으로, 지리 공간 데이터를 조작하기 위한 일관된 데이터 모델을 정의하는 인터페이스 라이브러리를 개발하는 데 초점이 맞춰져 있었습니다. GeoAPI 라이브러리는 상호운용 가능하고 표준을 준수하는 Java 언어 소프트웨어를 쉽게 만들 수 있도록 개발되었습니다.

GeoAPI 인터페이스 라이브러리는 2001년 1월에 발표된 구현 명세서인 

**OGC 01-009 Coordinate Transformation Services Revision 1.00**(Martin Daly 편집)
https://www.ogc.org/publications/standard/ct/

에 기원을 두고 있습니다. 이 명세서에는 Java 언어로 작성되고 `org.opengis` 네임스페이스를 사용하는 일련의 인터페이스가 포함되어 있었습니다. 

GeoAPI 프로젝트는 2003년에 여러 기여자들이 여러 프로젝트 간에 공유할 수 있는 Java 언어 인터페이스 세트를 개발하려는 노력으로 시작되었습니다. 

GeoAPI 프로젝트는 이후 OGC 01-009의 인터페이스를 GeoAPI 라이브러리의 버전 0.1로 간주하고, OGC 명세서 **Geographic Objects**를 작성하는 개발자들과 협력하여 GeoAPI 1.0 작업을 시작했습니다.

그 후 Open Geospatial Consortium은 자체 추상 명세서(Abstract Specifications)를 폐기하고, 
국제표준화기구(ISO)의 기술위원회 211(Technical Committee 211)이 개발한 

**ISO 19100 시리즈**
https://www.scribd.com/document/394164916/ISO-19100-Geographic-Information-Standards

표준을 기반으로 추가 작업을 진행하기로 결정했습니다.

이에 따라 GeoAPI 프로젝트도 해당 표준에 맞게 라이브러리를 재정렬했습니다. 
2003년에는 구현 명세서

**OGC 03-064 GO-1 Application Objects Version 1.0**(Greg Reynolds 편집)
https://portal.ogc.org/files/?artifact_id=39397

의 첫 번째 공개 초안 릴리스에 맞춰 GeoAPI 라이브러리의 버전 1.0이 출시되었습니다. 
GO-1의 표준화 작업은 몇 년이 걸렸으며, 이 기간 동안 GeoAPI 라이브러리에서도 광범위한 작업이 이루어졌습니다. 

최종적으로 2005년에 GO-1 명세서가 공식적으로 발표되었을 때, GeoAPI 라이브러리의 버전 2.0이 릴리스되었습니다.
이 간략한 역사적 개요는 왜 이 명세서가 동일한 이름의 이전 OGC 명세서가 없음에도 불구하고 버전 번호 3.0을 채택했는지 설명합니다. 
우리는 이 명세서의 최종 버전과 함께 GeoAPI 라이브러리의 버전 3.0을 릴리스할 예정입니다.

GeoAPI 라이브러리와 그 참조 구현(reference implementation)은 OGC에 두 가지 주요 이점을 제공합니다. 
참조 구현은 표준 작성자들에게 표준화된 API가 포함하는 모든 ISO/OGC 명세를 단일하고 일관된 구현으로 개발할 수 있음을 보여줍니다. 
API는 OGC 커뮤니티에 새로운 상호운용성(interoperability) 지점을 제공합니다.

이 지점에서는 API를 사용하도록 작성된 클라이언트 코드와 API를 구현하도록 작성된 라이브러리 코드 간의 상호운용성이 제공되며, 이 상호운용성 계층은 OGC의 핵심 표준에 의해 정의된 인터페이스를 명시적으로 기반으로 하고 있습니다


***3,4,5는 표준과 상관 없어 생략 


### 5. 서문

해 줄 것을 요청받습니다. 또한, 이를 뒷받침할 수 있는 관련 문서를 제공해 주시기 바랍니다.