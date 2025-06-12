#!/bin/bash

# Import saved objects into Kibana
curl -X POST "localhost:5601/api/saved_objects/_import?overwrite=true" \
  -H "kbn-xsrf: true" \
  --form file=@./dashboards/kibana-exports.ndjson

echo "Dashboards imported successfully from ./dashboards/kibana-exports.ndjson" 