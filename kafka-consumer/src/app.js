const { Kafka } = require('kafkajs');

const kafka = new Kafka({
  clientId: process.env.KAFKA_CLIENT_ID,
  brokers: process.env.KAFKA_BROKERS.split(','),
});

const consumer = kafka.consumer({
  groupId: process.env.KAFKA_GROUP_ID,
  fromBeginning: true,
});

const run = async () => {
  try {
    console.log("Connecting to Kafka...");
    await consumer.connect();
    console.log("Connected successfully.");

  } catch (err) {
    console.error("Failed to connect to Kafka:", err.message);
    return;
  }

  try {
    console.log(`Subscribing to topic: ${process.env.KAFKA_TOPIC}...`);
    await consumer.subscribe({ topic: process.env.KAFKA_TOPIC, fromBeginning: true });
    console.log(`Successfully subscribed to topic: ${process.env.KAFKA_TOPIC}`);

  } catch (err) {
    console.error("Failed to subscribe to topic:", err.message);
    return;
  }

  try {
    console.log("Starting consumer...");
    await consumer.run({
      eachMessage: async ({ topic, partition, message }) => {
        console.log("Message received:", {
          partition,
          offset: message.offset,
          value: message.value.toString(),
        });
      },
    });
    console.log("Consumer is running and listening for messages.");

  } catch (err) {
    console.error("Error while consuming messages:", err.message);
  }
};

run().catch((err) => {
  console.error("Unhandled error in run():", err.message);
});
