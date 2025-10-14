# 🧰 Day 12: Compression, Archiving, and Backups — With Real-Time Scenarios

## 🎯 Learning Objectives

By the end of this session, you’ll be able to:

- Compress and decompress files using multiple tools  
- Archive project directories efficiently  
- Automate scheduled backups using cron  
- Verify and test backups (critical for disaster recovery)  
- Understand full, incremental, and differential backups with examples  

**⏱ Estimated Time:** 45–60 mins (real practice)

---

## 🧩 Real-Time Scenario

You are a **DevOps Engineer** managing the `/opt/app` directory containing:
- Application configs  
- Shell scripts  
- Log files  

Your goals:
1. Compress logs daily  
2. Archive entire app data weekly  
3. Automate backup to `/mnt/backup`  
4. Verify that the backups are valid and restorable  

Let’s build this step-by-step 👇

---

## 🧱 Step 1: Environment Setup

Create a local environment to simulate production backup operations.

```bash
mkdir -p ~/day12_test/{data,backups,scripts}
echo "Important data line 1" > ~/day12_test/data/file1.txt
echo "Sample config" > ~/day12_test/data/config.ini
dd if=/dev/zero of=~/day12_test/data/bigfile.dat bs=1M count=512 status=progress
```

This simulates:
- Text files (configs, logs)
- Large binary file (app data)
- Folder structure used in backup operations

---

## 🗜️ Step 2: Compression

Compression helps save space and speed up transfer.

### 🔹 Common Tools
| Tool | Algorithm | File Extension | Speed | Compression Ratio |
|------|------------|----------------|--------|--------------------|
| gzip | DEFLATE | `.gz` | Fast | Medium |
| bzip2 | Burrows–Wheeler | `.bz2` | Medium | Better |
| xz | LZMA2 | `.xz` | Slow | Best |

### 🔹 Examples

```bash
# Compress using gzip
gzip ~/day12_test/data/bigfile.dat

# Decompress
gunzip ~/day12_test/data/bigfile.dat.gz

# Compress using bzip2
bzip2 ~/day12_test/data/file1.txt

# Compress using xz
xz ~/day12_test/data/config.ini
```

### 🔹 Compare File Sizes

```bash
du -sh ~/day12_test/data/*
```

🧠 **Tip:** For bulk compression:

```bash
tar -cvf - ~/day12_test/data | gzip > data_backup_$(date +%F).tar.gz
```

---

## 📦 Step 3: Archiving

Archiving combines multiple files into a single package.

### 🔹 Basic Archive Example

```bash
# Create compressed archive
tar -czvf ~/day12_test/backups/app_data_$(date +%F).tar.gz ~/day12_test/data/

# Extract the archive
tar -xzvf ~/day12_test/backups/app_data_$(date +%F).tar.gz -C ~/day12_test/restore/

# List contents before extracting
tar -tzf ~/day12_test/backups/app_data_$(date +%F).tar.gz
```

### 🔹 Exclude Temporary Files

```bash
tar -czvf ~/day12_test/backups/app_data_clean.tar.gz --exclude='*.tmp' --exclude='junk.log' ~/day12_test/data/
```

---

## 💾 Step 4: Backups

Use `rsync` for **incremental** and **differential** backups.

### 🔹 Full Backup
Copies everything the first time.

```bash
rsync -av --delete ~/day12_test/data/ ~/day12_test/backups/full/
```

### 🔹 Incremental Backup
Copies **only changed files**.

```bash
rsync -av --delete --link-dest=~/day12_test/backups/full/ ~/day12_test/data/ ~/day12_test/backups/inc_$(date +%F)/
```

### 🔹 Differential Backup (simplified)
Compare against last full backup manually.

```bash
rsync -av --compare-dest=~/day12_test/backups/full/ ~/day12_test/data/ ~/day12_test/backups/diff_$(date +%F)/
```

🧠 **Real-World Tip:** Use `rsync -aHAX` to preserve all file permissions and attributes.

---

## 🔍 Step 5: Verification

Always validate that backups are **complete and uncorrupted**.

### 🔹 Check Integrity Using Checksums

```bash
tar -czf ~/day12_test/backups/data.tar.gz ~/day12_test/data/
sha256sum ~/day12_test/backups/data.tar.gz > ~/day12_test/checksums.txt

# Verify
sha256sum -c ~/day12_test/checksums.txt
```

If output shows **“OK”**, your archive is valid ✅.

### 🔹 Restore and Compare

```bash
mkdir -p ~/day12_test/restore/
tar -xzf ~/day12_test/backups/data.tar.gz -C ~/day12_test/restore/

diff -r ~/day12_test/data ~/day12_test/restore/data
```

If there’s **no output**, both directories are identical.

---

## ⚙️ Step 6: Automate with Cron

You can automate backups with a simple shell script.

### 🔹 Create `backup.sh`

```bash
#!/bin/bash
# ~/day12_test/scripts/backup.sh

SRC_DIR=~/day12_test/data
DEST_DIR=~/day12_test/backups
LOG_FILE=~/day12_test/backup.log

DATE=$(date +%F_%H-%M-%S)
ARCHIVE=$DEST_DIR/app_backup_$DATE.tar.gz

echo "[$(date)] Starting backup..." >> $LOG_FILE
tar -czf $ARCHIVE $SRC_DIR
sha256sum $ARCHIVE >> $DEST_DIR/checksums.txt

echo "[$(date)] Backup completed: $ARCHIVE" >> $LOG_FILE
```

Make it executable:
```bash
chmod +x ~/day12_test/scripts/backup.sh
```

### 🔹 Add Cron Job

```bash
crontab -e
```

Add entry to run every night at 2 AM:
```bash
0 2 * * * ~/day12_test/scripts/backup.sh >> /tmp/backup.log 2>&1
```

For quick testing:
```bash
*/5 * * * * ~/day12_test/scripts/backup.sh
```

---

## 🧰 Step 7: Restore Simulation

To simulate restoring from backup:

```bash
mkdir -p ~/day12_test/restore/
tar -xzf ~/day12_test/backups/app_backup_*.tar.gz -C ~/day12_test/restore/

echo "Restore completed successfully."
```

Verify restoration:
```bash
diff -r ~/day12_test/data ~/day12_test/restore/data
```

---

## ✅ Best Practices

- Use **gzip** for speed, **xz** for higher compression  
- Always verify archives before deleting source data  
- Keep **offsite** backups (cloud / remote servers)  
- Encrypt sensitive data backups using **gpg**  
- Follow **3-2-1 rule**:  
  - 3 copies  
  - 2 media types  
  - 1 offsite  

---

## 🧠 Summary Table

| Type | Description | Tool |
|------|--------------|------|
| Compression | Reduces file size | gzip, bzip2, xz |
| Archiving | Combines multiple files | tar |
| Backup | Syncs and copies data | rsync |
| Verification | Confirms data integrity | sha256sum |
| Automation | Schedules backup jobs | cron |

---

