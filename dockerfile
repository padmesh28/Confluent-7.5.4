# Use the Debezium Connect base image
FROM debezium/connect:2.5.4.Final

# Add the Kafka Connect Avro Converter JAR
COPY kafka-connect-avro-converter-7.5.4/lib/*.jar /kafka/connect/libs/

# Ensure the correct permissions for the installed files
USER root
RUN chown kafka:kafka /kafka/connect/libs/*.jar

# Switch back to the kafka user
USER kafka

# Define any additional environment variables required
ENV CONNECT_KEY_CONVERTER=io.confluent.connect.avro.AvroConverter
ENV CONNECT_VALUE_CONVERTER=io.confluent.connect.avro.AvroConverter
ENV CONNECT_KEY_CONVERTER_SCHEMA_REGISTRY_URL=http://schema-registry:8081
ENV CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_URL=http://schema-registry:8081

# Optional: Expose additional ports if needed
EXPOSE 8083

# Run the original entrypoint
ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["start"]
