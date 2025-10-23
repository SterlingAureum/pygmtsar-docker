# ==========================================================
# 🐳 PyGMTSAR Dockerized Environment
# Maintainer: Sterling Aureum
# ==========================================================

# 1️⃣ 基础镜像：轻量 Python 3.10
FROM python:3.10-slim

LABEL maintainer="Sterling Aureum"
LABEL description="Dockerized PyGMTSAR environment with multi-arch build support"
LABEL org.opencontainers.image.source="https://github.com/<your_github_username>/pygmtsar-docker"

# 2️⃣ 安装系统依赖（GDAL、GMT、编译工具）
RUN apt-get update && apt-get install -y --no-install-recommends \
    gmt gdal-bin libgdal-dev netcdf-bin cmake git wget curl build-essential \
    && rm -rf /var/lib/apt/lists/*

# 3️⃣ 设置工作目录
WORKDIR /app

# 4️⃣ 拷贝 requirements.txt 并安装 Python 依赖
COPY requirements.txt /app/requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

# 5️⃣ 拷贝示例脚本（可选）
COPY run_pygmtsar.py /app/run_pygmtsar.py

# 6️⃣ 容器启动默认命令：验证 PyGMTSAR 是否可用
CMD ["python", "-c", "import pygmtsar; print('✅ PyGMTSAR loaded successfully! Version:', pygmtsar.__version__)"]

