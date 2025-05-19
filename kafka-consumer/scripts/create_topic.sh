#!/bin/bash

TOPIC_NAME="purchases"
NUM_MESSAGES=10
NUM_USERS=10
PRODUCTS=("apple" "banana" "carrot" "detergent" "eggs" "flour" "grapes" "honey" "icecream" "juice")

echo "Waiting for Kafka to be ready..."
for i in {1..30}; do
  if kafka-topics --bootstrap-server kafka:9092 --list >/dev/null 2>&1; then
    echo "Kafka is ready!"
    break
  else
    echo "Kafka not ready, retrying in 5s..."
    sleep 5
  fi
done

echo "Creating topic '$TOPIC_NAME'..."
kafka-topics --create \
  --if-not-exists \
  --bootstrap-server kafka:9092 \
  --replication-factor 1 \
  --partitions 3 \
  --topic "$TOPIC_NAME"

echo "Producing $NUM_MESSAGES random messages to Kafka topic: $TOPIC_NAME"

for i in $(seq 1 $NUM_MESSAGES); do
  user_id=$((RANDOM % NUM_USERS + 1))
  product=${PRODUCTS[$RANDOM % ${#PRODUCTS[@]}]}
  amount=$((RANDOM % 10 + 1))
  timestamp=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

  message="$user_id,$product,$amount,$timestamp"

  echo "$message" | kafka-console-producer \
    --topic "$TOPIC_NAME" \
    --bootstrap-server kafka:9092 > /dev/null
done

echo "Done: $NUM_MESSAGES messages sent to $TOPIC_NAME"
