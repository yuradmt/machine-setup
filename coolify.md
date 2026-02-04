# Coolify Setup

Self-hosted PaaS on this VPS. Like Vercel but you own it.

## Access

- **Dashboard:** http://207.180.203.80:8000
- **Apps use:** `*.207.180.203.80.sslip.io` (or custom domains)

## Architecture

- Coolify runs in Docker containers
- Uses Traefik as reverse proxy (routes by hostname)
- SSH bridge container needed for localhost management (Docker networking quirk)

## Containers

```
coolify           - Main dashboard (port 8000)
coolify-db        - PostgreSQL
coolify-redis     - Redis cache
coolify-realtime  - WebSocket server
coolify-sentinel  - Helper agent on server
ssh-bridge        - socat bridge for SSH (10.0.1.1:2222 → localhost:22)
```

## Server Connection

Due to Docker-to-host networking issues, Coolify connects via SSH bridge:
- **Host:** 10.0.1.1
- **Port:** 2222
- **User:** root

The bridge container forwards to localhost:22.

## Adding a Static Site

1. **Projects** → **Add** → name it
2. **Add Resource** → **Public/Private Repository**
3. Paste GitHub repo URL
4. Select server, choose **Static** build pack
5. Set **Base Directory** to folder with index.html (e.g., `backtest-site`)
6. Deploy

## Custom Domains

Each app can have its own domain:
1. Point domain's DNS A record → `207.180.203.80`
2. In app settings → **Domains** → add your domain
3. Coolify auto-provisions SSL via Let's Encrypt

## Troubleshooting

### "Welcome to nginx" default page
- Files not in right directory → check Base Directory setting
- Browser cache → hard refresh (Ctrl+Shift+R)

### Docker daemon stopped
```bash
sudo systemctl start docker
```

### Coolify unreachable
```bash
docker ps --filter "name=coolify"  # Check if containers running
cd /data/coolify/source && docker-compose -f docker-compose.yml -f docker-compose.prod.yml up -d
```

### SSH bridge down
```bash
docker ps --filter "name=ssh-bridge"
# If not running:
docker run -d --name ssh-bridge --network host --restart always alpine/socat TCP-LISTEN:2222,fork,reuseaddr,bind=10.0.1.1 TCP:127.0.0.1:22
```

## Files

- Config: `/data/coolify/source/`
- SSH keys: `/data/coolify/ssh/keys/`
- App data: `/data/coolify/applications/`
