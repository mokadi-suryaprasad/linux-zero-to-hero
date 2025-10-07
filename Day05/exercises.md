# 🐧 Linux Sample Exercises 

## 🧩 Sample Exercises

### 1. List all files, including hidden ones, in your home directory.
Hidden files start with a dot (`.`).  
Command:
```bash
ls -la ~
```
### 2. Create a directory, add a file, copy and rename it, then delete both.

``` bash
mkdir myfolder              # Create a new folder
cd myfolder                 # Go inside folder
echo "Hello Linux!" > file1.txt   # Create a file
cp file1.txt file2.txt      # Copy the file
mv file2.txt renamed.txt    # Rename the copy
rm file1.txt renamed.txt    # Delete both files
cd .. && rmdir myfolder     # Go out and remove folder
```
- Explanation: Create folder → add file → copy → rename → delete.
### 3. View the first and last 10 lines of /etc/passwd.

``` bash
head /etc/passwd     # First 10 lines
tail /etc/passwd     # Last 10 lines
```
- /etc/passwd contains user account info.

### 4. Search for the word root in /etc/passwd.

``` bash
grep root /etc/passwd
```
- grep searches for text inside a file.

### 5. Create an alias to list files in long format and use it.

``` bash
alias ll='ls -l'    # Create alias
ll                  # Use alias
```
- Tip: Add alias to ~/.bashrc to make it permanent.

### 6. Find .log files in /var/log modified in the last 24 hours.

``` bash
find /var/log -name "*.log" -mtime -1
```
- Explanation:

  - *.log → files ending with .log

  - -mtime -1 → modified in last 1 day

### 7. Count how many users have /bin/bash as their shell.

``` bash
grep "/bin/bash" /etc/passwd | wc -l
```
- Shows number of users using /bin/bash.

### 8. Show lines in /etc/passwd that do NOT contain /bin/false.

``` bash
grep -v "/bin/false" /etc/passwd
```
- -v means exclude matching lines.

### 9. Preview which *.tmp files would be deleted.

``` bash
find . -name "*.tmp"
```
- Tip: This only shows files. To delete, use -delete.

### 10. Compare two config files and show differences.

``` bash
diff file1.conf file2.conf
```
- Shows line-by-line differences between files.