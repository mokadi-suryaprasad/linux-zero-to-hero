## Hands-on Exercises & Lab
### Part 1: Root Hierarchy & Purposes
1. **Exercise:** `ls -l /`—list all root directories. For each key one (e.g., /bin, /etc, /home, /var, /usr, /tmp), run `ls <dir>` and describe its purpose/category (e.g., /bin: essential binaries).
2. **Question:** What's in /boot? Why essential for boot (from Day 2)?

### Part 2: Visualize Structure & Hidden Files
1. Install if needed: `sudo apt install tree -y`.
2. **Exercise:** `tree -L 2 /` (root with 2 levels); `tree ~` (home structure). Then `ls -la ~` to find/display all hidden files—list 3 examples (e.g., .bashrc).
3. **Question:** How do hidden files like .ssh help in DevOps (secure keys)?

### Part 3: File Types & Inspection
1. `ls -l /`—spot types (d for dirs, l for links).
2. **Exercise:** Use `file` and `stat` to inspect: `file /bin/ls /etc/passwd /dev/sda` (types); `stat /bin/ls` (details). Explain /etc/passwd vs. /etc/shadow (user info vs. hashed passwords).
3. **Question:** Why device files like /dev/sda as files? (Uniform handling—e.g., dd for backups.)

### Part 4: Links Creation & Differences
1. `echo "Hello World" > original.txt`.
2. **Exercise:** `ln -s original.txt symlink.txt` (sym); `ln original.txt hardlink.txt` (hard); `ls -li *.txt` (compare inodes). Delete original → test `cat symlink.txt` (broken?) vs. `cat hardlink.txt` (works?).
3. **Question:** Practical use cases: Sym for configs (easy swap); hard for backups (space-saving)—when each?

### Part 5: Paths, Navigation, & Hunt
1. `cd /var/log` → `pwd` (absolute).
2. **Exercise:** Relative nav: `cd ..` → `cd log` back; `find ~ -name ".*" -type f` (all hidden files). Use absolute/relative to create a file in /tmp/lab via cd.
3. **Question:** Absolute paths for scripts? (No cd surprises.)

### Part 6: Challenge - Full Workflow
1. **Exercise:** In /tmp: mkdir lab → echo "test" > lab/file.txt → sym/hard links → `du -sh /*` (sizes); inspect /proc (virtual? `cat /proc/version`).
2. **Question:** Troubleshoot broken symlink: How detect/fix? (ls -l spots; recreate.)
