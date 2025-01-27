
# Web Map Tile Service (WMTS) 이해하기

## 소개
**Web Map Tile Service (WMTS)**는 OGC(Open Geospatial Consortium) 표준으로, 타일 기반 지리정보 데이터를 제공하기 위한 서비스입니다.  
WMTS는 TMS(Tile Map Service)와 유사하지만, OGC 표준으로 정의되어 더 넓은 호환성과 상호운용성을 제공합니다.  
WMTS는 타일을 고정된 격자 및 줌 레벨로 나누어 빠르게 지도 데이터를 전송하며, 대규모 웹 맵 애플리케이션에서 자주 사용됩니다.

---

## 개요

### 1. 주요 특징
- **표준 기반**: OGC 표준으로 정의되어 다양한 클라이언트와 상호운용 가능.
- **효율성**: 타일 캐싱을 통해 빠른 데이터 전송 및 지도 렌더링 가능.
- **다양한 요청 방식**: RESTful, KVP(Key-Value Pair), SOAP 등을 지원.

---

## 구성 요소

### 1. 타일 구조
WMTS는 **타일맵 모델(TileMatrixSet)**을 기반으로 지도 데이터를 구성합니다.  
각 타일맵 모델은 줌 레벨, 행(Row), 열(Column) 정보와 좌표 체계로 정의됩니다.

#### 주요 요소:
- **TileMatrixSet**: 타일맵의 격자 정의 (예: EPSG:3857).
- **Zoom Level**: 확대/축소 레벨.
- **TileRow/TileCol**: 타일의 행(Row)과 열(Column).

---

### 2. WMTS 요청 방식
WMTS는 세 가지 요청 방식을 지원합니다:
1. **RESTful**: 간단한 URL 형식으로 요청.
2. **KVP(Key-Value Pair)**: 매개변수를 URL에 키-값 쌍으로 포함.
3. **SOAP(Simple Object Access Protocol)**: XML 기반의 복잡한 요청/응답 처리.

---

## 주요 작업

### 1. GetCapabilities
WMTS 서비스의 메타데이터를 반환하며, 서비스의 범위와 가능성을 설명합니다.

**요청 예시 (RESTful)**  
\```
GET https://example.com/wmts?SERVICE=WMTS&REQUEST=GetCapabilities
\```

**응답 예시 (XML)**  
\```
<Capabilities xmlns="http://www.opengis.net/wmts/1.0" version="1.0.0">
  <ServiceIdentification>
    <Title>Example WMTS Service</Title>
    <Abstract>Sample WMTS service for tiled map data</Abstract>
  </ServiceIdentification>
  <Contents>
    <Layer>
      <Title>Example Layer</Title>
      <Identifier>example_layer</Identifier>
      <TileMatrixSetLink>
        <TileMatrixSet>EPSG:3857</TileMatrixSet>
      </TileMatrixSetLink>
    </Layer>
  </Contents>
</Capabilities>
\```

---

### 2. GetTile
지정된 레이어, 타일맵, 행(Row), 열(Column)에 해당하는 타일 이미지를 반환합니다.

**요청 예시 (RESTful)**  
\```
GET https://example.com/wmts/example_layer/EPSG:3857/10/512/341.png
\```

**요청 예시 (KVP)**  
\```
GET https://example.com/wmts?SERVICE=WMTS&REQUEST=GetTile
    &LAYER=example_layer
    &TILEMATRIXSET=EPSG:3857
    &TILEMATRIX=10
    &TILEROW=512
    &TILECOL=341
    &FORMAT=image/png
\```

**응답 예시**  
- 반환 데이터는 PNG, JPEG 또는 WebP 형식의 타일 이미지입니다.

---

### 3. GetFeatureInfo (옵션)
특정 타일의 픽셀 위치에 해당하는 속성 데이터를 반환합니다.  
GetTile과 함께 사용하여 추가 정보를 요청할 수 있습니다.

**요청 예시 (RESTful)**  
\```
GET https://example.com/wmts/example_layer/EPSG:3857/10/512/341/featureinfo?I=100&J=100
\```

**요청 예시 (KVP)**  
\```
GET https://example.com/wmts?SERVICE=WMTS&REQUEST=GetFeatureInfo
    &LAYER=example_layer
    &TILEMATRIXSET=EPSG:3857
    &TILEMATRIX=10
    &TILEROW=512
    &TILECOL=341
    &I=100
    &J=100
\```

**응답 예시 (JSON)**  
\```
{
  "feature": {
    "id": "12345",
    "name": "Sample Feature",
    "value": "45.67"
  }
}
\```

---

### 4. GetLegendGraphic (옵션)
레이어에 대한 범례(Legend)를 반환합니다.

**요청 예시**  
\```
GET https://example.com/wmts?SERVICE=WMTS&REQUEST=GetLegendGraphic
    &LAYER=example_layer
    &FORMAT=image/png
\```

---

## 주요 특징
- **다양한 지원 형식**: PNG, JPEG, WebP, GeoTIFF 등.
- **확장성**: 여러 타일맵 및 좌표 체계 지원.
- **표준화된 접근 방식**: RESTful, KVP, SOAP을 통해 다양한 구현 시나리오 지원.

---

## 활용 사례
- **온라인 지도 서비스**: Google Maps, OpenStreetMap과 같은 대규모 지도 애플리케이션.
- **위성 이미지 제공**: 고정된 격자 시스템으로 위성 데이터를 분할 및 배포.
- **게임 개발 및 시뮬레이션**: 타일 기반 지형 데이터 활용.

---

## 결론
**WMTS**는 대규모 타일 기반 지도 데이터를 효율적으로 제공하기 위한 강력한 OGC 표준입니다.  
표준화된 요청 및 데이터 반환 방식을 통해 상호운용성을 보장하며, 다양한 GIS 및 웹 애플리케이션에서 핵심 역할을 수행합니다.
