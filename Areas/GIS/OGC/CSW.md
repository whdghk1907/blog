# Catalogue Service for the Web (CSW) 이해하기

## 소개
**Catalogue Service for the Web (CSW)**는 OGC(Open Geospatial Consortium) 표준으로, 지리정보 메타데이터를 검색하고 검색 결과를 공유하기 위한 서비스입니다.  
CSW는 메타데이터를 기반으로 사용자가 필요한 공간 데이터 또는 서비스(WMS, WFS 등)를 효율적으로 탐색하고 활용할 수 있도록 돕습니다.  
이 표준은 특히 대규모 데이터 인프라에서 메타데이터 관리와 데이터 검색을 최적화하는 데 사용됩니다.

---

## 개요

### 1. 주요 특징
- **메타데이터 검색**: 메타데이터를 쿼리하여 사용자가 원하는 지리 데이터를 찾을 수 있음.
- **표준 기반 상호운용성**: ISO 19115 및 ISO 19139 같은 메타데이터 표준 준수.
- **다양한 검색 방식**: 키워드, 공간, 시간 등의 다양한 기준으로 검색 가능.

### 2. 메타데이터 관리
CSW는 지리 데이터의 메타데이터를 카탈로그화하여 관리하며, 메타데이터에는 다음과 같은 정보가 포함됩니다:
- 제목, 설명, 키워드.
- 데이터셋의 공간적, 시간적 범위.
- 데이터의 출처 및 라이선스 정보.
- 데이터에 접근할 수 있는 서비스 URL(WMS, WFS 등).

---

## 구성 요소

### 1. 주요 작업 (Operations)
CSW는 세 가지 주요 작업을 지원합니다:

#### **1. GetCapabilities**
- CSW 서비스의 기능과 제공되는 메타데이터의 정보를 반환합니다.

**요청 예시**  
\```
GET https://example.com/csw?SERVICE=CSW&REQUEST=GetCapabilities
\```

**응답 예시 (XML)**  
\```
<Capabilities xmlns="http://www.opengis.net/cat/csw/2.0.2" version="2.0.2">
  <ServiceIdentification>
    <Title>Example CSW Service</Title>
    <Abstract>Sample Catalogue Service for discovering metadata</Abstract>
  </ServiceIdentification>
  <OperationsMetadata>
    <Operation name="GetRecords"/>
    <Operation name="GetRecordById"/>
  </OperationsMetadata>
</Capabilities>
\```

---

#### **2. GetRecords**
- 메타데이터를 검색하는 작업으로, 특정 검색 조건(키워드, 공간 범위 등)에 따라 결과를 반환합니다.

**요청 예시 (XML)**  
\```
<GetRecords
    xmlns="http://www.opengis.net/cat/csw/2.0.2"
    service="CSW"
    version="2.0.2"
    resultType="results">
  <Query typeNames="csw:Record">
    <Constraint version="1.1.0">
      <Filter xmlns="http://www.opengis.net/ogc">
        <PropertyIsLike>
          <PropertyName>csw:Title</PropertyName>
          <Literal>%example%</Literal>
        </PropertyIsLike>
      </Filter>
    </Constraint>
  </Query>
</GetRecords>
\```

**응답 예시 (XML)**  
\```
<GetRecordsResponse>
  <SearchResults numberOfRecordsMatched="1" numberOfRecordsReturned="1">
    <Record>
      <dc:Title>Example Dataset</dc:Title>
      <dc:Identifier>12345</dc:Identifier>
      <dc:Abstract>Sample metadata description.</dc:Abstract>
      <dc:BoundingBox>
        <ows:LowerCorner>-180 -90</ows:LowerCorner>
        <ows:UpperCorner>180 90</ows:UpperCorner>
      </dc:BoundingBox>
    </Record>
  </SearchResults>
</GetRecordsResponse>
\```

---

#### **3. GetRecordById**
- 특정 ID를 가진 메타데이터를 검색합니다.

**요청 예시**  
\```
GET https://example.com/csw?SERVICE=CSW&REQUEST=GetRecordById&ID=12345
\```

**응답 예시 (XML)**  
\```
<GetRecordByIdResponse>
  <Record>
    <dc:Title>Example Dataset</dc:Title>
    <dc:Identifier>12345</dc:Identifier>
    <dc:Abstract>Sample metadata description.</dc:Abstract>
    <dc:BoundingBox>
      <ows:LowerCorner>-180 -90</ows:LowerCorner>
      <ows:UpperCorner>180 90</ows:UpperCorner>
    </dc:BoundingBox>
  </Record>
</GetRecordByIdResponse>
\```

---

## 주요 특징

### 1. 검색 기준
CSW는 다양한 검색 기준을 지원하여 사용자 요구에 맞는 데이터 검색이 가능합니다:
- **키워드 검색**: 데이터셋 제목 또는 설명에 포함된 텍스트.
- **공간 검색**: 특정 지역 또는 좌표 범위 내 데이터 검색.
- **시간 검색**: 시간 범위에 따른 데이터 검색.

### 2. 상호운용성
- **ISO 19115/19139**: 메타데이터 표준 준수.
- **OGC 표준 서비스**: WMS, WFS, WCS 등과의 통합 지원.

### 3. 확장성
- CSW는 사용자 정의 메타데이터 스키마를 통해 다양한 응용 프로그램에 맞게 확장할 수 있습니다.

---

## 활용 사례
- **지리 데이터 검색 플랫폼**: 국가 또는 지역 데이터 인프라에서 메타데이터 관리.
- **환경 모니터링**: 다양한 센서 네트워크 데이터의 메타데이터를 검색 및 통합.
- **연구 및 교육**: 지리 데이터를 찾고 활용하는 데 필요한 메타데이터 제공.
- **스마트 도시**: 도시 데이터의 메타데이터 관리 및 공유.

---

## 결론
**CSW**는 지리 데이터를 탐색하고 검색하기 위한 강력한 도구로, 대규모 데이터 인프라에서 필수적인 역할을 합니다.  
표준
