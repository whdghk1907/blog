# Tile Map Service (TMS) 이해하기

## 소개
**Tile Map Service (TMS)**는 타일 형식의 지도 데이터를 웹을 통해 제공하는 서비스입니다.  
TMS는 OGC(Open Geospatial Consortium)의 표준은 아니지만, **OSGeo(Open Source Geospatial Foundation)**에서 널리 사용되는 타일 기반 지리정보 서비스 형식입니다.  
TMS는 지도를 고정된 격자로 나누어 타일(Tile)로 저장하고, 클라이언트가 필요한 타일만 요청하여 효율적으로 데이터를 전송합니다.

---

## 개요

### 1. 특징
- **고정된 격자 시스템**: 지도는 줌 레벨(Zoom Level)별로 고정된 크기의 타일(보통 256x256 픽셀)로 나뉩니다.
- **좌표 체계**: 일반적으로 EPSG:3857(WGS 84 Web Mercator) 좌표계를 사용합니다.
- **URL 기반 요청**: 클라이언트는 특정 줌 레벨, 행(row), 열(column)에 해당하는 타일을 URL을 통해 요청합니다.

---

## 구성 요소

### 1. 타일 구조
- TMS는 **줌 레벨**, **행(row)**, **열(column)** 정보를 기반으로 타일을 구성합니다.
- URL 형식:  
  \```
  https://example.com/tms/{zoom}/{x}/{y}.png
  \```

#### 주요 요소:
- **Zoom Level**: 지도 확대/축소 수준 (0 = 전체 지구).
- **X**: 타일의 열(Column) 번호.
- **Y**: 타일의 행(Row) 번호.

---

### 2. 좌표 체계 및 타일 계산
TMS는 타일 위치를 계산하기 위해 좌표를 픽셀 및 타일 단위로 변환합니다.

- 좌표 변환:  
  **WGS 84 경위도 좌표 → Web Mercator 좌표 → 타일 번호**
  
- 타일 계산 공식:
  - **X (Column)** = \(\lfloor 2^z \cdot \frac{\text{경도} + 180}{360} \rfloor\)
  - **Y (Row)** = \(\lfloor 2^z \cdot \frac{1 - \ln(\tan(\text{위도}) + \sec(\text{위도})) / \pi}{2} \rfloor\)

---

## 주요 작업

### 1. 타일 요청
타일 요청은 클라이언트가 특정 줌 레벨과 좌표에 해당하는 타일을 가져오는 방식으로 이루어집니다.

**요청 예시**  
\```
GET https://example.com/tms/10/512/341.png
\```

**응답 예시**  
- 반환된 데이터는 PNG, JPEG, 또는 WebP 형식의 이미지 파일입니다.

---

### 2. 메타데이터
TMS 서비스는 타일 구성에 대한 메타데이터를 제공합니다.  
**TileMapResource** XML은 타일의 범위, 크기, 좌표 체계 등을 설명합니다.

**요청 예시**  
\```
GET https://example.com/tms/TileMapResource.xml
\```

**응답 예시 (XML)**  
\```
<TileMap version="1.0.0" tilemapservice="http://example.com/tms">
  <Title>Example TMS</Title>
  <Abstract>Sample Tile Map Service</Abstract>
  <SRS>EPSG:3857</SRS>
  <BoundingBox minx="-20037508.34" miny="-20037508.34" maxx="20037508.34" maxy="20037508.34"/>
  <TileFormat width="256" height="256" mime-type="image/png" extension="png"/>
  <TileSets>
    <TileSet href="http://example.com/tms/0" units-per-pixel="156543.033928" order="0"/>
    <TileSet href="http://example.com/tms/1" units-per-pixel="78271.516964" order="1"/>
  </TileSets>
</TileMap>
\```

---

## 주요 특징
- **효율성**: 클라이언트는 필요한 타일만 요청하여 데이터를 전송받으므로 대규모 지도 데이터 전송에 적합합니다.
- **캐싱 가능**: 타일은 정적 파일로 저장되므로 클라이언트 또는 CDN(Content Delivery Network)에서 캐싱이 용이합니다.
- **오픈 소스 구현체**: OSGeo 프로젝트(예: GeoServer, MapServer) 및 기타 오픈소스 도구에서 지원합니다.

---

## 활용 사례
- **지도 애플리케이션**: 웹 기반 및 모바일 지도 서비스.
- **관광 및 지역 안내 서비스**: 특정 지역에 대한 상세 지도 제공.
- **게임 개발**: 타일 기반의 지형 및 맵 데이터 활용.

---

## 결론
TMS(Tile Map Service)는 지도 데이터를 효율적으로 제공하고, 클라이언트에서 빠르게 렌더링할 수 있도록 돕는 강력한 서비스입니다.  
타일 기반 구조는 대규모 데이터를 다루는 GIS 애플리케이션에서 중요한 역할을 하며, 다양한 오픈 소스 도구와 함께 널리 사용됩니다.
