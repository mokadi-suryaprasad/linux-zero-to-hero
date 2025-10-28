# 🧠 Network Troubleshooting — Real-Time Interview Guide

A practical collection of **network troubleshooting interview questions**, explained with **real commands**, **use cases**, and **step-by-step reasoning** — essential for **DevOps, SRE, or System Engineer** interviews.

---

## ⚙️ 1️⃣ How do you check your IP address and network interfaces?

### 🔹 Real-Time Answer:
To view IP configuration and interfaces:
```bash
ip addr show
# or a brief output
ip -br a
```
**Example Output:**
```
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
    inet 192.168.1.10/24 brd 192.168.1.255 scope global eth0
```
**Purpose:** Confirms IP, subnet, and interface status (UP/DOWN).

---

## ⚙️ 2️⃣ What’s the difference between TCP and UDP?

### 🔹 Real-Time Answer:
- **TCP** → Connection-oriented, reliable, ordered (used in SSH, HTTP, HTTPS).  
- **UDP** → Connectionless, faster, no acknowledgment (used in DNS, video streaming).

**Examples:**
```bash
# TCP (HTTP)
curl http://example.com

# UDP (DNS)
dig google.com
```

---

## ⚙️ 3️⃣ How do you test if a remote host is reachable?

### 🔹 Real-Time Answer:
Start with simple connectivity checks:
```bash
ping 8.8.8.8         # ICMP check
traceroute google.com  # Path tracing
```
If ping fails but traceroute works partially → indicates **ICMP block** or **firewall restrictions**.

---

## ⚙️ 4️⃣ What command shows which ports are listening?

### 🔹 Real-Time Answer:
```bash
sudo ss -tuln        # Shows TCP/UDP listening ports
sudo ss -tulnp       # Includes process details
```
**Example Output:**
```
LISTEN 0 128 *:22 *:* users:(("sshd",pid=940,fd=3))
```
✅ Helps identify running services and listening ports.

---

## ⚙️ 5️⃣ How do you perform a DNS lookup?

### 🔹 Real-Time Answer:
```bash
dig google.com +short
nslookup google.com
```
If lookup fails:
- Check `/etc/resolv.conf` for DNS servers.
- Use `systemd-resolve --status` for detailed resolver info.

---

## ⚙️ 6️⃣ What’s the purpose of a default gateway?

### 🔹 Real-Time Answer:
The **default gateway** routes traffic **outside the local subnet**.
```bash
ip route
```
**Example Output:**
```
default via 192.168.1.1 dev eth0
```
Without a default gateway, internet or external network access fails.

---

## ⚙️ 7️⃣ How do you troubleshoot “can ping IP but not hostname”?

### 🔹 Real-Time Answer:
This is a **DNS resolution issue**. Steps:
1️⃣ Check `/etc/resolv.conf`  
2️⃣ Test with `dig hostname`  
3️⃣ Compare:
```bash
ping 8.8.8.8
ping google.com
```
If IP works but hostname doesn’t → Fix DNS configuration or restart resolver:
```bash
sudo systemctl restart systemd-resolved
```

---

## ⚙️ 8️⃣ What does “Connection Refused” vs “Connection Timeout” mean?

### 🔹 Real-Time Explanation:

| Term | Meaning | Cause |
|------|----------|-------|
| **Connection Refused** | Host reachable, but port closed | Service not running |
| **Connection Timeout** | No response from host | Firewall, routing issue |

**Example:**
```bash
telnet 10.0.0.5 22
# Connection refused → SSH not running
# Connection timed out → Network/firewall issue
```

---

## ⚙️ 9️⃣ How do you find which process is using port 80?

### 🔹 Real-Time Answer:
```bash
sudo lsof -i :80
# or
sudo netstat -tulnp | grep :80
```
**Example Output:**
```
nginx   1234  root  80  TCP *:80 (LISTEN)
```
Helps identify which service owns the port.

---

## ⚙️ 🔟 Walk me through diagnosing a network connectivity issue.

### 🔹 Real-Time Approach (OSI Model)

| Layer | Check | Command / Action |
|-------|-------|------------------|
| **L1 — Physical** | Link & cable | `ip link show`, `ethtool eth0` |
| **L2 — Data Link** | MAC & ARP | `arp -n` |
| **L3 — Network** | IP & Routing | `ping`, `ip route` |
| **L4 — Transport** | Port availability | `ss -tuln` |
| **L5–L7 — Application** | DNS & Service logs | `dig`, `curl`, app logs |

**Example Case:**
```bash
ping 8.8.8.8   # Works
ping google.com  # Fails
```
➡ Indicates DNS issue.  
✅ Fixed by updating `/etc/resolv.conf` with a valid DNS (e.g., `8.8.8.8`).

---

## 🧩 Summary — Key Tools to Remember

| Tool | Purpose |
|------|----------|
| `ip`, `ifconfig` | Interface configuration |
| `ping`, `traceroute` | Connectivity testing |
| `ss`, `netstat`, `lsof` | Port and socket info |
| `dig`, `nslookup` | DNS testing |
| `ip route` | Routing and gateway check |
| `telnet`, `nc` | Port reachability check |
| `journalctl`, `systemctl` | Service log analysis |

---

> 💬 **Pro Tip:**  
In interviews, always explain **“how you’d diagnose step by step”** instead of just listing commands. It shows real-world problem-solving skills.


