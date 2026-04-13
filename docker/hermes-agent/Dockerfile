FROM python:3.11-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl git \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/outsourc-e/hermes-agent.git /app

WORKDIR /app

RUN pip install --no-cache-dir -e .

# Patch: don't pop OPENAI_API_KEY/BASE_URL before provider resolution
# This breaks local providers (llamacpp, ollama, lmstudio) because the
# resolver can't find credentials during the popped window.
RUN sed -i 's/_stale_oai_key = os.environ.pop("OPENAI_API_KEY", None)/_stale_oai_key = None  # patched for local providers/' \
    /app/gateway/platforms/api_server.py && \
    sed -i 's/_stale_oai_base = os.environ.pop("OPENAI_BASE_URL", None)/_stale_oai_base = None  # patched for local providers/' \
    /app/gateway/platforms/api_server.py

EXPOSE 8642

CMD ["hermes", "gateway", "run"]
