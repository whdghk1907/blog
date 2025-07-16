# Python-ML - Python 머신러닝 도구 가이드

Python을 활용한 머신러닝 개발을 위한 핵심 도구들의 설치, 설정, 활용 가이드입니다.

## 🛠️ 핵심 라이브러리

### 데이터 처리
- **pandas**: 데이터 조작 및 분석
- **numpy**: 수치 계산 및 배열 처리
- **scipy**: 과학적 계산 및 통계

### 머신러닝
- **scikit-learn**: 범용 머신러닝 라이브러리
- **xgboost**: 그래디언트 부스팅 프레임워크
- **lightgbm**: 효율적인 그래디언트 부스팅

### 시각화
- **matplotlib**: 기본 그래프 및 차트
- **seaborn**: 통계적 시각화
- **plotly**: 인터랙티브 시각화

### 모델 해석
- **shap**: 모델 설명 및 해석
- **lime**: 국소적 모델 해석
- **yellowbrick**: 시각적 모델 분석

## 📦 환경 설정

### 가상환경 생성
```bash
# conda 환경 생성
conda create -n ml-env python=3.9
conda activate ml-env

# 또는 venv 사용
python -m venv ml-env
source ml-env/bin/activate  # Linux/Mac
ml-env\Scripts\activate     # Windows
```

### 패키지 설치
```bash
# 기본 패키지 설치
pip install pandas numpy scipy matplotlib seaborn

# 머신러닝 라이브러리
pip install scikit-learn xgboost lightgbm

# 모델 해석 도구
pip install shap lime yellowbrick

# 개발 도구
pip install jupyter notebook ipython
```

## 🚀 빠른 시작 가이드

### 데이터 로드 및 전처리
```python
import pandas as pd
import numpy as np
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import train_test_split

# 데이터 로드
df = pd.read_csv('data.csv')

# 기본 정보 확인
print(df.info())
print(df.describe())

# 결측치 처리
df_clean = df.dropna()

# 특성과 타겟 분리
X = df_clean.drop('target', axis=1)
y = df_clean['target']

# 학습/테스트 데이터 분할
X_train, X_test, y_train, y_test = train_test_split(
    X, y, test_size=0.2, random_state=42
)

# 스케일링
scaler = StandardScaler()
X_train_scaled = scaler.fit_transform(X_train)
X_test_scaled = scaler.transform(X_test)
```

### 모델 학습 및 평가
```python
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import accuracy_score, classification_report

# 모델 학습
model = RandomForestClassifier(n_estimators=100, random_state=42)
model.fit(X_train_scaled, y_train)

# 예측
y_pred = model.predict(X_test_scaled)

# 평가
accuracy = accuracy_score(y_test, y_pred)
print(f"정확도: {accuracy:.4f}")
print("\n분류 보고서:")
print(classification_report(y_test, y_pred))
```

### 모델 해석
```python
import shap
import matplotlib.pyplot as plt

# SHAP 값 계산
explainer = shap.TreeExplainer(model)
shap_values = explainer.shap_values(X_test_scaled)

# 특성 중요도 시각화
shap.summary_plot(shap_values, X_test)
plt.show()

# 개별 예측 설명
shap.waterfall_plot(
    shap.Explanation(values=shap_values[0], 
                     base_values=explainer.expected_value, 
                     data=X_test_scaled[0])
)
```

## 📊 시각화 예제

### 데이터 탐색
```python
import seaborn as sns
import matplotlib.pyplot as plt

# 상관관계 히트맵
plt.figure(figsize=(10, 8))
sns.heatmap(df.corr(), annot=True, cmap='coolwarm', center=0)
plt.title('특성 간 상관관계')
plt.show()

# 분포 시각화
plt.figure(figsize=(12, 4))
for i, col in enumerate(X.columns[:3]):
    plt.subplot(1, 3, i+1)
    sns.histplot(df[col], kde=True)
    plt.title(f'{col} 분포')
plt.tight_layout()
plt.show()
```

### 모델 성능 시각화
```python
from sklearn.metrics import confusion_matrix
from yellowbrick.classifier import ConfusionMatrix

# 혼동 행렬
cm = ConfusionMatrix(model, classes=['Class 0', 'Class 1'])
cm.fit(X_train_scaled, y_train)
cm.score(X_test_scaled, y_test)
cm.show()
```

## 🔧 유용한 코드 스니펫

### 모델 비교
```python
from sklearn.ensemble import RandomForestClassifier
from sklearn.svm import SVC
from sklearn.linear_model import LogisticRegression
from sklearn.metrics import accuracy_score

models = {
    'Random Forest': RandomForestClassifier(n_estimators=100),
    'SVM': SVC(kernel='rbf'),
    'Logistic Regression': LogisticRegression()
}

results = {}
for name, model in models.items():
    model.fit(X_train_scaled, y_train)
    y_pred = model.predict(X_test_scaled)
    accuracy = accuracy_score(y_test, y_pred)
    results[name] = accuracy
    print(f"{name}: {accuracy:.4f}")
```

### 교차 검증
```python
from sklearn.model_selection import cross_val_score

# 5-fold 교차 검증
cv_scores = cross_val_score(model, X_train_scaled, y_train, cv=5)
print(f"교차 검증 점수: {cv_scores}")
print(f"평균 점수: {cv_scores.mean():.4f} (+/- {cv_scores.std() * 2:.4f})")
```

## 🚨 일반적인 문제 해결

### 메모리 부족
```python
# 청크 단위로 데이터 처리
chunk_size = 10000
for chunk in pd.read_csv('large_file.csv', chunksize=chunk_size):
    process_chunk(chunk)

# 데이터 타입 최적화
df = df.astype({'col1': 'int32', 'col2': 'float32'})
```

### 과적합 방지
```python
from sklearn.ensemble import RandomForestClassifier

# 정규화 및 제약 조건 적용
model = RandomForestClassifier(
    n_estimators=100,
    max_depth=10,
    min_samples_split=5,
    min_samples_leaf=2,
    random_state=42
)
```

## 🔗 추가 자료

### 공식 문서
- [scikit-learn 공식 문서](https://scikit-learn.org/stable/)
- [pandas 공식 문서](https://pandas.pydata.org/docs/)
- [matplotlib 공식 문서](https://matplotlib.org/stable/contents.html)

### 튜토리얼 및 예제
- [scikit-learn 튜토리얼](https://scikit-learn.org/stable/tutorial/index.html)
- [Kaggle Learn](https://www.kaggle.com/learn)
- [Real Python ML 튜토리얼](https://realpython.com/tutorials/machine-learning/) 