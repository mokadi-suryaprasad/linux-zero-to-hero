## 🧰 Hands-on Exercises & Lab

### Part 1: Root Hierarchy & Purposes
1. **Exercise:** List all root directories:
```bash
ls -l /
```
- Check important directories:

  - /bin → essential commands like ls, cp, mv

  - /etc → configuration files

  - /home → user directories

  - /var → logs, mail, temp files

  - /usr → user programs

  - /tmp → temporary files

*** Question: *** What is in /boot?

  - /boot contains kernel and bootloader files. These are essential for starting Linux.

### Part 2: Visualize Structure & Hidden Files

- Install tree if needed:
``` bash
sudo apt install tree -y
```
- Exercises:
```bash
tree -L 2 /
tree ~
ls -la ~
```
- Find 3 hidden files in home: .bashrc, .ssh, .gitconfig

*** Question: *** How do hidden files like .ssh help in DevOps?

   - They store secure SSH keys used for accessing servers safely.

### Part 3: File Types & Inspection

- Spot types of files in root:

``` bash
ls -l /
```
  - d → directory, l → link, - → regular file
- Inspect files:

``` bash
file /bin/ls /etc/passwd /dev/sda
stat /bin/ls
```
  - /etc/passwd → user info

  - /etc/shadow → hashed passwords (root only)
*** Question: *** Why are device files like /dev/sda treated as files?

  - So Linux can handle devices uniformly using standard commands.

### Part 4: Links Creation & Differences

- Create sample file:
``` bash
echo "Hello World" > original.txt
```
- Create links:
``` bash
ln -s original.txt symlink.txt   # soft link
ln original.txt hardlink.txt     # hard link
ls -li *.txt
```
- Delete original and test:
``` bash
rm original.txt
cat symlink.txt   # broken
cat hardlink.txt  # works
```
*** Question: *** Use cases?

- Soft link → configuration shortcuts

- Hard link → backup copies without extra disk space

### Part 5: Paths, Navigation, & Hunt

- Navigate directories:
``` bash
cd /var/log
pwd
cd ..
cd log
```
- Find all hidden files in home:
``` bash
find ~ -name ".*" -type f
```
*** Question: *** Why use absolute paths in scripts?

- To avoid errors when the current directory is different.

### Part 6: Challenge – Full Workflow

- Create directory, file, and links:
``` bash
mkdir /tmp/lab
echo "test" > /tmp/lab/file.txt
ln /tmp/lab/file.txt /tmp/lab/hardlink.txt
ln -s /tmp/lab/file.txt /tmp/lab/symlink.txt
```
- Check sizes:

``` bash
du -sh /*
```
- Inspect virtual filesystem:
``` bash
cat /proc/version
```
*** Question: *** How to detect/fix broken symlinks?
``` bash
ls -l  # find broken links (shows -> target missing)
ln -sf <correct_target> <link_name>  # recreate link
```
- /proc is a virtual filesystem; it shows system info but uses no disk space.