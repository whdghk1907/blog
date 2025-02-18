# WMS (Web Map Service)

**WMS (Web Map Service)**는 OGC(Open Geospatial Consortium) 표준 프로토콜 중 하나로, 웹(HTTPS)을 통해 지리 데이터를 지도 이미지로 시각화(Visualization)하는 서비스입니다.  
벡터 및 래스터 데이터를 다양한 레이어 형태로 제공하며, 분석 결과를 시각화하여 공유할 수 있습니다.

---

## 구성 요소

### 1. GetCapabilities *(필수)*  
WMS 서비스의 메타데이터를 반환합니다.  
- 기능 및 서비스 인자 정보, 이용 가능한 지도 레이어 목록, 좌표계 정보 등이 포함됩니다.  
- 클라이언트가 WMS를 활용하기 위한 초기 요청으로 사용됩니다.

**요청 예시**  
```
GET https://example.com/wms?service=WMS&request=GetCapabilities
```

**응답 예시 (XML)**  
```
<WMS_Capabilities version="1.3.0">
  <Service>
    <Name>WMS</Name>
    <Title>Example WMS Service</Title>
    <Abstract>This is a sample WMS service.</Abstract>
  </Service>
  <Capability>
    <Layer>
      <Name>example_layer</Name>
      <Title>Example Layer</Title>
      <CRS>EPSG:4326</CRS>
    </Layer>
  </Capability>
</WMS_Capabilities>
```

---

### 2. GetMap *(필수)*  
요청된 파라미터에 따라 지도 이미지를 생성하여 반환합니다.  
- 이미지 포맷(JPEG, PNG 등), 좌표계(SRS/CRS), 범위(BBOX), 해상도 등을 인자로 받습니다.

**요청 예시**  
```
GET https://example.com/wms?service=WMS&request=GetMap
    &layers=example_layer
    &bbox=-180,-90,180,90
    &width=256
    &height=256
    &srs=EPSG:4326
    &format=image/png
```

**응답 예시 (이미지)**  
PNG 이미지가 반환됩니다.

---

### 3. GetFeatureInfo *(옵션)*  
GetMap 요청으로 생성된 지도 이미지에서 특정 지점의 속성(feature) 정보를 제공합니다.  
- 일반적으로 마우스 클릭 등 사용자 상호작용을 통해 호출됩니다.

**요청 예시**  
```
GET https://example.com/wms?service=WMS&request=GetFeatureInfo
    &query_layers=example_layer
    &x=128
    &y=128
    &info_format=text/html
    &bbox=-180,-90,180,90
    &width=256
    &height=256
    &srs=EPSG:4326
```

**응답 예시 (HTML)**  
```
<html>
  <body>
    <h1>Feature Info</h1>
    <p>Layer: example_layer</p>
    <p>Attribute: Value</p>
  </body>
</html>
```

---

### 4. DescribeLayer *(옵션)*  
특정 레이어의 속성과 데이터 소스에 대한 자세한 설명을 제공합니다.  
- 레이어의 구조와 데이터 유형 정보를 확인할 때 유용합니다.

**요청 예시**  
```
GET https://example.com/wms?service=WMS&request=DescribeLayer
    &layers=example_layer
```

**응답 예시 (XML)**  
```
<DescribeLayerResponse version="1.1.1">
  <LayerDescription name="example_layer">
    <Type>WFS</Type>
    <URL>https://example.com/wfs</URL>
  </LayerDescription>
</DescribeLayerResponse>
```

---

### 5. GetLegendGraphic *(옵션)*  
요청된 레이어에 대한 범례(Legend) 이미지를 반환합니다.  
- 주로 사용자가 데이터 시각화를 이해하는 데 도움을 줍니다.

**요청 예시**  
```
GET https://example.com/wms?service=WMS&request=GetLegendGraphic
    &layer=example_layer
    &format=image/png
```

**응답 예시 (이미지)**  
PNG 범례 이미지가 반환됩니다.

---

## 주요 특징
- **표준화된 프로토콜**: 다양한 클라이언트(예: GIS 소프트웨어)와 호환 가능.
- **다양한 포맷 지원**: 지도 이미지를 PNG, JPEG, GIF 등 다양한 형식으로 제공.
- **유연한 데이터 제공**: 단일 레이어 또는 여러 레이어를 조합한 데이터를 제공.

---

## 활용 사례
- 실시간 날씨 지도 제공
- 환경 모니터링 데이터 시각화
- 도시 개발 및 관리 계획 수립 지원
