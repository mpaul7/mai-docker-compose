# mai-docker-compose

# MAI Streaming – Dockerized Deployment

This repository packages the [`mai-streaming`](https://github.com/mpaul7/mai-streaming) project using Docker Compose. It simplifies deployment by bundling together:

- The `mai_streaming` Python application for streaming and batch processing of network traffic.
- An Elasticsearch backend for storing classified results.
- Kibana for visualization and monitoring of anomaly classification and statistics.

## Repository Structure
```
mai-docker-compose/
├── docker-compose.yml      # Docker Compose service definitions
├── .env                    # Optional environment configuration
├── kibana/                 # Kibana configuration
│   ├── dashboards/        # Exported dashboard configurations
│   ├── export-dashboards.sh # Script to export dashboards
│   └── import-dashboards.sh # Script to import dashboards
├── src/
│   └── mai_streaming/     # Main streaming application (cloned or submodule)
│       ├── Dockerfile     # Dockerfile for mai_streaming service
│       ├── requirements.txt # Python dependencies
│       └── ...           # Application code
└── data/                  # Mounted folder for PCAP or CSV inputs
```

## Getting Started

### Prerequisites

Ensure you have the following installed:

- [Docker Engine](https://docs.docker.com/engine/install/)
- [Docker Compose v2+](https://docs.docker.com/compose/install/)
- [Git](https://git-scm.com/)

### Initial Setup

1. Clone the repository and initialize submodules:
   ```bash
   git clone https://github.com/mpaul7/mai-docker-compose.git
   cd mai-docker-compose
   git submodule add https://github.com/mpaul7/mai-streaming.git src/mai_streaming
   ```

2. Build and start the services:
   ```bash
   docker-compose up -d --build
   ```

3. Wait for all services to start (this may take a few minutes on first run)
   - Elasticsearch will be available on port 9200
   - Kibana will be available on port 5601

### Using the Application

#### Processing Data

1. Place your input data files in the `data` directory:
   ```bash
   cp your_data.csv ./data/
   ```

2. Process data using the mai_streaming service:
   ```bash

   # For DDoS analysis
   docker-compose exec mai_streaming mai-streaming ddos --format csv /data

   # For twc pcap analysis

   # For twc live data analysis

   

   ```

#### Viewing Results

1. Access Kibana at [http://localhost:5601](http://localhost:5601)
2. Navigate to "Dashboards" to view your data visualizations

### Managing Kibana Dashboards

The repository includes scripts to help you manage and share Kibana dashboards across different deployments.

#### Exporting Dashboards

After creating your dashboards in Kibana, export them:

```bash
# Make sure scripts are executable
chmod +x kibana/export-dashboards.sh kibana/import-dashboards.sh

# Export dashboards
./kibana/export-dashboards.sh
```

The dashboards will be exported to `kibana/dashboards/kibana-exports.ndjson`

#### Importing Dashboards

When deploying to a new machine or restoring dashboards:

```bash
# Start services if not running
docker-compose up -d

# Wait for Kibana to be fully up (usually 1-2 minutes)
# Then import dashboards
./kibana/import-dashboards.sh
```

### Updating the Application

To update the application to the latest version:

```bash
# Pull latest changes
git pull
git submodule update --remote

# Rebuild and restart services
docker-compose down
docker-compose up -d --build
```

### Environment Configuration

The application can be configured using environment variables in a `.env` file:

```env
ES_URL=http://elasticsearch:9200  # Elasticsearch URL
ES_INDEX=streaming               # Index name for data storage
```

### Troubleshooting

1. If Elasticsearch fails to start:
   ```bash
   # Check logs
   docker-compose logs elasticsearch
   
   # Increase virtual memory limits on host
   sudo sysctl -w vm.max_map_count=262144
   ```

2. If Kibana can't connect to Elasticsearch:
   ```bash
   # Check Elasticsearch is running
   curl http://localhost:9200
   
   # Check Kibana logs
   docker-compose logs kibana
   ```

3. If dashboard import fails:
   - Ensure Kibana is fully started before importing
   - Check file permissions on the dashboards directory
   - Verify the export file exists and is valid JSON

