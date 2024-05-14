package com.opiscloud.debezium.connector.jdbc.naming;

import org.apache.kafka.connect.data.Struct;
import org.apache.kafka.connect.sink.SinkRecord;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import io.debezium.connector.jdbc.JdbcSinkConnectorConfig;
import io.debezium.connector.jdbc.naming.TableNamingStrategy;

public class LogicalTableRouterTableNamingStrategy implements TableNamingStrategy {
    private static final Logger LOGGER = LoggerFactory.getLogger(LogicalTableRouterTableNamingStrategy.class);

    @Override
    public String resolveTableName(JdbcSinkConnectorConfig config, SinkRecord record) {
        String tableName = null;
        if (record.key() != null && record.keySchema().field("__dbz__physicalTableIdentifier") != null) {
            // Retrieve the value of the "__dbz__physicalTableIdentifier" field from the
            // SinkRecord's key
            Object physicalTableIdentifier = ((Struct) record.key()).get("__dbz__physicalTableIdentifier");
            if (physicalTableIdentifier != null) {
                // Use the value of "__dbz__physicalTableIdentifier" as the table name
                // drop all the prefixes and use the last part as the table name
                String[] tableNameFragments = physicalTableIdentifier.toString().split("\\.");
                tableName = tableNameFragments[tableNameFragments.length - 1];
            } else {
                LOGGER.error("The '__dbz__physicalTableIdentifier' field is null in the SinkRecord's key");
                return null;
            }
        } else {
            LOGGER.error("The '__dbz__physicalTableIdentifier' field does not exist in the SinkRecord's key");
            return null;
        }

        String table = config.getTableNameFormat().replace("${pti}", tableName); // => tenser.srkn.public.branches

        return table;
    }
}
