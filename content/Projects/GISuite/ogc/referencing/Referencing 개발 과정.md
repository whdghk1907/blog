## 🚀 들어가며
GIS 데이터를 다룰 때 **OGC(Open Geospatial Consortium) 표준**을 준수하는 것은 매우 중요합니다.  
그중에서도 **ISO 19111 (Spatial Referencing by Coordinates)** 표준은  
GIS에서 좌표 시스템을 정의하고, 변환하는 방식을 규정하고 있습니다.

GISuite 프로젝트에서는 **ISO 19111 표준을 준수하는 좌표 참조 패키지 (`com.gisuite.referencing`)** 를 개발하였습니다.  
이번 포스팅에서는 GISuite의 좌표 참조 패키지를 설계하고 구현한 과정을 소개합니다.  

---

## 📂 1️⃣ 좌표 참조 패키지의 역할
GIS 데이터는 **다양한 좌표 체계(CRS, Coordinate Reference System)에서 정의**될 수 있습니다.  
OGC 표준에서는 이러한 좌표 체계를 정의하기 위해 **ISO 19111**을 규정하고 있으며,  
GISuite에서는 이를 **Java에서 활용할 수 있도록 좌표 참조 패키지를 설계**하였습니다.

📌 **GIS 좌표 참조에서 필수적으로 포함되어야 하는 정보**
1. **좌표 참조 시스템(Coordinate Reference System, CRS)**
2. **좌표 시스템(Coordinate System, CS)**
3. **기준 데이터(Datum)**
4. **타원체(Ellipsoid)**
5. **본초 자오선(Prime Meridian)**

💡 GISuite의 좌표 참조 패키지는 **OGC 표준을 준수하는 좌표 시스템을 Java에서 쉽게 활용할 수 있도록 설계**되었습니다.

---

## 🔧 2️⃣ 좌표 참조 패키지 설계 및 구현

### **📌 1. 좌표 참조 시스템 클래스 (`CoordinateReferenceSystem.java`)**
```java
package com.gisuite.referencing;

/**
 * ISO 19111 기반의 좌표 참조 시스템 (CRS).
 * 좌표 데이터를 특정 참조 시스템으로 정의하는 역할을 수행.
 */
public class CoordinateReferenceSystem {
    private final String name;
    private final CoordinateSystem coordinateSystem;
    private final Datum datum;

    public CoordinateReferenceSystem(String name, CoordinateSystem coordinateSystem, Datum datum) {
        this.name = name;
        this.coordinateSystem = coordinateSystem;
        this.datum = datum;
    }

    public String getName() { return name; }
    public CoordinateSystem getCoordinateSystem() { return coordinateSystem; }
    public Datum getDatum() { return datum; }
}
```

---

### **📌 2. 좌표 시스템 (`CoordinateSystem.java`)**
```java
package com.gisuite.referencing;

/**
 * ISO 19111 기반의 좌표 시스템 (Coordinate System).
 * 특정 차원과 축을 정의하는 역할.
 */
public class CoordinateSystem {
    private final int dimension;
    private final String[] axisNames;

    public CoordinateSystem(int dimension, String... axisNames) {
        if (axisNames.length != dimension) {
            throw new IllegalArgumentException("축 개수와 차원이 일치해야 합니다.");
        }
        this.dimension = dimension;
        this.axisNames = axisNames.clone();
    }

    public int getDimension() { return dimension; }
    public String[] getAxisNames() { return axisNames.clone(); }
}
```

---

### **📌 3. 기준 데이터 (`Datum.java`)**
```java
package com.gisuite.referencing;

/**
 * ISO 19111 기반의 Datum (기준).
 * 좌표 참조 시스템의 기준점 및 참조 프레임 정의.
 */
public class Datum {
    private final String name;
    private final Ellipsoid ellipsoid;
    private final PrimeMeridian primeMeridian;

    public Datum(String name, Ellipsoid ellipsoid, PrimeMeridian primeMeridian) {
        this.name = name;
        this.ellipsoid = ellipsoid;
        this.primeMeridian = primeMeridian;
    }

    public String getName() { return name; }
    public Ellipsoid getEllipsoid() { return ellipsoid; }
    public PrimeMeridian getPrimeMeridian() { return primeMeridian; }
}
```

---

### **📌 4. 타원체 정보 (`Ellipsoid.java`)**
```java
package com.gisuite.referencing;

/**
 * ISO 19111 기반의 타원체 (Ellipsoid).
 * 지구의 형상을 근사적으로 표현하는 모델.
 */
public class Ellipsoid {
    private final String name;
    private final double semiMajorAxis;
    private final double semiMinorAxis;
    private final double inverseFlattening;

    public Ellipsoid(String name, double semiMajorAxis, double semiMinorAxis) {
        this.name = name;
        this.semiMajorAxis = semiMajorAxis;
        this.semiMinorAxis = semiMinorAxis;
        this.inverseFlattening = semiMajorAxis / (semiMajorAxis - semiMinorAxis);
    }

    public String getName() { return name; }
    public double getSemiMajorAxis() { return semiMajorAxis; }
    public double getSemiMinorAxis() { return semiMinorAxis; }
    public double getInverseFlattening() { return inverseFlattening; }
}
```

---

### **📌 5. 본초 자오선 (`PrimeMeridian.java`)**
```java
package com.gisuite.referencing;

/**
 * ISO 19111 기반의 본초 자오선 (Prime Meridian).
 * 경도의 기준점을 정의.
 */
public class PrimeMeridian {
    private final String name;
    private final double longitude;

    public PrimeMeridian(String name, double longitude) {
        this.name = name;
        this.longitude = longitude;
    }

    public String getName() { return name; }
    public double getLongitude() { return longitude; }
}
```

---

## 📈 3️⃣ GISuite의 좌표 참조 패키지가 가져온 개선점
📌 **✅ OGC 표준을 준수하는 좌표 시스템 모델 구축**  
- ISO 19111을 준수하여 **GIS 좌표 시스템을 일관된 구조로 유지**  

📌 **✅ 좌표 시스템과 기준 데이터를 분리하여 모듈화**  
- `CoordinateSystem`, `Datum`, `Ellipsoid`를 독립적인 객체로 정의하여 **재사용 가능성 증가**  

📌 **✅ 향후 확장 가능성 증가**  
- 향후 **지리 좌표 시스템(GeographicCRS), 투영 좌표 시스템(ProjectedCRS) 등을 추가 가능**  

---

## 🎯 4️⃣ 결론 및 향후 개선 방향
GISuite의 좌표 참조 패키지는 **ISO 19111 표준을 충실히 준수하면서도, GIS 좌표 데이터를 Java 환경에서 다룰 수 있도록 설계**되었습니다.  
향후 다음과 같은 기능을 추가하여 더 강력한 GIS 좌표 참조 시스템을 구축할 예정입니다.

📌 **향후 추가할 기능**
6. **지리 좌표 시스템(GeographicCRS) 및 투영 좌표 시스템(ProjectedCRS) 추가**  
7. **좌표 변환 기능 추가** → OGC 표준을 따르는 좌표 변환 연산(`MathTransform`, `AffineTransform`) 추가  
8. **OGC WKT(Well-Known Text) 지원** → WKT 포맷을 기반으로 좌표 참조 시스템을 직렬화/역직렬화  

GISuite는 **OGC 표준을 기반으로 GIS 데이터를 다루는 최고의 프레임워크**를 목표로 합니다! 🚀  
더 나은 기능을 위해 지속적으로 발전시켜 나가겠습니다. 😊
