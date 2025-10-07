# 🐧 Linux Sample Interview Questions – Easy Answers

## 🧩 Sample Interview Questions

### 1. Difference between `cat` and `less`?
- `cat` → Shows the whole file at once.  
- `less` → Lets you scroll through a file page by page.  
✅ **Example:**
```bash
cat file.txt
less file.txt
```
### 2. How do you find files modified in the last day?

``` bash
find . -type f -mtime -1
```
- -mtime -1 means modified in the last 1 day.

### 3. How to search recursively for a string in code?

``` bash
grep -r "functionName" .
```
- -r searches inside all files and folders from the current directory.

### 4. What’s the difference between wildcards and regex?

- Wildcards → Simple patterns, like *.txt (all text files)

- Regex → More advanced patterns, like ^user.*bash$
  - ✅ Example:
``` bash
ls *.log       # wildcard
grep "^root" /etc/passwd   # regex
```
### 5. How do you count the number of users with Bash shell?

``` bash
grep "/bin/bash" /etc/passwd | wc -l
```
- Shows the number of users using Bash as their shell.

### 6. How do you follow new log lines as they’re written?

``` bash
tail -f /var/log/syslog
```
- -f means follow new lines as they appear.

### 7. Explain cp file{,.bak} expansion.

``` bash
cp file{,.bak}
```
- Creates a backup copy called file.bak.

  - {,.bak} expands to two names: file and file.bak.

### 8. Show only usernames from /etc/passwd.

``` bash
cut -d: -f1 /etc/passwd
```
-d: → use colon as delimiter
✅ -f1 → take first field (username)

### 9. Why use grep -F over grep sometimes?

- grep -F treats the search as a fixed string, not a regex.
  - ✅ Example: Searching for *.* literally without regex interpretation.

### 9. Why use grep -F over grep sometimes?

grep -F treats the search as a fixed string, not a regex.
✅ Example: Searching for *.* literally without regex interpretation. 

### 10. How to safely preview a delete operation using globs?

``` bash
echo *.tmp
```
- Shows which files match *.tmp before actually deleting them.

  - To delete safely:

``` bash
rm *.tmp
```