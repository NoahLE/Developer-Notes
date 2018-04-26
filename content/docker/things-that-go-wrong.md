---
title: Docker Problems
date: "2018-03-13"
publish: true
---

* Firewall is blocking the shared container

* Error code 127

```bash
docker-compose up --build --force-recreate
```

* Left over contents from last build (to nuke, run `docker system prune`)

```bash
docker-compose down
docker-compose up
```

* Can't access drive

Right click Docker > Settings > Shared Drives > Reset Credentials > Apply > Recheck the drive > Apply