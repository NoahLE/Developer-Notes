---
title: Docker Problems
date: "2018-03-13"
publish: true
---

* Firewall is blocking the shared container

I find completely shutting down Docker and loading it back up fixes this problem. Sometimes a computer restart may be required.

* Error code 127

Check the drive permissions by right clicking Docker > Settings > Shared Drives > Reset Credentials > Apply > Recheck the drive > Apply.

* Project is failing to build, ports already being in use, or generally misbehaving

```bash
docker-compose down
docker-compose up --build --force-recreate
```

* Left over contents from last build are messing up the build

```bash
docker-compose down
docker-compose up
```

```bash
# To nuke from orbit
# WARNING - THIS MAY DELETE FILES WHICH YOU MAY WISH TO KEEP
docker system prune
```

* Can't access the drive

Right click Docker > Settings > Shared Drives > Reset Credentials > Apply > Recheck the drive > Apply