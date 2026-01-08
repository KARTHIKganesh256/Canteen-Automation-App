#!/usr/bin/env bash
# Simple API smoke tests for local model endpoints
# Usage: BASE_URL=http://127.0.0.1:8000 ./scripts/test_api.sh

BASE_URL=${BASE_URL:-http://127.0.0.1:8000}
CURL_OPTS=(-s -S -H "Content-Type: application/json" -m 10)

echo "Testing $BASE_URL/recommend"
RECOMMEND_RESP=$(curl "${CURL_OPTS[@]}" -X POST -d '{"user_id":"test"}' "$BASE_URL/recommend" 2>&1)
RECOMMEND_CODE=$?
if [ "$RECOMMEND_CODE" -ne 0 ]; then
  echo "Request failed: $RECOMMEND_RESP"
else
  echo "Response:" 
  if command -v jq >/dev/null 2>&1; then
    echo "$RECOMMEND_RESP" | jq '.' || echo "$RECOMMEND_RESP"
  else
    echo "$RECOMMEND_RESP"
  fi
fi

echo
echo "Testing $BASE_URL/predict-demand"
PREDICT_RESP=$(curl "${CURL_OPTS[@]}" -X POST -d '{"item_id":"test_item"}' "$BASE_URL/predict-demand" 2>&1)
PREDICT_CODE=$?
if [ "$PREDICT_CODE" -ne 0 ]; then
  echo "Request failed: $PREDICT_RESP"
else
  echo "Response:" 
  if command -v jq >/dev/null 2>&1; then
    echo "$PREDICT_RESP" | jq '.' || echo "$PREDICT_RESP"
  else
    echo "$PREDICT_RESP"
  fi
fi

echo
echo "Done. If responses look unexpected, paste them here and I’ll adjust the client/models."