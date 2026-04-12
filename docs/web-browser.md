# Web & Browser MCP Servers

> Three tools for giving AI access to the web: simple fetching, full browser automation, and search.

## 1. Fetch MCP (Official)

The simplest option — fetches any URL and converts HTML to clean Markdown.

- **Source**: https://github.com/modelcontextprotocol/servers
- **Install**: `npx -y @modelcontextprotocol/server-fetch`

### MCP Config

```json
{
  "fetch": {
    "command": "npx",
    "args": ["-y", "@modelcontextprotocol/server-fetch"]
  }
}
```

### What It Does

- Fetches any URL (web pages, APIs, files)
- Converts HTML to clean Markdown for AI consumption
- Handles redirects and custom headers
- Strips noise (ads, navigation, scripts)
- Works with authenticated APIs via custom headers

### Best For

Reading documentation, API responses, and web content without needing a full browser.

---

## 2. Playwright MCP (Microsoft)

Full browser automation — navigate, click, fill forms, take screenshots, run E2E tests.

- **GitHub**: https://github.com/microsoft/playwright-mcp
- **Install**: `npx @playwright/mcp@latest`

### MCP Config

```json
{
  "playwright": {
    "command": "npx",
    "args": ["@playwright/mcp@latest"]
  }
}
```

### What It Does

- Navigate to any URL in a real browser
- Click buttons, fill forms, select dropdowns
- Take screenshots of pages or elements
- Wait for page loads and dynamic content
- Run across Chromium, Firefox, WebKit

### Best For

Testing web apps, scraping dynamic content, form automation, visual verification.

---

## 3. Brave Search MCP (Official)

Web, image, news, and local search powered by Brave's independent search index.

- **GitHub**: https://github.com/brave/brave-search-mcp-server
- **Install**: `npx -y @brave/mcp-server`
- **API Key**: Free tier at https://brave.com/search/api/

### MCP Config

```json
{
  "brave-search": {
    "command": "npx",
    "args": ["-y", "@brave/mcp-server"],
    "env": {
      "BRAVE_API_KEY": "YOUR_KEY"
    }
  }
}
```

### What It Does

- Web search (general, news, images, video)
- Local POI (point of interest) search
- No tracking, privacy-respecting
- Free tier: 2,000 queries/month

### Best For

Searching the internet for research, documentation, error solutions.

---

## Comparison

| Feature | Fetch MCP | Playwright MCP | Brave Search |
|---------|-----------|----------------|-------------|
| Reads web pages | Yes | Yes | No (search only) |
| JavaScript rendering | No | Yes | N/A |
| Form interaction | No | Yes | No |
| Screenshots | No | Yes | No |
| Search engine | No | No | Yes |
| API key needed | No | No | Yes (free) |
| Speed | Fast | Medium | Fast |
