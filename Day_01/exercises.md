# Day 01 – Exercises & Practice

## 🛠️ Hands-on Lab (GCP Free Tier)

### Step 1: Launch 2 Compute Engine Instances
1. **Debian/Ubuntu Server (Debian-based)**  
2. **Rocky Linux / CentOS Stream (RHEL-based)**  

> Select these from **GCP Console → Compute Engine → Create Instance → Boot Disk**.

---

### Step 2: Connect with SSH
Using **GCP Web SSH**:  
- Go to **Compute Engine → VM Instances → SSH**  

Or via local terminal (if `gcloud` CLI is installed):  
```bash
gcloud compute ssh ubuntu-vm --zone asia-south1-a
gcloud compute ssh rocky-vm --zone asia-south1-a
```