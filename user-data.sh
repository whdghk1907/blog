#!/bin/bash
apt-get update -y
apt-get install -y docker.io

# Docker 서비스 시작
systemctl start docker
systemctl enable docker

# ubuntu 사용자를 docker 그룹에 추가
usermod -aG docker ubuntu

# Docker Compose 설치
curl -L "https://github.com/docker/compose/releases/download/v2.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
chmod +x /usr/local/bin/docker-compose

# MLOps 데모 애플리케이션 실행
docker run -d \
  --name mlops-app \
  -p 80:80 \
  -p 8080:8080 \
  nginx:latest

# 간단한 웹 페이지 생성
mkdir -p /var/www/html
cat > /var/www/html/index.html << 'EOF'
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>MLOps Zoomcamp - 컨테이너 배포 완료</title>
    <style>
        body { 
            font-family: Arial, sans-serif; 
            text-align: center; 
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            margin: 0;
            padding: 50px;
        }
        .container {
            background: rgba(255,255,255,0.1);
            border-radius: 20px;
            padding: 40px;
            backdrop-filter: blur(10px);
        }
        h1 { color: #fff; margin-bottom: 30px; }
        .status { 
            background: #4CAF50; 
            padding: 20px; 
            border-radius: 10px; 
            margin: 20px 0;
            font-size: 18px;
        }
        .info { 
            background: rgba(255,255,255,0.2); 
            padding: 15px; 
            border-radius: 10px; 
            margin: 10px 0; 
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>🚀 MLOps Zoomcamp</h1>
        <div class="status">✅ 컨테이너 배포 성공!</div>
        <div class="info">
            <strong>서버 위치:</strong> AWS Seoul (ap-northeast-2)
        </div>
        <div class="info">
            <strong>인스턴스 타입:</strong> t2.large
        </div>
        <div class="info">
            <strong>운영체제:</strong> Ubuntu 22.04 LTS
        </div>
        <div class="info">
            <strong>컨테이너 엔진:</strong> Docker
        </div>
        <p>Docker 컨테이너가 성공적으로 실행중입니다! 🐳</p>
    </div>
</body>
</html>
EOF

# 커스텀 웹 페이지를 nginx 컨테이너에 마운트
docker cp /var/www/html/index.html mlops-app:/usr/share/nginx/html/index.html

# 로그 파일 생성
echo "MLOps Zoomcamp 컨테이너 배포 완료 - $(date)" > /var/log/mlops-deployment.log 