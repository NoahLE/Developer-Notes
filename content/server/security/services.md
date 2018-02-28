---
title: Service Auditing
date: "2018-02-28"
publish: true
---


# Service Auditing

```bash
# An example of viewing services listening on ports would be 
sudo netstat -plunt
```

```bash
# Which would return something like 
Active Internet connections (only servers)
Proto Recv-Q Send-Q Local Address           Foreign Address         State       PID/Program name
tcp        0      0 0.0.0.0:22              0.0.0.0:*               LISTEN      887/sshd        
tcp        0      0 0.0.0.0:80              0.0.0.0:*               LISTEN      919/nginx       
tcp6       0      0 :::22                   :::*                    LISTEN      887/sshd        
tcp6       0      0 :::80                   :::*                    LISTEN      919/nginx
```

## Sources

- https://www.digitalocean.com/community/tutorials/7-security-measures-to-protect-your-servers