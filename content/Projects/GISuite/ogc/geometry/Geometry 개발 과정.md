
## 🚀 들어가며
GIS 데이터를 다룰 때 **OGC(Open Geospatial Consortium) 표준**을 준수하는 것은 매우 중요합니다.  
OGC 표준에는 **ISO 19103 (Geographic Information – Conceptual Schema Language)** 같은 핵심적인 개념이 포함되어 있으며,  
이를 Java에서 활용할 수 있도록 매핑하는 것이 GISuite의 **유틸리티 패키지 (`com.gisuite.util`)**의 역할입니다.

이번 포스팅에서는 **GISuite의 유틸리티 패키지를 개발한 과정**을 공유하며,  
어떤 개념을 Java에서 구현했는지 자세히 설명합니다.

---

## 📂 1️⃣ 유틸리티 패키지의 역할
📌 **OGC 표준의 ISO 19103에서는 다음과 같은 데이터 타입을 정의합니다.**  
- **Primitive Types (기본 타입)**: 정수, 실수, 문자열 등  
- **Collection Types (컬렉션 타입)**: 리스트, 맵, 세트 등  
- **Enumerated Types (열거형 타입)**: 미리 정의된 코드 값  
- **Derived Types (파생 타입)**: 측정 단위 변환 및 복합 타입  
- **Name Types (이름 타입)**: 객체 식별을 위한 네임스페이스  
- **Code List (코드 리스트)**: 확장 가능한 코드 값  

💡 **이러한 개념을 Java에서 활용할 수 있도록 GISuite의 유틸리티 패키지를 개발했습니다.**

---

## 🔧 2️⃣ 유틸리티 패키지 설계 및 구현

### **📌 1. 기본 타입 변환 (`PrimitiveTypes.java`)**
```java
package com.gisuite.util;

import java.math.BigDecimal;
import java.util.Date;

/**
 * ISO 19103에서 정의된 기본 타입을 Java 기본 타입으로 매핑.
 */
public class PrimitiveTypes {
    public static Integer asInteger(int value) { return value; }
    public static Double asDouble(double value) { return value; }
    public static BigDecimal asDecimal(double value) { return BigDecimal.valueOf(value); }
    public static Boolean asBoolean(boolean value) { return value; }
    public static Date asDate(long timestamp) { return new Date(timestamp); }
}
```

---

### **📌 2. 컬렉션 타입 매핑 (`CollectionTypes.java`)**
```java
package com.gisuite.util;

import java.util.*;

/**
 * ISO 19103에서 정의된 컬렉션 타입을 Java 표준 컬렉션으로 매핑.
 */
public class CollectionTypes {
    public static <T> Collection<T> asCollection(List<T> list) {
        return new ArrayList<>(list);
    }

    public static <T> Set<T> asSet(List<T> list) {
        return new HashSet<>(list);
    }

    public static <K, V> Map<K, V> asDictionary(Map<K, V> map) {
        return new HashMap<>(map);
    }
}
```

---

### **📌 3. 열거형 타입 매핑 (`EnumeratedTypes.java`)**
```java
package com.gisuite.util;

/**
 * ISO 19103에서 정의된 열거형 타입을 Java Enum으로 매핑.
 */
public enum EnumeratedTypes {
    TRUE, FALSE, UNKNOWN;

    public static EnumeratedTypes fromBoolean(Boolean value) {
        if (value == null) return UNKNOWN;
        return value ? TRUE : FALSE;
    }
}
```

---

### **📌 4. 이름 타입 매핑 (`NameTypes.java`)**
```java
package com.gisuite.util;

/**
 * ISO 19103에서 정의된 이름(Name) 타입을 Java String 기반으로 매핑.
 */
public class NameTypes {
    private final String name;
    private final String namespace;

    public NameTypes(String namespace, String name) {
        this.namespace = namespace;
        this.name = name;
    }

    public String getFullName() {
        return namespace + ":" + name;
    }

    public String getLocalName() {
        return name;
    }

    public String getNamespace() {
        return namespace;
    }
}
```

---

### **📌 5. 코드 리스트 (`CodeList.java`)**
```java
package com.gisuite.util;

import java.util.HashMap;
import java.util.Map;

/**
 * ISO 19103의 CodeList를 구현.
 */
public class CodeList<T extends CodeList<T>> {
    private static final Map<String, CodeList<?>> VALUES = new HashMap<>();
    private final String name;

    protected CodeList(String name) {
        this.name = name;
        VALUES.put(name, this);
    }

    public String getName() {
        return name;
    }

    @SuppressWarnings("unchecked")
    public static <T extends CodeList<T>> T valueOf(String name, Class<T> type) {
        return (T) VALUES.computeIfAbsent(name, k -> {
            try {
                return type.getConstructor(String.class).newInstance(name);
            } catch (Exception e) {
                throw new IllegalArgumentException("Invalid CodeList name: " + name);
            }
        });
    }
}
```

---

## 📈 3️⃣ GISuite의 유틸리티 패키지가 가져온 개선점
📌 **✅ OGC 표준을 준수하는 데이터 타입 매핑**  
- Primitive, Collection, Enumerated Types를 Java 표준으로 매핑하여 **OGC 표준과의 호환성 강화**  

📌 **✅ GIS 데이터 처리 성능 향상**  
- `CollectionTypes` 및 `CodeList`를 활용하여 **데이터 조회 및 변환 성능 최적화**  

📌 **✅ 유지보수 및 확장성 향상**  
- 기존 Java 코드와 자연스럽게 통합되면서도, **OGC 표준을 쉽게 확장 가능**  

---

## 🎯 4️⃣ 결론 및 향후 개선 방향
GISuite의 유틸리티 패키지는 **OGC 표준을 준수하면서도, GIS 데이터를 Java 환경에서 다루기 쉽게 설계**되었습니다.  
**GIS 데이터 변환 및 컬렉션 관리가 효율적으로 개선**되었으며, 향후 다음과 같은 기능을 추가할 예정입니다.

📌 **향후 추가할 기능**
1. **국제화(i18n) 지원 개선** → `InternationalString`을 확장하여 다국어 지원 기능 강화  
2. **단위 변환 시스템 추가** → JSR-363 (Units and Measures) 표준과 통합  
3. **OGC CodeList 자동 매핑** → WKT 및 EPSG 코드와의 연계 기능 강화  

GISuite는 **OGC 표준을 기반으로 GIS 데이터를 다루는 최고의 프레임워크**를 목표로 합니다! 🚀  
더 나은 기능을 위해 지속적으로 발전시켜 나가겠습니다. 😊
