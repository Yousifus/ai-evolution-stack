FROM python:3.11-slim

RUN apt-get update \
    && apt-get install -y --no-install-recommends curl git \
    && rm -rf /var/lib/apt/lists/*

# Install Node.js 22 for npx-based MCP servers
RUN curl -fsSL https://deb.nodesource.com/setup_22.x | bash - \
    && apt-get install -y nodejs \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/outsourc-e/hermes-agent.git /app

WORKDIR /app

RUN pip install --no-cache-dir -e .

# Install pip-based MCP servers
RUN pip install --no-cache-dir \
    mcp-server-sqlite \
    mcp-server-git \
    screenshot-mcp-server \
    mem0ai \
    graphiti-core \
    mempalace \
    graphifyy \
    code-review-graph \
    repomix

# Install npm-based tools that support global install
RUN npm install -g repomix @agentmemory/agentmemory

# Patch: don't pop OPENAI_API_KEY/BASE_URL before provider resolution
RUN sed -i 's/_stale_oai_key = os.environ.pop("OPENAI_API_KEY", None)/_stale_oai_key = None  # patched for local providers/' \
    /app/gateway/platforms/api_server.py && \
    sed -i 's/_stale_oai_base = os.environ.pop("OPENAI_BASE_URL", None)/_stale_oai_base = None  # patched for local providers/' \
    /app/gateway/platforms/api_server.py

EXPOSE 8642

CMD ["hermes", "gateway", "run"]
