# Use Python 3.11 slim image as base
FROM python:3.11-slim-bookworm

# Install uv using the official method
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /bin/


# ---------- copy start script & fix line endings ----------
COPY start.sh /app/start.sh
RUN apt-get update && apt-get install -y --no-install-recommends dos2unix \
    && dos2unix /app/start.sh && chmod +x /app/start.sh \
    && apt-get purge -y dos2unix && apt-get autoremove -y

# ---------- runtime metadata ----------
EXPOSE 8502
HEALTHCHECK --interval=30s --timeout=5s CMD curl -f http://localhost:8502/_stcore/health || exit 1

CMD ["/app/start.sh"]
