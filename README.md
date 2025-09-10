# APL Log & Threat Analyzer

Compact and fast tool for detecting failed logins and request spikes in server logs. Supports terminal, JSON, and CSV outputs. Fully Dockerized for instant deployment on any OS.

---

## Features
- Detects **failed login attempts** (HTTP 401 errors).  
- Detects **request spikes** (IPs sending more than a threshold of requests per minute).  
- Generates **Terminal Reports** for immediate monitoring.  
- Generates **JSON Reports** for dashboard or SIEM integration.  
- Generates **CSV Reports** for historical analysis.  
- Fully **Dockerized** for cross-platform usage (Windows, Mac, Linux).  

---

## Requirements
- Docker installed (the setup script will handle installation if missing).  
- Internet access for initial setup (to clone the repository and build Docker image).  

---

## Quick Setup (One Command)
Run the following command in the terminal:

```bash
curl -s https://raw.githubusercontent.com/skilloo-coder/apl-analyzer/setup.sh | bash
