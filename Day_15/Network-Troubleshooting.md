# 🧠 Network Troubleshooting — Real-Time Interview Guide

A practical collection of **network troubleshooting interview questions**, explained with **real commands**, **real-time examples**, and **step-by-step reasoning** — essential for **DevOps, SRE, or System Engineer** interviews.

---

## ⚙️ 1️⃣ How do you check your IP address and network interfaces?

### 🔹 Real-Time Answer:
To view IP configuration and network interfaces:
```bash
ip addr show
# or short view
ip -br a
```
**Example Output:**
```
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
    inet 192.168.1.10/24 brd 192.168.1.255 scope global eth0
```
### 💡 Use Case:
- To verify IP address and subnet after provisioning a VM or container.  
- Confirms interface status (UP/DOWN).

---

## ⚙️ 2️⃣ What’s the difference between TCP and UDP?

### 🔹 Real-Time Answer:
- **TCP** → Reliable, connection-oriented, ordered data delivery (used by SSH, HTTP, HTTPS).  
- **UDP** → Fast, connectionless, no guarantee of delivery (used by DNS, video streaming).

### 💻 Examples:
```bash
# TCP connection test (HTTP)
curl -v http://example.com

# UDP example (DNS query)
dig google.com
```

**In Interviews:** Mention TCP = Reliable but slower, UDP = Fast but less reliable.

---

## ⚙️ 3️⃣ How do you test if a remote host is reachable?

### 🔹 Real-Time Answer:
Use **ping** or **traceroute** to verify connectivity and path.
```bash
ping -c 4 8.8.8.8
traceroute google.com
```
**Example Output:**
```
64 bytes from 8.8.8.8: icmp_seq=1 ttl=118 time=25.2 ms
```
### 💡 Common Issues:
- If **ping fails** → ICMP blocked or no route.  
- If **traceroute stops midway** → Intermediate hop/firewall issue.

---

## ⚙️ 4️⃣ What command shows which ports are listening?

### 🔹 Real-Time Answer:
```bash
sudo ss -tuln
sudo ss -tulnp     # with process info
```
**Example Output:**
```
LISTEN 0 128 *:22 *:* users:(("sshd",pid=940,fd=3))
```
### 💡 Use Case:
Useful when debugging why an app isn’t reachable (e.g., Nginx or Node.js not running).

---

## ⚙️ 5️⃣ How do you perform a DNS lookup?

### 🔹 Real-Time Answer:
```bash
dig google.com +short
nslookup google.com
```
**Example Output:**
```
142.250.193.206
```
### 💡 Troubleshooting Tip:
If DNS fails:
```bash
cat /etc/resolv.conf
```
Check that it includes a valid DNS server, such as `8.8.8.8`.

---

## ⚙️ 6️⃣ What’s the purpose of a default gateway?

### 🔹 Real-Time Answer:
The **default gateway** routes traffic **outside your local subnet**.
```bash
ip route
```
**Example Output:**
```
default via 192.168.1.1 dev eth0
192.168.1.0/24 dev eth0 proto kernel scope link src 192.168.1.10
```
### 🧠 Simple Explanation:
- `default` → Traffic to unknown networks goes this way.  
- `via 192.168.1.1` → Router IP used for outgoing packets.  
- `dev eth0` → Interface used to reach gateway.

### 💡 Real-Life Example:
If you can ping local IPs but **not Google**, your default gateway may be missing or misconfigured.

In interviews, explain that you check the default route with ip route to confirm outbound connectivity.
If the default route is missing, the VM or server cannot access the internet or external services (like APIs or updates).

---

## ⚙️ 7️⃣ How do you troubleshoot “can ping IP but not hostname”?

### 🔹 Real-Time Answer:
That’s a **DNS resolution problem**.

### 🧭 Steps:
1. Check your DNS configuration:
   ```bash
   cat /etc/resolv.conf
   ```
2. Test DNS:
   ```bash
   dig google.com
   ```
3. Compare:
   ```bash
   ping 8.8.8.8
   ping google.com
   ```
If IP works but hostname fails → Fix `/etc/resolv.conf` or restart DNS resolver:
```bash
sudo systemctl restart systemd-resolved
```

---

## ⚙️ 8️⃣ What does “Connection Refused” vs “Connection Timeout” mean?

### 🔹 Real-Time Explanation:

| Term                   | Meaning                        | Likely Cause                           |
| ---------------------- | ------------------------------ | -------------------------------------- |
| **Connection Refused** | Host reachable but port closed | Service not running or port blocked    |
| **Connection Timeout** | No response from host          | Firewall, routing, or host unreachable |

---

### 🔹 Real-Time Telnet Example

```bash
# Test SSH port (22)
telnet 34.47.225.94 22
```

**Output:**

```
Trying 34.47.225.94...
Connected to 34.47.225.94.
Escape character is '^]'.
SSH-2.0-OpenSSH_9.9p1 Ubuntu-3ubuntu3.2
```

**Interpretation:**

* Successfully connected → SSH service is running and reachable.
* Shows SSH server version (`OpenSSH_9.9p1`).

```bash
# Test HTTP port (80)
telnet 34.47.225.94 80
```

**Output:**

```
Trying 34.47.225.94...
^C
```

**Interpretation:**

* Connection timed out → port 80 is not reachable.
* Possible reasons:

  * Service not running on port 80
  * Firewall/security group blocking the port
  * Network issue

---

### 🧠 Key Takeaways:

* **Connection Refused** → Service exists but port is closed
* **Connection Timed Out** → Network/firewall issue
* `telnet` is a quick tool to verify **port-level connectivity** in real-time

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
### 💡 Use Case:
If a web app fails to start because port 80 is “already in use,” use these to identify and stop the conflict.

---

## ⚙️ 🔟 Walk me through diagnosing a network connectivity issue.

### 🔹 Real-Time Approach (Based on OSI Model)

| Layer | Check | Command / Action |
|-------|-------|------------------|
| **L1 — Physical** | Cable, link | `ip link show`, `ethtool eth0` |
| **L2 — Data Link** | MAC/ARP issues | `arp -n` |
| **L3 — Network** | IP, routes | `ping`, `ip route` |
| **L4 — Transport** | Ports & sockets | `ss -tuln`, `telnet host port` |
| **L5–L7 — Application** | DNS, service logs | `dig`, `curl`, app logs |

### 🧠 Example Case:
```bash
ping 8.8.8.8   # Works
ping google.com  # Fails
```
➡ Root Cause → DNS issue.  
✅ Fix → Update `/etc/resolv.conf` or restart resolver.

---

## 🧩 Summary — Key Tools to Remember

| Tool | Purpose |
|------|----------|
| `ip`, `ifconfig` | Interface info |
| `ping`, `traceroute` | Connectivity test |
| `ss`, `netstat`, `lsof` | Port monitoring |
| `dig`, `nslookup` | DNS checks |
| `ip route` | Gateway and routing |
| `telnet`, `nc` | Port testing |
| `journalctl`, `systemctl` | Service log check |

---

## 🚀 Bonus — Real-Time Scenario (DevOps/SRE)

### 🧩 Issue:
Web application not reachable on port 8080.

### 🔍 Troubleshooting:
```bash
sudo ss -tulnp | grep 8080   # Check if app is listening
sudo ufw status              # Check firewall
curl -v http://localhost:8080
```
### ✅ Fix:
Service was down → Restarted application.  
Always verify with:
```bash
systemctl status myapp
```

---

### 🎯 Quick Recap
- Always start from **Layer 1 → Layer 7**.  
- Use `ping`, `traceroute`, `dig`, `ss`, and `ip route` regularly.  
- Understand errors (`refused`, `timeout`) to pinpoint layer issues.

---
