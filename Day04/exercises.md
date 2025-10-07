- **Best Practices:**
  - Only enable necessary services at boot
  - Regularly check service status and logs
  - Secure the bootloader with a password if needed
  - Keep kernel and initramfs updated

## Sample Exercises
1. List and describe each step of the Linux boot process.
2. Check the status of the `ssh` (or `sshd`) service and restart it.
3. Enable a service to start at boot and then disable it.
4. View the kernel boot messages and identify any errors.
5. List all running services and their status.


---

### **2. Check the status of the `ssh` (or `sshd`) service and restart it**
```bash
sudo systemctl status ssh
# or
sudo systemctl status sshd

# To restart the service
sudo systemctl restart ssh
```

### 3. Enable a service to start at boot and then disable it
``` bash
# Enable SSH service to start automatically on boot
sudo systemctl enable ssh

# Disable SSH service from starting on boot
sudo systemctl disable ssh
```

### 4. View the kernel boot messages and identify any errors

``` bash
# View all kernel messages
dmesg | less

# Filter and show only error messages
dmesg | grep -i error
```
### 5. List all running services and their status

``` bash
# Show all active (running) services
systemctl list-units --type=service --state=running

# Show all services (active and inactive)
systemctl list-units --type=service
```