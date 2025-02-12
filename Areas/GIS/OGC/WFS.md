# WFS (Web Feature Service)

**WFS (Web Feature Service)**는 OGC(Open Geospatial Consortium) 표준 프로토콜 중 하나로, 웹(HTTPS)을 통해 지리 데이터를 벡터 형식으로 제공하는 서비스입니다.  
WFS는 단순히 지도 이미지를 제공하는 WMS와 달리, 데이터를 직접 다운로드하거나 질의(Query)를 통해 속성과 공간 데이터를 조회 및 처리할 수 있습니다.

---

## 구성 요소

### 1. GetCapabilities *(필수)*  
WFS 서비스의 메타데이터를 반환합니다.  
- 기능 및 서비스 인자 정보, 이용 가능한 피처 타입(Feature Types) 목록, 지원하는 작업(Transactions) 등이 포함됩니다.  
- 클라이언트가 WFS를 활용하기 위한 초기 요청으로 사용됩니다.

**요청 예시**  
```
GET https://example.com/wfs?service=WFS&request=GetCapabilities
```

**응답 예시 (XML)**  
```
<WFS_Capabilities version="2.0.0">
  <ServiceIdentification>
    <Title>Example WFS Service</Title>
    <Abstract>This is a sample WFS service.</Abstract>
  </ServiceIdentification>
  <FeatureTypeList>
    <FeatureType>
      <Name>example_feature</Name>
      <Title>Example Feature</Title>
      <DefaultCRS>EPSG:4326</DefaultCRS>
    </FeatureType>
  </FeatureTypeList>
</WFS_Capabilities>
```

---

### 2. DescribeFeatureType *(필수)*  
특정 피처 타입의 구조와 속성 정보를 반환합니다.  
- 피처 타입의 필드 이름, 데이터 타입, 기타 메타데이터 정보를 확인할 수 있습니다.

**요청 예시**  
```
GET https://example.com/wfs?service=WFS&request=DescribeFeatureType
    &typeName=example_feature
```

**응답 예시 (XML Schema)**  
```
<xsd:schema>
  <xsd:element name="example_feature" type="xsd:complexType">
    <xsd:complexType>
      <xsd:sequence>
        <xsd:element name="id" type="xsd:int"/>
        <xsd:element name="name" type="xsd:string"/>
        <xsd:element name="geometry" type="gml:PointPropertyType"/>
      </xsd:sequence>
    </xsd:complexType>
  </xsd:element>
</xsd:schema>
```

---

### 3. GetFeature *(필수)*  
요청된 피처 데이터를 반환합니다.  
- 공간(Geometry) 및 속성(Attribute) 데이터를 포함하여 반환되며, 질의(Query)를 통해 원하는 데이터만 선택할 수 있습니다.

**요청 예시**  
```
GET https://example.com/wfs?service=WFS&request=GetFeature
    &typeName=example_feature
    &bbox=-180,-90,180,90
```

**응답 예시 (GML)**  
```
<wfs:FeatureCollection>
  <gml:featureMember>
    <example_feature>
      <id>1</id>
      <name>Feature A</name>
      <geometry>
        <gml:Point>
          <gml:coordinates>-45.0,60.0</gml:coordinates>
        </gml:Point>
      </geometry>
    </example_feature>
  </gml:featureMember>
</wfs:FeatureCollection>
```

---

### 4. Transaction *(옵션)*  
WFS 데이터를 추가, 수정, 삭제하는 작업(Transaction)을 수행합니다.  
- 주로 데이터 편집이나 동적 데이터 관리에 활용됩니다.

**요청 예시** (삽입 예시)  
```
POST https://example.com/wfs
Content-Type: text/xml
```

**요청 본문 (XML)**  
```
<wfs:Transaction service="WFS" version="2.0.0">
  <wfs:Insert>
    <example_feature>
      <id>2</id>
      <name>Feature B</name>
      <geometry>
        <gml:Point>
          <gml:coordinates>100.0,-50.0</gml:coordinates>
        </gml:Point>
      </geometry>
    </example_feature>
  </wfs:Insert>
</wfs:Transaction>
```

**응답 예시**  
```
<wfs:TransactionResponse>
  <wfs:TransactionSummary>
    <wfs:totalInserted>1</wfs:totalInserted>
    <wfs:totalUpdated>0</wfs:totalUpdated>
    <wfs:totalDeleted>0</wfs:totalDeleted>
  </wfs:TransactionSummary>
</wfs:TransactionResponse>
```

---

### 5. LockFeature *(옵션)*  
특정 피처 데이터를 편집할 수 있도록 잠금(Lock)을 요청합니다.  
- 트랜잭션 도중 데이터 충돌을 방지하는 데 유용합니다.

**요청 예시**  
```
GET https://example.com/wfs?service=WFS&request=LockFeature
    &typeName=example_feature
    &filter=<FilterExpression>
```

**응답 예시 (XML)**  
```
<wfs:LockFeatureResponse>
  <wfs:LockId>12345</wfs:LockId>
</wfs:LockFeatureResponse>
```

---

## 주요 특징
- **데이터 접근**: 지도 이미지가 아닌 실제 공간 데이터(Vector Data)를 제공.
- **질의 및 필터링**: 조건(Query)을 통해 필요한 데이터만 선택 가능.
- **트랜잭션 지원**: 데이터 추가, 수정, 삭제 가능.

---

## 활용 사례
- 공간 데이터 분석 및 시각화
- 동적 데이터 관리 및 실시간 업데이트
- 맞춤형 공간 질의를 통한 데이터 검색
