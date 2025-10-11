# Troubleshooting Guide

## Common VirtualBox & VM Issues

---

### 1. VM Black Screen
**Problem:** VM screen is black after starting.  
**Solution:**
- Increase **Video Memory**: `Settings → Display → Video Memory` (set ≥ 128 MB).  
- Enable **3D Acceleration**.  
- Switch **Graphics Controller** to `VMSVGA` or `VBoxVGA`.  

---

### 2. No Internet in VM
**Problem:** VM cannot access the internet.  
**Solution:**
1. Check **Network Adapter** → NAT mode.  
2. Test host connectivity.  
3. Inside VM, run:
```bash
ping -c 4 8.8.8.8     # Test internet connection
ping -c 4 google.com  # Test DNS resolution
```
### 3. Slow GUI Performance

- Problem: VM is laggy or slow.
- Solution:

  - Enable 3D Acceleration in VM Display settings.

  - Allocate more RAM and CPUs.

  - Use Server ISO (CLI-only) if GUI is not needed.

### 4. Snapshot Error

- Problem: Cannot take or restore snapshot.
- Solution:

  - Ensure VM is powered off.

  - Check host disk space.

  - Avoid too many nested snapshots.

- Command to check disk usage:
``` bash
df -h
```
### 5. Installation Stuck

- Problem: OS install hangs.
- Solution:

  - Verify ISO checksum:
``` bash
  sha256sum ubuntu-25.04-desktop.iso
```
  - Re-download if corrupted.

  - Ensure ISO is correctly attached: Settings → Storage → Optical Drive.

### 6. Bridged Network – No Ping

- Problem: VMs on Bridged Adapter cannot ping each other.
- Solution:
  - Verify correct physical adapter in Network settings.
  - Disable firewall:
``` bash
sudo ufw disable
```
  - Restart network:
``` bash
sudo systemctl restart NetworkManager
```
  - Test connection:
``` bash
ping <Other-VM-IP>
```
