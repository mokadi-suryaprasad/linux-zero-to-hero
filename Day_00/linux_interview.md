# Linux Interview Questions & Answers

This file contains commonly asked Linux interview questions with simple
and clear answers. Useful for DevOps, SRE, Cloud, and SysAdmin roles.

## 1. What is Linux?

Linux is an open-source operating system based on the Unix architecture.

## 2. How to check the Linux version?

   ``` bash 
    cat /etc/os-release
    uname -a
   ```

## 3. How to check the list of users?

   ``` bash
    cat /etc/passwd
   ```
## 4. Difference between useradd and adduser

  Feature                   useradd             adduser
  ------------------------- ------------------- -------------------------------
  Type                      Low-level command   High-level interactive script
  Creates home directory?   No (unless -m)      Yes
  Preferred for?            Scripts             Manual user creation

## 5. How to create users?

    ``` bash
    sudo useradd username
    sudo adduser username
    ```

## 6. How to add a user to a group?

    ``` bash
    sudo usermod -aG <groupname> <username>

    ```

## 7. How to check groups of a user?

    ``` bash
    groups username
    ```

## 8. What is a process?

A process is a program running in memory.
Linux assigns every process a PID.

``` bash
ps aux
top
htop
```

## 9. What is a service?

A background process managed by systemd.

- Useful commands:

``` bash
systemctl status nginx
systemctl start nginx
systemctl stop nginx
systemctl restart nginx
```

## 10. File permissions explained

r = read, w = write, x = execute
``` bash
-rwxr-x---
```
Change permissions:

``` bash
chmod 755 file
```
Change owner:

``` bash
chown user:group file
```

## 11. Hard Link vs Soft Link

### Hard Link:

    ``` bash
    ln file1 file2
    ```
- Same inode

- If original is deleted, link still works

### Soft Link:

    ```bash
    ln -s file1 file2
    ```
- ifferent inode

- Breaks if original is removed

## 12. How to check disk usage?

    ``` bash
    df -h
    du -sh *
    ``` 

## 13. How to check memory usage?

    ``` bash
    free -h
    ```

## 14. How to find files?

    ``` bash
    find / -name filename
    ```

## 15. How to search inside a file?

   ``` bash
   grep "text" filename
   ```

## 16. What is SSH?

SSH is a secure protocol for remote login.

``` bash
ssh user@server-ip
```

## 17. How to check IP address?

``` bash
    ip a
```
## 18. How to check port usage?

   ``` bash
   netstat -tulnp
   ss -tulnp
   ```

## 19. How to check system logs?

    ``` bash
    journalctl -xe
    tail -f /var/log/syslog
    ```

## 20. What is a Shell?

A command interpreter like bash, sh, zsh.
- bash
- sh
- zsh
``` bash
echo $SHELL
```

## 21. Environment Variables

``` bash
export VAR=value
echo $VAR
```

## 22. Crontab (Scheduled Jobs)

``` bash
crontab -e

crontab -l
```

## 23. Package Management

- Debian/Ubuntu:

``` bash
sudo apt update
sudo apt install nginx
```

- RHEL/CentOS:
``` bash
sudo yum install nginx
```

## 24. Kill a process

``` bash
kill <PID>
kill -9 <PID>
```

## 25. What is /etc/passwd?

A file that stores all user details:

- username
- UID
- GID
- home directory

## 26. What is /etc/shadow?

Stores user passwords in encrypted form.
Only root can read it.

## 27. How to check running services?

``` bash
systemctl list-units --type=service
```

## 28. What is a Kernel?

The kernel is the core of the OS, handling:

- process management

- memory

- hardware

- security

## 29. Difference between Process & Thread

| Process            | Thread                     |
| ------------------ | -------------------------- |
| Has its own memory | Shares memory with process |
| Heavyweight        | Lightweight                |
| Independent        | Part of a process          |

## 30. Important Linux Directories

| Directory | Purpose             |
| --------- | ------------------- |
| `/home`   | User files          |
| `/etc`    | Config files        |
| `/var`    | Logs                |
| `/bin`    | Commands            |
| `/usr`    | User utilities      |
| `/tmp`    | Temporary files     |
| `/root`   | Root home directory |

