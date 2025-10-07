# Day 04: Linux Boot Process & Service Management

## Learning Objectives
By the end of Day 4, you will:
- Understand the complete Linux boot process
- Manage services using systemctl
- View and analyze boot logs
- Configure services to start at boot
- Troubleshoot boot and service issues

**Estimated Time:** 1 hour

## Quick Recap: The Linux Boot Process
When your VM starts, it "wakes up" in steps watch it to feel the flow.

The Linux boot is a choreographed sequence turning hardware into a usable OS.

### Detailed Step-by-Step
<img width="1080" height="1080" alt="Blue White Colorful Townhall Meeting Instagram Post (7)" src="https://github.com/user-attachments/assets/2b22042a-500a-4ba9-b306-48788e2d2f75" />

1. **Power-On Self-Test (POST) & Firmware (BIOS/UEFI):** 
   - Hardware powers up; firmware (BIOS legacy or UEFI modern) tests components (CPU, RAM, disks). In VMs, hypervisor emulates this (~1-2s).
   - Locates boot device (e.g., /dev/sda in VM disk). UEFI uses GPT partitions; BIOS MBR.

2. **Bootloader Stage (GRUB2):**
   - GRUB (GNU GRand Unified Bootloader) loads from boot sector. Scans /boot/grub/grub.cfg for kernels (vmlinuz-*).
   - Shows menu (hold Shift); user selects entry. Passes params (e.g., root=/dev/sda1) to kernel.
   - Chains to other OSes if dual-boot. Time: <5s.

3. **Kernel Initialization:**
   - Kernel (bzImage) decompresses into RAM. Mounts initramfs (compressed FS with early drivers).
   - Probes hardware (via modules like virtio for VMs), sets up memory (paging), mounts real root FS (/).
   - Starts PID 1 (systemd or init). ****Logs to dmesg. Time: 5-20s.

4. **Init System (systemd):**
   - systemd reads /etc/fstab for mounts; parses units in /lib/systemd/system.
   - Reaches default target (multi-user.target for servers; graphical.target for desktops).
   - Starts services parallel (e.g., NetworkManager, sshd). Time: 10-60s.
   - What is a runlevel? A runlevel is a legacy SysVinit numeric system state (0–6) defining which set of startup/shutdown scripts (services) should be active. systemd replaces these with named, dependency-driven targets (e.g., multi-user.target, graphical.target) that are more flexible.
     
Runlevel Mapping (for legacy reference):
| Legacy Runlevel | systemd Target | Meaning |
|-----------------|----------------|---------|
| 0 | `poweroff.target` | Halt system |
| 1 | `rescue.target` | Single-user (maintenance) |
| 3 | `multi-user.target` | Non-graphical multi-user |
| 5 | `graphical.target` | Multi-user + GUI |
| 6 | `reboot.target` | Reboot |
| S/Emergency | `emergency.target` | Minimal root shell |
Default target symlink: `/etc/systemd/system/default.target`.

5. **User Space & Login:**
   - getty spawns on tty/SSH; PAM authenticates user.
   - Shell (bash) loads ~/.profile; prompt appears. GUI: display manager (gdm) starts X11/Wayland.
  
     
- **Service Management with systemd:**
  ```bash
  # Service control
  systemctl status <service>     # Show service status
  systemctl start <service>      # Start a service
  systemctl stop <service>       # Stop a service
  systemctl restart <service>    # Restart a service
  systemctl reload <service>     # Reload config without restart
  
  # Boot management
  systemctl enable <service>     # Enable service at boot
  systemctl disable <service>    # Disable service at boot
  systemctl is-enabled <service> # Check if enabled
  
  # Information
  systemctl list-units --type=service        # List all services
  systemctl list-units --state=failed        # List failed services
  systemctl list-unit-files --type=service   # List all service files
  
  # Logs
  journalctl -u <service>        # View logs for service
  journalctl -u <service> -f     # Follow logs in real-time
  journalctl -b                  # Boot logs
  ```

- **Checking Boot Logs:**
  ```bash
  # Kernel messages
  dmesg                    # Kernel ring buffer
  dmesg | grep -i error    # Filter for errors
  dmesg -T                 # Human-readable timestamps
  
  # System logs
  journalctl -b            # Current boot logs
  journalctl -b -1         # Previous boot logs
  journalctl --list-boots  # List all boots
  journalctl -p err        # Error priority and above
  journalctl --since "1 hour ago"  # Recent logs
  ```

## Quick NGINX Service Management Demo (Hands-On)
### 0. Prerequisites
- You have sudo access.
- Port 80 is free (no Apache or another web server running).
- Package manager differs by distro:
  - Debian/Ubuntu: `apt`
  - RHEL/CentOS/Rocky/Alma/Amazon Linux: `yum` or `dnf`

### 1. Install NGINX
```bash
# Debian/Ubuntu
sudo apt update
sudo apt install -y nginx

# RHEL/CentOS (if EPEL needed on older versions)
sudo yum install -y nginx
# or
sudo dnf install -y nginx
```

### 2. Check the Service File & Status
```bash
systemctl status nginx
systemctl list-unit-files | grep -i nginx
```

### 3. Start the Service
```bash
sudo systemctl start nginx
systemctl status nginx --no-pager
```

### 4. Enable at Boot
```bash
sudo systemctl enable nginx
systemctl is-enabled nginx
```

### 5. Verify Listening Port
```bash
ss -tlnp | grep :80   # or: sudo lsof -i :80
```

### 6. Test Default Page
```bash
curl -I http://localhost
# Expect: HTTP/1.1 200 OK
```
(Optional in browser: http://<server_ip>)

### 7. Modify a Simple Page
```bash
sudo bash -c 'echo "<h1>NGINX Demo $(hostname)</h1>" > /var/www/html/index.nginx-debian.html'
curl http://localhost
```

### 8. Test Config Before Reload
```bash
sudo nginx -t
```
Always do this before reload/restart after edits.

### 9. Reload (Zero-Downtime Config Apply)
```bash
sudo systemctl reload nginx
```

### 10. View Logs
```bash
# Systemd journal
journalctl -u nginx -n 20
journalctl -u nginx -f

# Access and error logs
sudo tail -f /var/log/nginx/access.log /var/log/nginx/error.log
```

### 11. Restart vs Reload
```bash
sudo systemctl restart nginx   # Full stop/start (connections dropped)
sudo systemctl reload nginx    # Graceful (keeps connections)
```

### 12. Temporarily Stop & Disable
```bash
sudo systemctl stop nginx
sudo systemctl disable nginx
systemctl is-enabled nginx
```

### 13. Re-enable & Start Again
```bash
sudo systemctl enable --now nginx
```

### 14. Show Startup Time Impact (Optional)
```bash
systemd-analyze blame | grep -i nginx || true
```

### 15. Create a Drop-In Override (Customization)
Add environment variable or change restart policy without editing the main unit:
```bash
sudo systemctl edit nginx
```
Add:
```
[Service]
Environment=APP_ENV=demo
```
Then:
```bash
sudo systemctl daemon-reload
sudo systemctl restart nginx
systemctl show nginx | grep -i APP_ENV
```
Remove override:
```bash
sudo rm -r /etc/systemd/system/nginx.service.d
sudo systemctl daemon-reload
```

### 16. Uninstall (Optional Cleanup)
```bash
# Debian/Ubuntu
sudo apt remove -y nginx
sudo apt purge -y nginx
sudo rm -rf /var/log/nginx /etc/nginx

# RHEL/CentOS
sudo yum remove -y nginx
```
## Key Commands Summary
```bash
# Service management
systemctl status|start|stop|restart <service>
systemctl enable|disable <service>
systemctl list-units --type=service

# Logs and diagnostics
journalctl -u <service>
dmesg
systemd-analyze

# Boot analysis
journalctl -b
systemd-analyze blame
```