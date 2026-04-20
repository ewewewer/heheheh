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

CMD ["node", "download-script.cjs"]
