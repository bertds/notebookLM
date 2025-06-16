#!/usr/bin/env bash
set -e

PORT="${PORT:-8502}"          # Coolify injects PORT; fall back to 8502
echo "Launching Streamlit on 0.0.0.0:${PORT}"

exec uv run streamlit run app_home.py \
        --server.port "${PORT}" \
        --server.address "0.0.0.0" \
        --server.headless true
