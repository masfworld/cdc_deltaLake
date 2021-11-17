FROM cnfldemos/kafka-connect-datagen:0.2.0-5.4.0

RUN confluent-hub install --no-prompt mongodb/kafka-connect-mongodb:1.4.0
