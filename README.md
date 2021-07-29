# Instrumenting a web api with .Net, Tempo, and OpenTelemetry
This repo contains the sample code and files for the blog post [here](https://grafana.com/blog/2021/02/11/instrumenting-a-.net-web-api-using-opentelemetry-tempo-and-grafana-cloud/).  It shows how to use the [OpenTelemetry.NET libraries](https://github.com/open-telemetry/opentelemetry-dotnet) to captures traces for incoming http requests, and use the [Grafana Agent](https://github.com/grafana/agent) to forward them Grafana Cloud Tempo.

## Usage
1. Edit agent-config.yaml and docker-compose.yaml with your Grafana Cloud user name and api keys for Tempo and Loki.  
1. Run `docker-compose up`.  Browse to [http://localhost:5000/swagger](http://localhost:5000/swagger) and make some requests.  
1. Browse to <your_stack>.grafana.net and explore the logs and traces.

#Grafana API KEY
#curl -H "Authorization: Bearer eyJrIjoiQ2NTTHpUdG1tcmo0QVNvMUxETGZ1dGxLOWRFV0k5TUUiLCJuIjoibW9uaXRvcmluZyIsImlkIjoxfQ==" http://localhost:3000/api/dashboards/home


loki-url: https://grafanacloud-vishallodha84-logs:eyJrIjoiMjc1ZDQ1NzUxNDNkOTQ0NmEzMTllYzEyOWQxYjFhMmY2ZDk5NDAzMSIsIm4iOiJMb2tpIiwiaWQiOjQ4NzQ2MX0=@logs-prod-us-central1.grafana.net/api/prom/push
#Tempo  API Key
#eyJrIjoiZjQyMTdlMzBlNTgyZTU3YmNjMmYyZDcxYTAxNTBmNjA3MzcxNjMwMCIsIm4iOiJUZW1wbyIsImlkIjo0ODc0NjF9


#Run this command to install and run the Grafana Agent as a grafana-agent.service systemd service
sudo ARCH=amd64 GCLOUD_STACK_ID="195838" GCLOUD_API_KEY="eyJrIjoiYzE5YzdiYjlkZjVmZDBhOWRkZjg4MDAyOGYzNjZiNTZiZTc0NDI5MyIsIm4iOiJ2aXNoYWxsb2RoYTg0LWVhc3lzdGFydC1nY29tIiwiaWQiOjQ4NzQ2MX0=" /bin/sh -c "$(curl -fsSL https://raw.githubusercontent.com/grafana/agent/release/production/grafanacloud-install.sh)"



Optional configurations

The following agent configuration defines a scrape job that pulls the metrics from a cAdvisor instance on localhost on the port defined in the example config above. If cAdvisor is running on a different host the address must be adjusted to match.

prometheus:
  wal_directory: /tmp/wal
  global:
    scrape_interval: 5s
  configs:
    - name: integrations
      scrape_configs:
        - job_name: integrations/docker
          static_configs:
            - targets: ['localhost:8080']
      remote_write:
        - url: http://cortex:9009/api/prom/push


clipboard iconCopy to clipboard
After installation, the Agent config is stored in /etc/grafana-agent.yaml. Anytime the config file is modified, run the following to restart the Agent so it can pick up changes:

sudo systemctl restart grafana-agent.service

