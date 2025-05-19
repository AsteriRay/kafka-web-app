#!/bin/bash
set -e

host="kafka"
port=9092

echo "Waiting for Kafka to be ready at $host:$port..."

while ! nc -z $host $port; do
  sleep 1
done

echo "Kafka is up. Starting the consumer..."
exec "$@"