# Day 01: What is Linux? (Kernel, Distributions & Ecosystem)

## 🎯 Learning Goals
By the end of Day 1, you should:
- Know what Linux is and where it came from  
- Understand the **Linux kernel** and what it does  
- Learn what **Linux distributions** (distros) are and when to use them  
- Get a picture of the **Linux ecosystem** and open-source world  
- See why Linux is important for **DevOps, SRE, and Cloud Engineers**  
- Understand the basics of **package managers** (installing/updating software)  

**Time needed:** 1–2 hours  

---

## 🌍 Why Learn Linux?
Linux is **everywhere**:
- Servers running the internet  
- Cloud platforms (AWS, GCP, Azure)  
- Supercomputers  
- Android phones  
- IoT devices  

For DevOps, SRE, and Cloud Engineers:
- Most tools (Docker, Kubernetes, Terraform, Jenkins) are **built for Linux**  
- Cloud VMs usually run on Linux  
- Linux helps with automation, scaling, and high uptime  

👉 Fact: More than **96% of top servers** and **all top supercomputers** use Linux.  

---

## 🐧 What is Linux?
- Linux = **kernel** (the brain of the OS) created by Linus Torvalds in 1991.  
- A **distribution (distro)** = Linux kernel + tools + apps (like Ubuntu, RHEL, CentOS, etc.).  
- Used for servers, desktops, embedded systems, mobiles, and more.  

💡 **Analogy:** Kernel = car’s engine. Distribution = complete car (engine + body + wheels).  

---

## 📜 Short History of Linux
- **1983:** GNU Project started by Richard Stallman  
- **1991:** Linus Torvalds released first Linux kernel  
- **1993:** Debian project began  
- **2000s:** Linux became popular in servers and embedded systems  
- **2010s:** Powering Android, cloud, and containers  
- **Today:** Runs most of the internet and cloud workloads  

---

## ⚙️ Core Components of Linux

### Main Parts:
- **Kernel:** Manages CPU, memory, processes, files, networking  
- **Shell:** Command-line tool (bash, zsh, etc.)  
- **Utilities:** Basic commands (`ls`, `cat`, `systemctl`)  
- **User Apps:** Extra software (web servers, Docker, etc.)  

---

## 🖥️ Linux vs Windows (Quick Compare)

| Feature | Linux | Windows | Why it matters |
|---------|-------|---------|----------------|
| Source | Open source | Closed | Open = free & flexible |
| Cost | Free | Paid | Saves $$ in cloud |
| File System | `/` root structure | C:, D: drives | Easier automation |
| Case Sensitive | Yes | No | Prevents confusion in scripts |
| Stability | Very stable (years uptime) | Needs reboots | Critical for production |
| Package Mgmt | apt, yum, dnf | .exe, .msi | Faster installs/updates |

---

## 📦 Linux Distributions (Distros)
A distro = Linux kernel + GNU tools + package manager + apps.  

Popular ones:
- **Ubuntu, Mint** → Beginner-friendly  
- **RHEL, CentOS, Ubuntu Server** → Enterprise & cloud  
- **Alpine Linux** → Lightweight (great for Docker containers)  
- **Kali Linux** → Security testing  

---

## 🌐 Linux Ecosystem
- **GNU Tools** → basic utilities (bash, ls, gcc)  
- **Package Managers** → install/update software  
- **Container Tools** → Docker, Kubernetes  
- **Cloud** → Linux is default OS in AWS, GCP, Azure  

### Example Package Managers
| Distro | Package Manager | Example |
|--------|----------------|---------|
| Ubuntu/Debian | `apt` | `sudo apt install nginx` |
| RHEL/CentOS/Fedora | `yum`/`dnf` | `sudo dnf install nginx` |
| Arch Linux | `pacman` | `sudo pacman -S nginx` |

---

# How `ls` Command Works in Linux

This file explains what happens when we type the `ls` command in Linux.

---

## 1. You Type `ls`
- You type `ls` in the terminal.
- The shell (like `bash`) receives your command.

---

## 2. Shell Finds the Command
- The shell checks if `ls` is a built-in command. (It is not.)
- Then it looks in the folders listed in the `$PATH` variable.
- It finds the program at `/bin/ls`.

```bash
echo $PATH
/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
```
### 3. Kernel Starts the Program

- The shell asks the Linux kernel to run /bin/ls.

- The kernel:

  - Loads the ls program into memory.

  - Creates a new process for it.

  - Connects input, output, and error to the terminal.

### 4. ls Runs

- The ls program asks the system for:

  - Directory contents (opendir, readdir)

  - File details (stat)

- It collects names, sizes, owners, and permissions.

### 5. Show the Result

- The program writes the result to stdout (your screen).

- The kernel sends the output to your terminal (/dev/tty).

### 6. End

- ls finishes and gives an exit code (0 if success).

- The shell shows a new prompt so you can type again.

### Simple Flow

You type ls
   ↓
Shell finds /bin/ls
   ↓
Kernel runs the program
   ↓
ls reads the folder details
   ↓
Shows result on screen
   ↓
Program ends, shell waits for next command

### Diagram

+------------+        +------------+        +-------------+
|   Shell    | -----> |   Kernel   | -----> |  Hardware   |
+------------+        +------------+        +-------------+
| You type   |        | Run /bin/ls|        | CPU, Memory |
| "ls"       |        | Make process|       | Disk, Screen|
| Finds PATH |        | Syscalls    |       | Output to   |
| Runs /bin/ls|       | - opendir   |       | terminal    |
+------------+        | - readdir   |       +-------------+
                      | - stat      |
                      +-------------+



# 🤔 Interview Questions with Answers (Day 01)

### 1. What is the difference between the Linux kernel and a Linux distribution?  
- **Kernel**: The core part of Linux, which talks to hardware and manages CPU, memory, and devices.  
- **Distribution**: A complete package (kernel + tools + package manager + apps) like Ubuntu, CentOS, Amazon Linux.  

---

### 2. Explain kernel space vs user space.  
- **Kernel space**: Where the kernel runs, managing hardware and system resources.  
- **User space**: Where user programs (like browsers, editors, etc.) run.  
- Programs in user space use **system calls** to talk to the kernel.  

---

### 3. Name 3 Linux distros and their cloud use cases.  
- **Ubuntu** → Popular for cloud servers and DevOps.  
- **Amazon Linux** → Used in AWS for EC2 instances.  
- **CentOS/RHEL** → Used in enterprise servers.  

---

### 4. How do package managers (apt/yum) work? Why important for DevOps?  
- **Package managers** help install, update, or remove software easily.  
- They also handle dependencies automatically.  
- Important in DevOps because we need to quickly set up and update servers.  

---

### 5. What is the role of the GNU Project?  
- The **GNU Project** provides many tools and utilities (like compilers, libraries, shell) that make Linux usable.  
- Without GNU, Linux would just be the kernel.  

---

### 6. Why is Linux preferred over Windows for servers?  
- It is free and open-source.  
- More stable and secure.  
- Uses fewer resources.  
- Better for automation and scripting.  

---

### 7. How to check kernel version? Why do cloud providers use older kernels?  
- Run:  
  ```bash
  uname -r
```

---

# ✅ Checklist
- [x] Know what Linux is & its history  
- [x] Understand kernel vs distribution  
- [x] Tried package managers (apt/yum)  
- [x] Launched 2 Linux instances  
- [x] Ran commands & scripts  
- [x] Prepared interview answers  

