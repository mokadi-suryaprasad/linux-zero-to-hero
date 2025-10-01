# Day 00 – Introduction to Linux 🐧

Welcome to **Day 00** of the **Linux Zero to Hero – 31 Day Series**.  
In this session, you will get an overview of **Linux**, its **importance**, the major **distributions**, and launch your **first Linux VM on Google Cloud Platform (GCP)**.

---

## 📌 Learning Objectives
By the end of this day, you will:
- Understand what Linux is and why it’s widely used in the industry.
- Learn about different Linux distributions (flavors).
- Set up your **first Linux virtual machine on GCP**.
- Be ready to start practicing Linux commands and DevOps workflows.

---

## 1️⃣ What is Linux?
- Linux is an **open-source, Unix-like operating system kernel** created by **Linus Torvalds** in 1991.  
- It powers **servers, supercomputers, IoT devices, Android smartphones, and cloud infrastructure**.  
- Linux provides **stability, security, and flexibility**, making it the backbone of modern IT systems.

---

## 2️⃣ Why Linux is Important?
| Reason | Details |
|--------|---------|
| Cloud & Servers | Used in **90%+ cloud servers** (AWS, GCP, Azure). |
| DevOps & Automation | Powers tools like **Docker, Kubernetes, Jenkins, Ansible**. |
| Security & Networking | Foundation for **firewalls, routers, and security appliances**. |
| Career Advantage | Essential for **DevOps Engineers, SREs, and Cloud Engineers**. |

---

## 3️⃣ Linux Flavors / Distributions
Common distributions and their use cases:  

| Distribution | Use Case |
|--------------|----------|
| Ubuntu | Beginner-friendly, widely used in cloud & DevOps. |
| Debian | Stable, server-focused. |
| CentOS / Rocky Linux | Enterprise-grade production systems. |
| Fedora | Cutting-edge, latest features. |
| Kali Linux | Penetration testing & security. |
| Arch Linux | Advanced, customizable system. |

> **Tip:** We will primarily use **Ubuntu 22.04 LTS** for hands-on practice.

---

## 4️⃣ Hands-On: Create a Linux VM in GCP

### Step 1: Login to GCP
- Go to [Google Cloud Console](https://console.cloud.google.com/).  
- Create a **new project** or select an existing one.

### Step 2: Enable Compute Engine
- Navigate to **Compute Engine → VM Instances**.  
- Click **Enable API** if prompted.

### Step 3: Create VM Instance
1. Click **Create Instance**.  
2. Name: `linux-lab-vm`  
3. Region & Zone: `asia-south1` (example)  
4. Machine Type: `e2-medium` (2 vCPU, 4 GB RAM)  
5. Boot Disk: **Ubuntu 22.04 LTS**  
6. Enable **Allow HTTP/HTTPS traffic** if required  
7. Click **Create**

### Step 4: Connect to VM
- Using **GCP Web SSH**: Click **SSH** next to your instance.  
- Or via **local terminal**:
```bash
gcloud compute ssh linux-lab-vm --zone asia-south1-a

### Step 5: Verify Linux Access

Once connected to your VM, run the following commands to confirm everything is working:

```bash
uname -a           # Display kernel information
lsb_release -a     # Show Linux distribution details
pwd                # Print the current working directory
