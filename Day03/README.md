# 🐧 Day 03: Linux Folder Structure & File Types

## 📁 Linux Folder Structure Overview

When you log into a Linux system, all files and directories are organized under the **root directory (`/`)**.  
Here’s a breakdown of important system directories:

| Directory | Description |
|------------|-------------|
| `/` | Root directory — top of the Linux filesystem. |
| `/bin` | Essential command binaries (like `ls`, `cp`, `mv`, `cat`). |
| `/boot` | Bootloader files (kernel, initrd). |
| `/dev` | Device files (e.g., `/dev/sda`, `/dev/null`). |
| `/etc` | Configuration files for system and applications. |
| `/home` | Home directories for regular users. |
| `/lib` | Shared libraries needed for essential binaries in `/bin` and `/sbin`. |
| `/media` | Mount point for removable devices (like USBs). |
| `/mnt` | Temporary mount point for file systems. |
| `/opt` | Optional software packages. |
| `/proc` | Virtual filesystem for process and system information. |
| `/root` | Home directory for the root user. |
| `/run` | Stores runtime data (like process IDs). |
| `/sbin` | System administration binaries. |
| `/srv` | Data for services (like web or FTP servers). |
| `/sys` | Contains system and kernel information. |
| `/tmp` | Temporary files (cleared on reboot). |
| `/usr` | User programs and data. |
| `/var` | Variable files like logs, mail, spool, and temp data. |

---

## 📄 File Types in Linux

Use `ls -l` to view file types.  
The **first character** in the output indicates the type:

| Symbol | Type | Example |
|---------|------|----------|
| `-` | Regular file | `-rw-r--r--  1 user user  1024 file.txt` |
| `d` | Directory | `drwxr-xr-x  2 user user  4096 myfolder` |
| `l` | Symbolic link | `lrwxrwxrwx  1 user user  5 link -> file` |
| `c` | Character device | `/dev/tty` |
| `b` | Block device | `/dev/sda` |
| `p` | Named pipe (FIFO) | Interprocess communication |
| `s` | Socket | Used for communication between processes |

---

## ⚙️ Try These Commands

```bash
# Check current directory
pwd

# List files with detailed info
ls -l

# View hidden files
ls -la

# Check file type
file /etc/passwd

# View file content
cat /etc/os-release

# View directory structure
tree /

# Find type of multiple files
file /bin/* | less
```
# 🔗 Hard Link vs Soft Link in Linux

In Linux, **links** are used to create *references or shortcuts* to files.  
They help users access the same data from multiple paths without duplicating the file content.

There are two main types of links:

1. 🧱 **Hard Link**
2. 🪶 **Soft Link (Symbolic Link)**

---

## 🧱 What is a Hard Link?

A **Hard Link** is like giving a file **another name** that points to the **same data (inode)** on disk.

Both the original file and the hard link share:
- The **same inode number**
- The **same physical data blocks** on disk

When you modify one file, changes appear in the other — because both point to the same data.

✅ **Key Features:**
- Points **directly to the data** on the disk.
- Both names (original and hard link) are **equal** — no “main” or “secondary”.
- Deleting one does **not affect** the other.
- Cannot link **directories**.
- Cannot link files across **different filesystems or partitions**.

---

### 💻 Real-Time Example: Hard Link

Imagine you are working on a log file `/var/log/app.log`, and you want a copy in your home directory  
without duplicating data.

```bash
# Step 1: Create a sample file
echo "Application started successfully." > /var/log/app.log

# Step 2: Create a hard link in your home directory
ln /var/log/app.log ~/app_log_backup

# Step 3: Check inode numbers (same = hard link)
ls -li /var/log/app.log ~/app_log_backup
```