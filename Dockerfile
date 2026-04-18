FROM node:22-bookworm-slim

WORKDIR /app

COPY download-script.cjs ./download-script.cjs

RUN printf '%s\n' \
  '{' \
  '  "name": "papacambridge-render-worker",' \
  '  "private": true,' \
  '  "type": "commonjs",' \
  '  "dependencies": {' \
  '    "pdfjs-dist": "5.6.205"' \
  '  }' \
  '}' > package.json \
  && npm install --omit=dev --no-package-lock --no-audit --no-fund

ENV NODE_ENV=production

CMD ["sh", "-lc", "mkdir -p /app/runtime && STORAGE_PATH=/app/runtime/igcse DB_PATH=/app/runtime/igcse/worker.sqlite node download-script.cjs https://pastpapers.papacambridge.com/papers/caie/igcse & STORAGE_PATH=/app/runtime/o-level DB_PATH=/app/runtime/o-level/worker.sqlite node download-script.cjs https://pastpapers.papacambridge.com/papers/caie/o-level & STORAGE_PATH=/app/runtime/as-and-a-level DB_PATH=/app/runtime/as-and-a-level/worker.sqlite node download-script.cjs https://pastpapers.papacambridge.com/papers/caie/as-and-a-level & wait && echo ALL DONE"]
