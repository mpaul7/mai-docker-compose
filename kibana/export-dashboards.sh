#!/bin/bash

# Export all saved objects from Kibana
curl -X POST "localhost:5601/api/saved_objects/_export" \
  -H 'kbn-xsrf: true' \
  -H 'Content-Type: application/json' \
  -d '{
  "type": ["dashboard", "visualization", "index-pattern"],
  "excludeExportDetails": true
}' > ./dashboards/kibana-exports.ndjson

echo "Dashboards exported successfully to ./dashboards/kibana-exports.ndjson" 