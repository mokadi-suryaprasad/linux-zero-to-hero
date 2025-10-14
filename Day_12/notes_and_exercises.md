# Day 12: Compression, Archiving, and Backups

## Learning Objectives
By the end of Day 12, you will:
- Master compression and archiving tools
- Implement effective backup strategies
- Automate backup processes
- Verify backup integrity
- Understand different backup types and use cases

**Estimated Time:** 30 mins

## Sample Environment Setup
Exercises are local, no VMs needed. Use your local machine (e.g., Ubuntu/Mac with Bash).
```
mkdir -p ~/day12_test/{data,backups,scripts}
echo "Important data line 1" > ~/day12_test/data/file1.txt
echo "Important data line 2" >> ~/day12_test/data/file1.txt
echo "Sample config" > ~/day12_test/data/config.ini
echo "Binary-like data" > ~/day12_test/data/binary.dat
cp ~/day12_test/data/file1.txt ~/day12_test/data/file2.txt
touch ~/day12_test/data/{temp.tmp,junk.log}
dd if=/dev/zero of=~/day12_test/data/bigfile.dat bs=1M count=1024 status=progress  # 1GB for compression demo
echo '#!/bin/bash\necho "Backup starting at $(date)"\ntar -czf /tmp/backup.tar.gz ~/day12_test/data/' > ~/day12_test/scripts/backup.sh
chmod +x ~/day12_test/scripts/backup.sh

# View initial state
ls -la ~/day12_test/data/
du -sh ~/day12_test/data/
du -sh ~/day12_test/data/bigfile.dat  # Verify ~1G
```

## Why These Tools Matter:
  - Essential for saving space, protecting data, and efficient transfers in Linux environments.
  - Critical for DevOps, SRE, and sysadmin roles to prevent data loss and optimize storage.

| Command | Simple Description | Examples |
|---------|--------------------|----------|
| **COMPRESSION**<br>`$ gzip file.txt` | Reduce file size. | 1. Basic: `gzip file.txt` (creates file.txt.gz)<br>2. Decompress: `gunzip file.txt.gz`<br>3. Keep original: `gzip -k file.txt` |
| **ARCHIVING**<br>`$ tar -cvf archive.tar dir/` | Bundle files into one. | 1. Create: `tar -czvf archive.tar.gz dir/`<br>2. Extract: `tar -xzvf archive.tar.gz`<br>3. List: `tar -tzf archive.tar.gz` |
| **BACKUP**<br>`$ rsync -av src/ dest/` | Sync/copy with smarts. | 1. Mirror: `rsync -av --delete ~/data/ ~/backup/`<br>2. Progress: `rsync -av --progress src/ dest/`<br>3. Exclude: `rsync -av --exclude='*.tmp' src/ dest/` |
| **VERIFY**<br>`$ sha256sum file` | Check integrity. | 1. Generate: `sha256sum archive.tar.gz > checksum.sha256`<br>2. Check: `sha256sum -c checksum.sha256`|

- **Compression Tools:**
  - Shrink files for storage/transfer. gzip (fast, good for text), bzip2 (better ratio, slower), xz (best ratio, slowest).
  - Parallel variants: pigz (parallel gzip), pbzip2 (parallel bzip2) for multi-core speed.

  **Examples:**
  - gzip: `gzip ~/day12_test/data/bigfile.dat` (1GB zeros → ~1KB!). Decompress: `gunzip ~/day12_test/data/bigfile.dat.gz`.
  - bzip2: `bzip2 ~/day12_test/data/file2.txt` (to .bz2). Decompress: `bunzip2 ~/day12_test/data/file2.txt.bz2`.
  - xz: `xz ~/day12_test/data/config.ini` (to .xz). Decompress: `unxz ~/day12_test/data/config.ini.xz`.
  - Compare: `du -sh ~/day12_test/data/bigfile.dat*` before/after to see size diffs.
  - zip (cross-platform): `zip archive.zip ~/day12_test/data/*.txt`; `unzip archive.zip`.

---

- **Archiving Tools:**
- tar (Tape ARchive) bundles files/directories, often with compression. Flags: c (create), x (extract), v (verbose), f (file), z (gzip), j (bzip2), J (xz).

| Operator | Description | Example |
|----------|-------------|---------|
| `-cvf` | Create verbose archive | `tar -cvf archive.tar ~/day12_test/data/` (bundles without compression) |
| `-xvf` | Extract verbose | `tar -xvf archive.tar` (unpacks to current dir) |
| `-czvf` | Create gzip-compressed | `tar -czvf archive.tar.gz ~/day12_test/data/` |
| `-xzvf` | Extract gzip | `tar -xzvf archive.tar.gz -C ~/extracted/` (to specific dir) |
| `-tzf` | List contents | `tar -tzf archive.tar.gz \| head -5` |

### Advanced tar:
- Exclude: `tar -czvf backup.tar.gz --exclude='*.tmp' --exclude='junk.log' ~/day12_test/data/`.
- Specific extract: `tar -xzvf archive.tar.gz data/file1.txt` (one file).

**Example:**
  - Create: `tar -czvf ~/day12_test/backups/data.tar.gz ~/day12_test/data/`.
  - List: `tar -tzf ~/day12_test/backups/data.tar.gz`.
  - Extract: `mkdir ~/day12_test/extracted && tar -xzvf ~/day12_test/backups/data.tar.gz -C ~/day12_test/extracted/`.

---

- **Backup Tools:**
  - rsync: rsync (remote sync) is a versatile file synchronization tool that copies files and directories efficiently, often over networks, by transferring only differences (delta-transfer algorithm). It's ideal for backups because it minimizes bandwidth/data usage, handles interruptions (resumable), and preserves file attributes like permissions, timestamps, ownership, and symlinks.
  - Copies only what's new/changed. Safe and fast. Key flags: -a (keep details), -v (show what happens).
  - cp: Simple copy (`cp -a` for archive mode).

  **Examples:**
  - rsync basic: `rsync -av ~/day12_test/data/ ~/day12_test/backups/mirror/`.
  - Strategies: Full (all data), Incremental (changes since last), Differential (changes since full).
    1. First copy: `mkdir ~/day12_test/backups/copy && rsync -av ~/day12_test/data/ ~/day12_test/backups/copy/` (full transfer).
    2. Change source: `echo "Change" >> ~/day12_test/data/bigfile.dat`.
    3. Sync again: `rsync -av ~/day12_test/data/ ~/day12_test/backups/copy/` (only delta—fast!).
    4. Skip junk: `rsync -av --exclude='*.tmp' ~/day12_test/data/ ~/day12_test/backups/clean/` (no .tmp files).
    5. Preview: `rsync -av --dry-run ~/day12_test/data/ ~/day12_test/backups/copy/` (shows plan, no action).
    6. Check: `ls ~/day12_test/backups/copy/` (matches source).

---

- **Automation & Verification:**
  - Checksums: sha256sum/md5sum for integrity.

  **Why sha256sum? (Quick 1-Sentence)**  
  It's a "digital fingerprint" tool: It scans a file and spits out a unique code (hash). If the file changes even a tiny bit (corruption!), the code changes. Generate once, check later = peace of mind for backups.

  **Real Demo: Step-by-Step (Copy-Paste Ready)**  
  Assume you've run your environment setup (creates `~/day12_test/data/` with files). Now, make a backup tar first (so we have something to check):  
  ```bash:disable-run
  tar -czf ~/day12_test/backups/data.tar.gz ~/day12_test/data/
  ```  
  (This packs your data folder into a compressed backup file. Check it exists: `ls ~/day12_test/backups/`.)

  **Step 1: Generate the Checksum (Save the "Fingerprint")**  
  ```bash
  sha256sum ~/day12_test/backups/data.tar.gz > ~/day12_test/checksums.txt
  ```  
  - What it does: Scans the tar file, makes a 64-char code, saves it to `checksums.txt` (format: `CODE  filename`).  
  - Real output (what you'd see—nothing prints, but check the file):  
    ```bash
    cat ~/day12_test/checksums.txt
    ```  
    ```
    6e99d8f6175caa5be5b85411ee5048bb25fa414361833d3035f5b8acf4d98197  /home/user/day12_test/backups/data.tar.gz
    ```  
    The long string? Your file's unique ID. (Yours might differ slightly based on your files—totally normal.)

  **Step 2: Verify It (Compare Fingerprint)**  
  ```bash
  sha256sum -c ~/day12_test/checksums.txt
  ```  
  - What it does: Re-scans the file, compares the new code to the saved one. `-c` = "check" mode.  
  - Real output (if all good):  
    ```
    /home/user/day12_test/backups/data.tar.gz: OK
    ```  
    "OK" = file is perfect (no changes/corruption).  
    If bad (e.g., you edit the tar): It says `WARNING: ... FAILED` + exit code 1 (error).

  **What If It Fails? (Quick Test)**  
  To see a "fail," tweak the file slightly:  
  ```bash
  echo "evil hack" >> ~/day12_test/backups/data.tar.gz  # Mess it up (don't do this IRL!)
  sha256sum -c ~/day12_test/checksums.txt
  ```  
  - Output:  
    ```
    /home/user/day12_test/backups/data.tar.gz: FAILED
    ```  
  - Fix: Re-make the tar and re-generate the checksum.

  **Cron: Automate Backups (Quick 1-Sentence)**  
  Cron is Linux's built-in scheduler—like an alarm clock for commands. Set it once, and it runs your backup script automatically (e.g., nightly).

  **Real Demo: Step-by-Step (Copy-Paste Ready)**  
  Your `backup.sh` script (from setup) already does a tar—now schedule it.  

  **Step 1: Edit Cron Jobs**  
  ```bash
  crontab -e
  ```  
  - What it does: Opens a text editor (nano/vi). Add one line at the end, save/exit (in nano: Ctrl+O, Enter, Ctrl+X).  
  - Add this line:  
    ```
    0 2 * * * ~/day12_test/scripts/backup.sh >> /tmp/backup.log 2>&1
    ```  
    (Runs at 2:00 AM daily; logs output to `/tmp/backup.log` for checking.)

  **Step 2: Test It Manually (Don't Wait for 2AM!)**  
  ```bash
  ~/day12_test/scripts/backup.sh
  ```  
  - What it does: Runs the script now—echoes timestamp, creates `/tmp/backup.tar.gz`.  
  - Real output:  
    ```
    Backup starting at Tue Oct 14 14:30:00 UTC 2025
    ```  
    (Check: `ls /tmp/backup.tar.gz` and `cat /tmp/backup.log`.)

  **Step 3: List & Remove (If Testing)**  
  ```bash
  crontab -l  # Shows your jobs
  crontab -r  # Removes all (for cleanup)
  ```  
  - What it does: `-l` lists; `-r` erases (safe for tests). For every 5 mins (test): Use `*/5 * * * *` instead of `0 2 * * *`.

  **Tar integrity:** `tar -tzf ~/day12_test/backups/data.tar.gz > /dev/null && echo "OK" || echo "Corrupt"`.

  **3-2-1 Rule:** 3 copies of data, on 2 different media, 1 offsite.

---

- **Best Practices:**
  - Compress before archiving for efficiency.
  - Test restores quarterly, don't trust untested backups.
  - Use rsync for live syncs; tar for snapshots.
  - Encrypt (gpg) sensitive data: `tar -czvf - data/ | gpg -c > backup.gpg`.
  - Log everything: Redirect script output to logs.

## Sample Exercises
1. Compress and decompress a file using gzip and bzip2.
2. Create a tar archive of a directory and extract it.
3. Use rsync to backup your home directory to another location.
4. Schedule a daily backup using cron.
5. Verify the integrity of a backup file using checksums.
6. Create an incremental backup system.
7. Exclude specific file types from a backup.

## Solutions
1. **Compression/Decompression:**
   ```bash
   # gzip
   gzip file.txt                        # Creates file.txt.gz
   gunzip file.txt.gz                   # Restores file.txt
   
   # bzip2
   bzip2 file.txt                       # Creates file.txt.bz2
   bunzip2 file.txt.bz2                 # Restores file.txt
   
   # Keep original
   gzip -k file.txt                     # Keep original file
   ```

2. **Tar operations:**
   ```bash
   # Create archive
   tar -czvf backup.tar.gz mydir/
   
   # Extract archive
   tar -xzvf backup.tar.gz
   
   # List contents
   tar -tzf backup.tar.gz
   ```

3. **rsync backup:**
   ```bash
   rsync -av --progress ~/ /backup/home_backup/
   rsync -av --delete ~/ /backup/home_backup/  # Delete extra files
   ```

4. **Automated backup:**
   ```bash
   # Edit crontab
   crontab -e
   
   # Add daily backup at 2 AM
   0 2 * * * /usr/local/bin/backup_script.sh
   
   # Backup script example
   #!/bin/bash
   DATE=$(date +%Y%m%d_%H%M%S)
   tar -czf /backup/home_$DATE.tar.gz /home/user/
   ```

5. **Integrity verification:**
   ```bash
   # Generate checksum
   sha256sum backup.tar.gz > backup.sha256
   
   # Verify later
   sha256sum -c backup.sha256  # Outputs "OK" if matches
   
   # Test archive integrity
   tar -tzf backup.tar.gz > /dev/null
   ```

6. **Incremental backup:**
   ```bash
   # Full backup with snapshot
   tar -czf full_backup.tar.gz -g backup.snar /home/user/
   
   # Incremental backup
   tar -czf incr_backup.tar.gz -g backup.snar /home/user/
   ```

7. **Exclude files:**
   ```bash
   # tar exclusions
   tar -czf backup.tar.gz --exclude='*.log' --exclude='tmp/*' /home/user/
   
   # rsync exclusions
   rsync -av --exclude='*.log' --exclude='tmp/' ~/ /backup/
   ```

## Sample Interview Questions
1. What is the difference between compression and archiving?
2. How do you create and extract a compressed tarball?
3. What are the advantages of using rsync for backups?
4. How do you automate backups in Linux?
5. How do you verify the integrity of a backup?
6. What is the risk of using `dd` for disk backups?
7. How do you exclude files from a tar or rsync backup?
8. What is the difference between gzip, bzip2, and xz?
9. How do you restore a single file from a tar archive?
10. Why is it important to test your backups?

## Interview Question Answers
1. **Compression vs Archiving:** Compression reduces file size; archiving combines multiple files. tar can do both
2. **Tarball Operations:** `tar -czvf archive.tar.gz files/` creates; `tar -xzvf archive.tar.gz` extracts
3. **rsync Advantages:** Incremental transfers, resume capability, preserves permissions, bandwidth efficient
4. **Automated Backups:** Use cron jobs, systemd timers, or backup software with scheduling
5. **Backup Verification:** Use checksums (sha256sum), test extractions, verify file counts and sizes
6. **dd Risks:** Can overwrite wrong disk, no compression, copies bad sectors, requires exact space
7. **File Exclusions:** Use `--exclude` with tar/rsync, or `.rsyncignore` files
8. **Compression Tools:** gzip (fast), bzip2 (better compression), xz (best compression, slowest)
9. **Single File Restore:** `tar -xzf archive.tar.gz path/to/file` extracts specific file
10. **Backup Testing:** Ensures recoverability, validates backup integrity, identifies corruption early

