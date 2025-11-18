FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    curl \
    && rm -rf /var/lib/apt/lists/*

ADD --chmod=755 https://astral.sh/uv/install.sh /install.sh
RUN /install.sh && rm /install.sh

COPY backend/requirements.txt .
RUN /root/.local/bin/uv pip install --system --no-cache-dir -r requirements.txt

# RUN --mount=source=dist,target=/dist PYTHONDONTWRITEBYTECODE=1 /root/.local/bin/uv pip install --no-cache-dir /dist/*.whl
RUN --mount=source=dist,target=/dist PYTHONDONTWRITEBYTECODE=1  pip install --no-cache-dir /dist/*.whl

COPY backend/ .

# CMD ["ls", "-lrt", "/app/artefacts"]
ENTRYPOINT ["python", "/app/app.py"]