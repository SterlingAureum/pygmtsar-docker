# ==========================================================
# PyGMTSAR Dockerized Environment - Multi-stage Build
# Maintainer: Sterling Aureum
# ==========================================================

# ---- Build Stage ----
FROM python:3.10-slim AS builder

WORKDIR /app

# 复制依赖文件
COPY requirements.txt .

# 安装系统依赖（只在构建阶段需要）
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    libssl-dev \
    libffi-dev \
    python3-dev \
    gmt gdal-bin libgdal-dev netcdf-bin cmake git wget curl \
    && rm -rf /var/lib/apt/lists/*

# 安装 Python 包
RUN pip install --no-cache-dir -r requirements.txt

# ---- Final Stage ----
FROM python:3.10-slim

WORKDIR /app

# 只拷贝 Python 包和必要的二进制文件
COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin

# 拷贝项目文件
COPY . .

# 容器启动默认命令
CMD ["python", "run_pygmtsar.py"]

