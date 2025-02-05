

## 📌 개요
GIS 데이터는 단순한 속성 데이터가 아니라 공간 정보를 포함해야 합니다. GISuite에서는 **OGC 표준을 준수하는 JPA 엔티티**를 사용하여 PostGIS와 연동합니다. 
이 문서에서는 `GisEntity`를 설계하고, PostGIS의 `Geometry` 타입을 활용하여 공간 데이터를 효율적으로 저장하는 방법을 설명합니다.

---

## 🏗️ 1. `GisEntity` 설계
Spring Data JPA와 Hibernate Spatial을 활용하여 GIS 데이터를 저장하는 `GisEntity`를 설계합니다.

```java
package com.gisuite.entity;

import jakarta.persistence.*;
import org.locationtech.jts.geom.Geometry;

@Entity
@Table(name = "gis_data")
public class GisEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(nullable = false)
    private String name;

    @Column(columnDefinition = "Geometry")
    private Geometry geometry;

    public GisEntity() {
    }

    public GisEntity(String name, Geometry geometry) {
        this.name = name;
        this.geometry = geometry;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Geometry getGeometry() {
        return geometry;
    }

    public void setGeometry(Geometry geometry) {
        this.geometry = geometry;
    }
}
```

### 🔹 주요 필드 설명
- **`@Entity` & `@Table(name = "gis_data")`** → 데이터베이스의 `gis_data` 테이블과 매핑
- **`@Id @GeneratedValue(strategy = GenerationType.IDENTITY)`** → 기본 키 자동 생성
- **`@Column(nullable = false)`** → `name` 필드는 반드시 값이 있어야 함
- **`@Column(columnDefinition = "Geometry")`** → 공간 데이터를 저장하는 `geometry` 필드

---

## 📌 2. PostGIS 연동을 위한 Hibernate 설정
Hibernate가 PostGIS의 `Geometry` 타입을 인식하도록 `application.yml`에 다음 설정을 추가합니다.

```yaml
spring:
  jpa:
    database-platform: org.hibernate.spatial.dialect.postgis.PostgisDialect
    hibernate:
      ddl-auto: update
    show-sql: true
    properties:
      hibernate:
        format_sql: true
```

### 🔹 설정 설명
- **`database-platform: org.hibernate.spatial.dialect.postgis.PostgisDialect`** → PostGIS 지원을 위한 Hibernate 설정
- **`ddl-auto: update`** → 테이블 구조 자동 생성 (운영 환경에서는 `validate` 또는 `none` 추천)
- **`show-sql: true`** → SQL 쿼리 출력 활성화

---

## 📌 3. 공간 데이터를 효율적으로 저장하는 방법
PostGIS는 GIS 데이터를 효율적으로 저장하기 위해 **공간 인덱스(Spatial Index)**를 사용할 수 있습니다.
데이터베이스에서 `geometry` 필드를 효율적으로 검색하기 위해 다음 쿼리를 실행하여 인덱스를 생성합니다.

```sql
CREATE INDEX gis_data_gix ON gis_data USING GIST (geometry);
```

이렇게 하면 **공간 검색 성능이 향상**되며, 복잡한 지리 정보 쿼리도 빠르게 실행할 수 있습니다.

---

## 🎯 **마무리 및 다음 단계**
이제 `GisEntity`를 정의하고 PostGIS와 연동하는 방법을 알게 되었습니다. 

✅ **다음 단계:** GIS 데이터를 관리하는 **JPA Repository 및 공간 검색 기능 구현** 🚀