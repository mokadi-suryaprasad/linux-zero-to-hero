# Day 02: Virtualization & Linux Setup (VirtualBox Hands-On)

## 🎯 Learning Goals
By the end of today, you will:
- Know what virtualization is and why it matters
- Understand hypervisors (Type 1 vs. Type 2)
- Install and run a Linux VM in VirtualBox
- Practice network checks, snapshots, and VM tweaks
- Learn the basics of the Linux boot process
- Troubleshoot small VM issues

**Time Needed:** 1–2 hours  

---

## 🌍 Why Virtualization?
Virtualization means creating a **virtual computer (VM)** inside your real one.  
- Safe: You can test Linux without harming your laptop.  
- Cloud-like: Most servers in AWS/GCP are just VMs.  
- Useful for DevOps, SRE, and Cloud roles:  
  - **DevOps:** Test scripts safely  
  - **SRE:** Use snapshots to undo mistakes  
  - **Cloud:** Practice with VMs that act like cloud servers  

👉 Think of a VM as a **hotel room inside your house**. Your house = real laptop, hotel rooms = VMs.

---

## 🖥️ What is Virtualization?
Virtualization is when software divides your hardware (CPU, RAM, Disk) into smaller parts and lets multiple systems (VMs) run at the same time.  

### Key Ideas
- **Host Machine:** Your real computer  
- **Guest Machine:** The VM (like Ubuntu Linux)  
- **Hypervisor:** Software that manages VMs (e.g., VirtualBox)  

### Benefits
- Save cost: One machine → many VMs  
- Isolation: One VM crash doesn’t affect others  
- Testing: Try experiments with snapshots  
- Security: Sandbox for malware or risky tests  

### Drawbacks
- Slight performance loss (5–15%)  
- More complexity in setup and management  

---

## ⚙️ Hypervisors
A **hypervisor** is the software that runs and manages VMs.  

### Types
| Type | Runs On | Examples | Best For |
|------|---------|----------|----------|
| **Type 1 (Bare Metal)** | Directly on hardware | VMware ESXi, KVM, Hyper-V | Data centers, production servers |
| **Type 2 (Hosted)** | On top of host OS | VirtualBox, VMware Workstation | Learning, testing on laptops |

👉 We use **VirtualBox (Type 2)** for learning.

---

## 🚀 The Linux Boot Process (Quick Peek)
When a VM starts, Linux boots in steps:  
1. **POST & BIOS/UEFI** → hardware check  
2. **Bootloader (GRUB)** → loads kernel  
3. **Kernel** → prepares system and mounts root filesystem  
4. **Init system (systemd)** → starts services (network, ssh, etc.)  
5. **User Space** → login screen / terminal ready  

**Tip for Interviews:** “Linux boot = BIOS → GRUB → Kernel → systemd → User login.”

---

## 🛠️ Install Ubuntu VM in VirtualBox

### Prerequisites
- Download VirtualBox + Extension Pack → [virtualbox.org](https://www.virtualbox.org)  
- Download Ubuntu ISO → [ubuntu.com/download](https://ubuntu.com/download/desktop)  

### Step 1: Create VM
1. Open VirtualBox → New  
2. Name: `MyUbuntuLab`  
3. ISO: Ubuntu 25.04 ISO  
4. Memory: 4 GB | CPUs: 2  
5. Disk: 30 GB (VDI, dynamic)  

### Step 2: Configure Settings
- Enable EFI  
- Display: 128 MB Video RAM, enable 3D  
- Network: NAT (easy internet access)  
- Attach ISO in storage  

### Step 3: Install Ubuntu
1. Boot VM → “Install Ubuntu”  
2. Follow wizard → Use whole disk (VM only)  
3. Username: `linuxthefinalboss`  
4. Install → Restart → Remove ISO  

🎉 Ubuntu is ready! Login and open terminal.

---

## 🔍 First VM Experiments

### Check Updates
```bash
sudo apt update && sudo apt upgrade -y
```
### Check Network
```bash
ping google.com
curl ifconfig.me
```
### Take a Snapshot

- Machine → Take Snapshot → “Fresh Install”

- Make change → Take another snapshot

- Restore back if needed

👉 Snapshots = undo button for VMs.

### Simple Tweak
``` bash
sudo hostnamectl set-hostname my-lab-vm
reboot
```
### 🌐 Multi-VM Networking (Bridge Mode)

- NAT = VM can access internet, but not seen by other machines
- Bridge = VM gets real IP, can talk to host + other VMs

### Try It

- Create 2 VMs

- Switch network to Bridge

- Find IPs (ip addr show)

- Test ping between them

# Virtualization & Linux Interview Questions

## 1. What is VirtualBox?
VirtualBox is an open-source **type 2 hypervisor** developed by Oracle.  
It allows you to run multiple operating systems (called *guest OS*) on a single physical machine (called *host OS*).  
Example: You can run Linux inside a Windows system using VirtualBox.

---

## 2. Difference between Type 1 and Type 2 Hypervisors
| Feature | Type 1 (Bare-metal) | Type 2 (Hosted) |
|---------|----------------------|-----------------|
| Installation | Runs directly on hardware | Runs on top of host OS |
| Performance | Faster, more efficient | Slightly slower |
| Examples | VMware ESXi, Microsoft Hyper-V, Xen | VirtualBox, VMware Workstation |
| Use case | Data centers, enterprise | Personal use, development, testing |

---

## 3. Why use Snapshots?
- A **snapshot** is like a "point-in-time copy" of a VM’s state.  
- It saves the **disk, memory, and settings** at a particular time.  
- Benefits:
  - Rollback to a safe state after making changes.
  - Useful for testing software or updates.
  - Saves time compared to reinstalling an OS.

---

## 4. How do you check network in a VM?
Inside the virtual machine (Linux):
```bash
ifconfig      # Shows IP address, requires net-tools
ip addr show  # Modern alternative to check IP and interfaces
ping 8.8.8.8  # Test network connectivity
ping google.com  # Test DNS resolution
netstat -tulnp   # Check open ports
```
#### In VirtualBox settings:

- Check Network Adapter mode:

  - NAT → Uses host’s internet.

  - Bridged → VM gets its own IP in the same network.

  - Host-Only → Communication only between host and VM.

# Linux Boot Process

## 5. Steps in Linux Boot Process

### 1. BIOS / UEFI
- Performs **hardware initialization**.
- Runs **Power-On Self-Test (POST)** to check hardware (CPU, RAM, Disk, etc.).
- Searches for a **bootable device** (HDD, SSD, USB, CD/DVD).

---

### 2. MBR / GPT
- **MBR (Master Boot Record)** or **GPT (GUID Partition Table)** stores partition and boot information.
- Passes control to the **bootloader**.

---

### 3. Bootloader (GRUB)
- **GRUB (Grand Unified Bootloader)** is the most common bootloader.
- Loads and allows selection of the **OS kernel**.

---

### 4. Kernel
- The **Linux kernel** is loaded into memory.
- Initializes:
  - CPU
  - Memory
  - Device drivers
  - Mounts the **root filesystem**.

---

### 5. Init / systemd
- The first process started (PID **1**).
- **systemd** (or older `init`) starts all necessary services:
  - Networking
  - SSH
  - Login services

---

### 6. Runlevel / Targets
- Defines the system mode:
  - **Multi-user (CLI mode)** → Text-based login.
  - **Graphical (GUI mode)** → Desktop environment.

---

### 7. Login Prompt
- Finally, the **user is presented with a login screen**.
- After login, the system is fully ready to use.

---

✅ This is a clear step-by-step explanation of the **Linux Boot Process**, useful for interview preparation.


