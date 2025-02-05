
## 📌 개요
GIS 데이터는 단순한 속성 데이터뿐만 아니라 **공간 데이터 처리 및 연산이 필요한 비즈니스 로직**을 포함해야 합니다. 
GISuite에서는 `GisService`를 통해 **CRUD 기능을 구현하고, 트랜잭션을 관리하며, GIS 관련 연산을 수행**합니다.

이 문서에서는 `GisService`를 구현하고 GIS 관련 비즈니스 로직을 다루는 방법을 설명합니다.

---

## 🏗️ 1. `GisService` 구현 (GIS 데이터 CRUD 기능)
Spring의 `@Service`를 활용하여 GIS 데이터를 저장하고 조회하는 서비스 계층을 작성합니다.

```java
package com.gisuite.service;

import com.gisuite.entity.GisEntity;
import com.gisuite.repository.GisRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;
import java.util.Optional;

@Service
public class GisService {

    private final GisRepository gisRepository;

    public GisService(GisRepository gisRepository) {
        this.gisRepository = gisRepository;
    }

    public List<GisEntity> getAllGisData() {
        return gisRepository.findAll();
    }

    public Optional<GisEntity> getGisDataById(Long id) {
        return gisRepository.findById(id);
    }

    @Transactional
    public GisEntity saveGisData(GisEntity gisEntity) {
        return gisRepository.save(gisEntity);
    }

    @Transactional
    public void deleteGisData(Long id) {
        gisRepository.deleteById(id);
    }
}
```

### 🔹 주요 기능
- **CRUD 기능 제공** (`findAll`, `findById`, `save`, `deleteById`)
- **트랜잭션 관리 (`@Transactional`)** → 데이터 저장 및 삭제 시 일관성을 유지
- **JPA 기반의 GIS 데이터 접근 로직 분리** → `repository` 계층과 분리하여 서비스 계층에서 관리

---

## 📌 2. GIS 관련 비즈니스 로직 예제
GIS 데이터를 단순히 저장하는 것이 아니라 **공간 검색 및 분석 기능을 포함하는 예제**를 추가합니다.

### ✅ **1. 특정 좌표 내 GIS 데이터 검색**
```java
public List<GisEntity> findWithinGeometry(String wkt) {
    return gisRepository.findWithinGeometry(wkt);
}
```
- `ST_Contains`를 활용하여 **특정 좌표(WKT 형식) 내 GIS 데이터 검색**

### ✅ **2. 특정 거리 내 GIS 데이터 검색**
```java
public List<GisEntity> findWithinDistance(String wkt, double distance) {
    return gisRepository.findWithinDistance(wkt, distance);
}
```
- `ST_DWithin`을 활용하여 **지정된 거리 내의 GIS 데이터 검색**

### ✅ **3. 공간 데이터의 속성 정보만 가져오기**
```java
public List<Object[]> findNamesWithinGeometry(String wkt) {
    return gisRepository.findNamesWithinGeometry(wkt);
}
```
- 공간 데이터 전체가 아닌 **필요한 속성만 조회하여 쿼리 성능 최적화**

---

## 🎯 **마무리 및 다음 단계**
이제 `GisService`를 활용하여 GIS 데이터를 관리하고 공간 검색 기능을 수행하는 방법을 이해했습니다.

✅ **다음 단계:** REST API를 제공하는 **Controller 계층 구현** 🚀
