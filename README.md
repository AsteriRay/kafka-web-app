# Kafka Web Application

This repository contains a Kafka-based web application consisting of:

- A Kafka broker setup
- A Kafka consumer Node.js service
- Helm charts to deploy both components on a Kubernetes cluster (tested with Minikube)
- Docker Compose files for local development and testing

---

## 📁 Project Structure

```
helm-charts/
  ├── kafka/                  # Helm chart for Kafka
  └── kafka-consumer/         # Helm chart for Kafka Consumer

kafka-consumer/
  ├── Dockerfile              # Container spec for the consumer
  ├── docker-compose.yaml     # Local setup for Kafka + Consumer
  └── src/app.js              # Kafka consumer Node.js app
```

---

## 🚀 Quick Start (Local Development)

You can spin up the Kafka broker and consumer locally using Docker Compose:

### 1. Prerequisites

- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)
- Node.js (for any development work on the consumer)

### 2. Run with Docker Compose

```bash
cd kafka-consumer
docker-compose up --build
```

This will:

- Start a Kafka broker using the `bitnami/kafka` image
- Create a Kafka topic and produce messages to it using the provided script
- Build and start the Kafka consumer Node.js app

The consumer will wait for Kafka to become available, then subscribe to topics and start consuming messages.

---

## ☸️ Kubernetes Deployment (Minikube)

You can deploy the Kafka and Kafka Consumer services to a local Minikube cluster using Helm.

### 1. Prerequisites

- [Minikube](https://minikube.sigs.k8s.io/docs/start/)
- [Helm 3+](https://helm.sh/docs/intro/install/)

### 2. Start Minikube

```bash
minikube start
```

### 3. Deploy Kafka

```bash
cd helm-charts/kafka
helm install kafka . --create-namespace --namespace kafka
```

### 4. Deploy Kafka Consumer

```bash
cd ../kafka-consumer
helm install kafka-consumer . --create-namespace --namespace kafka-consumer
```

### 5. Verify Deployments

```bash
kubectl get pods -n kafka
kubectl logs -n kafka-consumer <kafka-consumer-pod-name>
```

---

## 📦 Helm Chart Configuration

Both charts include default `values.yaml` files you can customize.

- **Kafka Values:**  
  `helm-charts/kafka/values.yaml`

- **Kafka Consumer Values:**  
  `helm-charts/kafka-consumer/values.yaml`

---

## 🧹 Cleanup

```bash
helm uninstall kafka --namespace kafka
helm uninstall kafka-consumer --namespace kafka-consumer
minikube delete
```
