FROM quay.io/strimzi/kafka:0.40.0-kafka-3.7.0

USER root:root

##########
# Connector plugin debezium-connector-postgres
##########
RUN 'mkdir' '-p' '/opt/kafka/plugins/debezium-connector-postgres/25c63200'
COPY ./publish/debezium-connector-postgres.zip /opt/kafka/plugins/debezium-connector-postgres/25c63200.zip
# && 'curl' '-f' '-L' '--output' '/opt/kafka/plugins/debezium-connector-postgres/25c63200.zip' 'https://repo1.maven.org/maven2/io/debezium/debezium-connector-postgres/2.6.1.Final/debezium-connector-postgres-2.6.1.Final-plugin.zip' \
RUN 'unzip' '/opt/kafka/plugins/debezium-connector-postgres/25c63200.zip' '-d' '/opt/kafka/plugins/debezium-connector-postgres/25c63200' \
&& 'find' '/opt/kafka/plugins/debezium-connector-postgres/25c63200' '-type' 'l' | 'xargs' 'rm' '-f' \
&& 'rm' '-vf' '/opt/kafka/plugins/debezium-connector-postgres/25c63200.zip'

##########
# Connector plugin debezium-jdbc-connector
##########
RUN 'mkdir' '-p' '/opt/kafka/plugins/debezium-jdbc-connector/dad3d006'
COPY ./publish/debezium-connector-jdbc.zip /opt/kafka/plugins/debezium-jdbc-connector/dad3d006.zip
#     && 'curl' '-f' '-L' '--output' '/opt/kafka/plugins/debezium-jdbc-connector/dad3d006.zip' 'file:///mnt/c/Users/sagdelen/ws/opis/debezium-jdbc-connector-naming-strategy/publish/debezium-connector-jdbc-2.6.1.Final-plugin.zip' \
RUN 'unzip' '/opt/kafka/plugins/debezium-jdbc-connector/dad3d006.zip' '-d' '/opt/kafka/plugins/debezium-jdbc-connector/dad3d006' \
      && 'find' '/opt/kafka/plugins/debezium-jdbc-connector/dad3d006' '-type' 'l' | 'xargs' 'rm' '-f' \
      && 'rm' '-vf' '/opt/kafka/plugins/debezium-jdbc-connector/dad3d006.zip'

# ##########
# # Connector plugin debezium-scripting
# ##########
# RUN 'mkdir' '-p' '/opt/kafka/plugins/debezium-scripting/ac27dca1'
# COPY ./publish/debezium-scripting.zip /opt/kafka/plugins/debezium-scripting/ac27dca1.zip
# # && 'curl' '-f' '-L' '--output' '/opt/kafka/plugins/debezium-scripting/ac27dca1.zip' 'https://repo1.maven.org/maven2/io/debezium/debezium-connector-postgres/2.6.1.Final/debezium-connector-postgres-2.6.1.Final-plugin.zip' \
# RUN 'unzip' '/opt/kafka/plugins/debezium-scripting/ac27dca1.zip' '-d' '/opt/kafka/plugins/debezium-scripting/ac27dca1' \
# && 'find' '/opt/kafka/plugins/debezium-scripting/ac27dca1' '-type' 'l' | 'xargs' 'rm' '-f' \
# && 'rm' '-vf' '/opt/kafka/plugins/debezium-scripting/ac27dca1.zip'

USER 1001



# https://developers.redhat.com/articles/2023/07/06/how-use-debezium-smt-groovy-filter-routing-events#creating_the_image
# - $PWD/jars/debezium-scripting-1.4.0.Alpha2.jar:/kafka/connect/debezium-connector-postgres/debezium-scripting-1.4.0.Alpha2.jar

# - $PWD/jars/groovy-3.0.6.jar:/kafka/connect/debezium-connector-postgres/groovy-3.0.6.jar
# https://groovy.jfrog.io/ui/native/dist-release-local/groovy-zips/apache-groovy-sdk-4.0.21.zip

# - $PWD/jars/groovy-json-3.0.6.jar:/kafka/connect/debezium-connector-postgres/groovy-json-3.0.6.jar

# - $PWD/jars/groovy-jsr223-3.0.6.jar:/kafka/connect/debezium-connector-postgres/groovy-jsr223-3.0.6.jar