
## 📌 개요
GIS 데이터는 일반적인 관계형 데이터와 다르게 공간 정보를 포함해야 합니다. GISuite에서는 **Spring Data JPA와 PostGIS를 활용한 저장소(Repository) 계층**을 구현하여 효율적인 공간 검색 기능을 제공합니다.

이 문서에서는 `GisRepository`를 정의하고, 공간 검색을 위한 `@Query` 활용법 및 PostGIS와 JPA를 최적화하는 방법을 설명합니다.

---

## 🏗️ 1. `GisRepository` 구현 (Spring Data JPA)
JPA를 활용하여 GIS 데이터를 저장하고 조회하는 기본 Repository 인터페이스를 작성합니다.

```java
package com.gisuite.repository;

import com.gisuite.entity.GisEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface GisRepository extends JpaRepository<GisEntity, Long> {

    // 특정 좌표 내의 데이터를 검색 (공간 검색 활용)
    @Query("SELECT g FROM GisEntity g WHERE ST_Contains(g.geometry, ST_GeomFromText(:wkt, 4326)) = true")
    List<GisEntity> findWithinGeometry(String wkt);
}
```

### 🔹 주요 기능
- **기본 CRUD 기능 제공 (`JpaRepository` 활용)**
- **공간 검색 쿼리 지원 (`ST_Contains` 활용하여 특정 영역 내 객체 검색)**
- **PostGIS의 `ST_GeomFromText`를 사용하여 WKT(Well-Known Text) 형식으로 공간 데이터를 변환하여 활용**

---

## 📌 2. PostGIS와 JPA를 함께 사용하는 최적화 방법
PostGIS 데이터를 JPA로 다룰 때 성능을 향상시키기 위해 몇 가지 최적화 기법을 적용할 수 있습니다.

### ✅ **1. GIST 공간 인덱스 추가**
PostGIS에서 공간 검색을 빠르게 수행하려면 **공간 인덱스(Spatial Index)**를 추가해야 합니다.
```sql
CREATE INDEX gis_data_gix ON gis_data USING GIST (geometry);
```
이렇게 하면 공간 쿼리 실행 속도가 크게 향상됩니다.

### ✅ **2. 복잡한 공간 연산을 SQL에서 처리**
JPA에서 공간 데이터를 다룰 때 **Hibernate가 모든 연산을 처리하는 것이 아니라, 데이터베이스의 공간 함수**를 직접 활용하는 것이 좋습니다.
```java
@Query("SELECT g FROM GisEntity g WHERE ST_DWithin(g.geometry, ST_GeomFromText(:wkt, 4326), :distance) = true")
List<GisEntity> findWithinDistance(String wkt, double distance);
```
위 코드에서는 **`ST_DWithin` 함수**를 활용하여 특정 거리 내의 데이터를 검색하는 최적화된 공간 쿼리를 수행할 수 있습니다.

### ✅ **3. 필요한 데이터만 가져오기 (Projection 활용)**
공간 데이터는 무겁기 때문에, 필요하지 않은 필드를 가져오지 않도록 Projection을 활용할 수 있습니다.
```java
@Query("SELECT g.id, g.name FROM GisEntity g WHERE ST_Contains(g.geometry, ST_GeomFromText(:wkt, 4326)) = true")
List<Object[]> findNamesWithinGeometry(String wkt);
```
이렇게 하면 **공간 데이터(geometry) 필드를 불러오지 않고 경량 쿼리 실행이 가능**합니다.

---

## 🎯 **마무리 및 다음 단계**
이제 `GisRepository`를 활용하여 PostGIS 기반 GIS 데이터를 저장하고 검색하는 방법을 이해했습니다.

✅ **다음 단계:** GIS 데이터를 처리하는 **비즈니스 로직(Service 계층) 구현** 🚀
