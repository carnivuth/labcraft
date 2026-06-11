#!/usr/bin/env bash
# Send a Telegram message from stdin
# Required env vars:
#   TELEGRAM_TOKEN   - Bot API token
#   TELEGRAM_CHAT_ID - Target chat/user/channel ID

set -euo pipefail

: "${TELEGRAM_TOKEN:?Error: TELEGRAM_TOKEN is not set}"
: "${TELEGRAM_CHAT_ID:?Error: TELEGRAM_CHAT_ID is not set}"

MESSAGE="$(cat)"

if [[ -z "$MESSAGE" ]]; then
  echo "Error: message is empty (nothing on stdin)" >&2
  exit 1
fi

RESPONSE="$(curl -sSf \
  --request POST \
  --url "https://api.telegram.org/bot${TELEGRAM_TOKEN}/sendMessage" \
  --header "Content-Type: application/json" \
  --data "$(jq -n \
    --arg chat_id "$TELEGRAM_CHAT_ID" \
    --arg text "$MESSAGE" \
    '{chat_id: $chat_id, text: $text, parse_mode: "MarkdownV2"}'
  )")"

if echo "$RESPONSE" | jq -e '.ok == true' > /dev/null; then
  echo "Message sent successfully."
else
  echo "Error sending message:" >&2
  echo "$RESPONSE" | jq '.description' >&2
  exit 1
fi
