# Day 11: Pipes, Redirects, Wildcards, and Links

## Learning Objectives
By the end of Day 11, you will:
- Master pipes for command chaining
- Understand input/output redirection
- Use wildcards for flexible file operations
- Create and manage hard and symbolic links
- Build powerful command combinations

**Estimated Time:** 30 mins

## Sample Environment Setup
Exercises are local, no VMs needed. Use your local machine (e.g., Ubuntu/Mac with Bash).
```
mkdir -p ~/day11_test/{logs,scripts,docs}
echo "Line 1: Normal" > ~/day11_test/logs/log1.txt
echo "Line 2: ERROR here" >> ~/day11_test/logs/log1.txt
echo "Line 3: Normal" >> ~/day11_test/logs/log1.txt
echo "Line 4: WARNING" >> ~/day11_test/logs/log1.txt
touch ~/day11_test/docs/{file1.txt,file2.txt,log1.log,log2.log}
echo '#!/bin/bash\necho "Test script"' > ~/day11_test/scripts/test.sh
chmod +x ~/day11_test/scripts/test.sh

# View initial state
ls -la ~/day11_test/
cat ~/day11_test/logs/log1.txt
```

## Why These Tools Matter:
  - Essential for chaining commands, automating tasks, and flexible file management in Linux.
  - Mastery is expected for DevOps, SRE, and system engineering roles.


| Command | Simple Description | Examples |
|---------|--------------------|----------|
| **PIPE**<br>`$ cmd1 \| cmd2` | Chain commands by passing output as input. | 1. Basic: `ls \| grep txt`<br>2. Chain: `cat log.txt \| grep ERROR \| wc -l`<br>3. Sort: `ps aux \| sort -k1 \| head -5` |
| **REDIRECT**<br>`$ cmd > file` | Send output/input to/from files (use >> for append, < for input, 2> for stderr). | 1. Overwrite: `ls > files.txt`<br>2. Append: `echo "Log" >> log.txt`<br>3. Both: `cmd > out.txt 2>&1` |
| **WILDCARD**<br>`$ ls *.txt` | Match files with patterns (glob). | 1. Any: `rm *.tmp`<br>2. Single: `ls file?.log`<br>3. Range: `ls [a-c]*.txt \| wc -l` |
| **LINK**<br>`$ ln file link` | Create file/directory pointers (hard or sym). | 1. Hard: `ln original hardlink`<br>2. Sym: `ln -s original symlink`<br>3. View: `ls -li \| grep original`

- **Pipes (`|`):**
  - Pass output of one command as input to another.

  **Examples:**
  - Basic pipe: ls ~/day11_test | grep log (lists files, pipes to grep for "log").
  - Chain: cat ~/day11_test/logs/log1.txt | grep ERROR (cats file, greps errors).
  - Count: cat ~/day11_test/logs/log1.txt | grep ERROR | wc -l (counts error lines).
  - Sort/unique: cat ~/day11_test/logs/log1.txt | sort | uniq (sorts, removes duplicates).
  - Advanced: ps aux | grep bash | awk '{print $2}' (finds bash PIDs).
---

- **Redirects:**
- Redirections change where a command gets its input (stdin) or sends its output (stdout/stderr), letting you save results to files, read from files, or combine streams without extra tools.

| Operator | Description | Example |
|----------|-------------|---------|
| `>` | Redirect stdout to file (overwrite) | `ls > files.txt` (overwrites files.txt with ls output) |
| `>>` | Redirect stdout to file (append) | `echo "Log" >> log.txt` (adds to end of log.txt) |
| `<` | Use file as stdin (input) | `grep ERROR < log.txt` (greps content from log.txt) |
| `2>` | Redirect stderr to file | `ls nonexist 2> errors.txt` (errors to errors.txt) |
| `2>&1` | Redirect stderr to stdout | `ls nonexist > out.txt 2>&1` (both to out.txt) |

### File Descriptors (Streams): 
- File descriptors are numbers identifying open streams for a process: 0 for input, 1 for normal output, 2 for errors. Redirections target these for precise control.

| Descriptor | Name | Description |
|------------|------|-------------|
| `0` | stdin | Input stream (usually keyboard) |
| `1` | stdout | Normal output stream (usually screen) |
| `2` | stderr | Error output stream (usually screen)

**Example:**
  - Stdout overwrite: ls ~/day11_test > ~/day11_test/files.txt (ls to file).
  - Append: echo "New line" >> ~/day11_test/files.txt (adds to file).
  - Input: grep ERROR < ~/day11_test/logs/log1.txt (greps from file).
  - Stderr: ls nonexist 2> ~/day11_test/errors.txt (errors to file).
  - Both: ls nonexist > output.txt 2>&1 (stdout + stderr to file).
  - (Optional) All: command &> all.txt (Bash shorthand for both).
---


- **Wildcards (Globbing):** Wildcards (globbing) expand patterns to match files before command execution: * for any chars, ? for one char, [] for sets.
  - `*`: Any number of characters
  - `?`: Single character
  - `[abc]`: Any one character in set
  - `[a-z]`: Any character in range
  - `![abc]`: Any character other than this

  **Examples:**
  - Any chars: ls ~/day11_test/*.txt (all .txt files).
  - Single char: ls ~/day11_test/log?.log (log1.log, log2.log).
  - Set: ls ~/day11_test/[fl]* (files starting f or l).
  - Range: ls ~/day11_test/file[1-2].txt (file1.txt, file2.txt).
  - Negate: ls ~/day11_test/!(*.txt) (shopt -s extglob first; non-txt).
  - (Optional) Brace: touch ~/day11_test/test{1..3}.txt (creates test1.txt etc.).
---


- **Links:** Links create multiple names for files: hard links share data (same inode), symbolic links point to paths (like shortcuts).
  - **Hard Link:** `ln file1 file2` — Same inode, file exists until all links are deleted
  - **Symbolic Link (Symlink):** `ln -s target linkname` — Pointer to another file or directory
  - Use `ls -li` to view inodes and link types
 
  **Examples:**
  - Create file: echo "Test" > ~/day11_test/original.txt.
  - Hard link: ln ~/day11_test/original.txt ~/day11_test/hardlink.txt.
  - Sym link: ln -s ~/day11_test/original.txt ~/day11_test/symlink.txt.
  - View: ls -li ~/day11_test/*.txt (same inode for hard/original; symlink shows arrow).
  - Test delete: rm ~/day11_test/original.txt; cat ~/day11_test/hardlink.txt (still works); cat ~/day11_test/symlink.txt (broken).
  - (Optional) Dir sym: ln -s ~/day11_test/logs ~/day11_test/logs_link.
  - Tips: ls -l shows symlink arrows. Hard links can't cross filesystems.
---


- **Best Practices:**
  - Use pipes to build powerful one-liners
  - Redirect output to log files for troubleshooting
  - Use wildcards carefully to avoid accidental deletion
  - Prefer symlinks for configs/scripts; use hard links for backup/versioning



## Sample Exercises
1. Use pipes to count the number of lines containing "error" in a log file.
2. Redirect both stdout and stderr of a command to a file.
3. List all files starting with "test" and ending with ".sh" in a directory.
4. Create a symbolic link and a hard link for a file, then show the difference.
5. Use wildcards to delete all `.tmp` files in a directory.

- **Advanced Redirection:**
  ```bash
  # File descriptors
  command 1> stdout.txt 2> stderr.txt    # Separate stdout/stderr
  command &> all_output.txt              # Both to same file (bash)
  command > output.txt 2>&1              # Both to same file (POSIX)
  
  # Here documents
  cat << EOF > file.txt
  Line 1
  Line 2
  EOF
  
  # Process substitution
  diff <(sort file1) <(sort file2)       # Compare sorted files
  ```

- **Advanced Wildcards:**
  ```bash
  # Extended globbing (bash)
  shopt -s extglob
  ls !(*.txt)                            # All except .txt files
  ls *.@(jpg|png|gif)                    # Multiple extensions
  
  # Brace expansion
  touch file{1..10}.txt                  # Create file1.txt to file10.txt
  mkdir -p project/{src,docs,tests}      # Create directory structure
  ```

## Sample Exercises
1. Use pipes to count the number of lines containing "error" in a log file.
2. Redirect both stdout and stderr of a command to a file.
3. List all files starting with "test" and ending with ".sh" in a directory.
4. Create a symbolic link and a hard link for a file, then show the difference.
5. Use wildcards to delete all `.tmp` files in a directory.
6. Create a complex pipeline to analyze log files.
7. Use brace expansion to create a directory structure.

## Solutions
1. **Count error lines:**
   ```bash
   grep error logfile.txt | wc -l
   cat logfile.txt | grep -c error        # Alternative
   ```

2. **Redirect stdout and stderr:**
   ```bash
   command > output.txt 2>&1
   command &> output.txt                  # Bash shorthand
   ```

3. **Wildcard matching:**
   ```bash
   ls test*.sh
   ls test?.sh                            # Single character
   ls test[0-9].sh                        # Numeric range
   ```

4. **Create links:**
   ```bash
   echo "Hello World" > original.txt
   ln -s original.txt symlink.txt         # Symbolic link
   ln original.txt hardlink.txt           # Hard link
   ls -li *.txt                           # Compare inodes
   ```

5. **Delete temp files:**
   ```bash
   ls *.tmp                               # Check first!
   rm *.tmp                               # Delete all .tmp files
   ```

6. **Complex pipeline:**
   ```bash
   # Analyze Apache access log
   cat access.log | grep "404" | awk '{print $1}' | sort | uniq -c | sort -nr | head -10
   ```

7. **Directory structure:**
   ```bash
   mkdir -p project/{src/{main,test},docs,config}
   touch project/src/main/app.{py,js,go}
   ```

## Sample Interview Questions
1. What is the difference between a pipe and a redirect?
2. How do you append output to a file instead of overwriting it?
3. What is the difference between a hard link and a symbolic link?
4. How do you use wildcards to match files?
5. How do you redirect both stdout and stderr to the same file?
6. What happens if you delete the original file for a symlink? For a hard link?
7. How do you find all files with a certain extension in a directory and its subdirectories?
8. What are the risks of using wildcards with `rm`?
9. How do you check the inode number of a file?
10. How do you use pipes to combine multiple commands?

## Interview Question Answers
1. **Pipe vs Redirect:** Pipe (`|`) passes output between commands; redirect (`>`, `<`) sends output/input to/from files
2. **Append Output:** Use `>>` to append instead of `>` which overwrites
3. **Links:** Hard links share same inode/data, can't cross filesystems; symlinks point to path, can cross filesystems
4. **Wildcards:** `*` (any chars), `?` (single char), `[]` (char set), `{}` (brace expansion)
5. **Combined Redirect:** `command > file 2>&1` or `command &> file` (bash)
6. **Link Behavior:** Symlink breaks if target deleted; hard link keeps file accessible until all links removed
7. **Recursive Find:** `find . -name '*.ext'` or `ls **/*.ext` (with globstar)
8. **Wildcard Risks:** Can match unintended files; always test with `ls` before using with `rm`
9. **Inode Check:** `ls -li filename` or `stat filename`
10. **Command Chaining:** Pipes create powerful one-liners: `ps aux | grep process | awk '{print $2}' | xargs kill`

