# Day 11: Pipes, Redirects, Wildcards, and Links

## 🎯 Learning Objectives
By the end of Day 11, you will:
- Master **pipes** for command chaining  
- Understand **input/output redirection**  
- Use **wildcards** for flexible file operations  
- Create and manage **hard and symbolic links**  
- Build powerful **command combinations** for automation  

**🕒 Estimated Time:** 30 mins

---

## 🧪 Sample Environment Setup

Run these commands locally (Ubuntu/Mac Bash):  
```bash
mkdir -p ~/day11_test/{logs,scripts,docs}
echo "Line 1: Normal" > ~/day11_test/logs/log1.txt
echo "Line 2: ERROR here" >> ~/day11_test/logs/log1.txt
echo "Line 3: Normal" >> ~/day11_test/logs/log1.txt
echo "Line 4: WARNING" >> ~/day11_test/logs/log1.txt
touch ~/day11_test/docs/{file1.txt,file2.txt,log1.log,log2.log}
echo '#!/bin/bash
echo "Test script"' > ~/day11_test/scripts/test.sh
chmod +x ~/day11_test/scripts/test.sh

# View initial setup
ls -la ~/day11_test/
cat ~/day11_test/logs/log1.txt
```

---

## 💡 Why These Tools Matter

These are **core Linux skills** every DevOps or SRE engineer must master.  
They help automate pipelines, parse logs, manage files, and chain tools efficiently.

| Command | Description | Example |
|----------|--------------|----------|
| **PIPE (`|`)** | Chain commands by passing output of one as input to another | `cat log.txt | grep ERROR | wc -l` |
| **REDIRECT (`>`, `<`, `>>`)** | Redirect input/output to or from files | `ls > files.txt`, `echo "Log" >> log.txt` |
| **WILDCARD (`*`, `?`, `[ ]`)** | Match patterns in filenames | `ls *.txt`, `ls log?.log`, `ls [a-c]*.txt` |
| **LINK (`ln`)** | Create hard or symbolic links | `ln file hardlink`, `ln -s file symlink` |

---

## 🧩 1️⃣ Pipes (`|`)

A **pipe** sends the output of one command as the input to another.

### 🔍 Examples:
```bash
# Basic pipe: filters files containing 'log'
ls ~/day11_test | grep log

# Multiple pipe chain: count number of ERRORs in a log
cat ~/day11_test/logs/log1.txt | grep ERROR | wc -l

# Sort and unique: remove duplicates from output
cat ~/day11_test/logs/log1.txt | sort | uniq

# Process list filter: find bash processes
ps aux | grep bash | awk '{print $2}'
```

---

## 🔁 2️⃣ Redirects

Redirects control **where data goes** — to files, devices, or other commands.

| Operator | Meaning | Example |
|-----------|----------|----------|
| `>` | Redirect stdout (overwrite) | `ls > files.txt` |
| `>>` | Redirect stdout (append) | `echo "New line" >> log.txt` |
| `<` | Redirect stdin (input) | `grep ERROR < log.txt` |
| `2>` | Redirect stderr (errors) | `ls nonexist 2> errors.txt` |
| `2>&1` | Merge stderr into stdout | `ls nonexist > out.txt 2>&1` |

### 🧠 File Descriptors
| Descriptor | Name | Description |
|-------------|------|-------------|
| `0` | stdin | Input stream (keyboard) |
| `1` | stdout | Output stream (screen) |
| `2` | stderr | Error stream (screen) |

**Examples:**
```bash
# Write stdout to file
ls ~/day11_test > files.txt

# Append data to file
echo "Extra info" >> files.txt

# Capture errors only
ls nonexist 2> errors.txt

# Capture both output and error
ls nonexist > out.txt 2>&1

# Shorthand for both (bash only)
command &> all.txt
```

---

## 🌟 3️⃣ Wildcards (Globbing)

Wildcards expand to match files before execution.  

| Symbol | Meaning | Example |
|---------|----------|----------|
| `*` | Any number of characters | `ls *.txt` |
| `?` | Single character | `ls log?.log` |
| `[abc]` | Any one of a, b, or c | `ls [fl]*` |
| `[a-z]` | Range | `ls file[1-2].txt` |
| `![abc]` | Negation (extglob) | `ls !(*.txt)` |

**Examples:**
```bash
# Match text files
ls ~/day11_test/*.txt

# Match files with one-character difference
ls ~/day11_test/log?.log

# Match starting with f or l
ls ~/day11_test/[fl]*

# Match numbered files
ls ~/day11_test/file[1-2].txt

# Enable extended globbing and match everything except .txt
shopt -s extglob
ls ~/day11_test/!(*.txt)

# Brace expansion - create files
touch ~/day11_test/test{1..3}.txt
```

---

## 🔗 4️⃣ Links

Links create alternate names for files.

| Type | Command | Description |
|------|----------|-------------|
| **Hard Link** | `ln file linkname` | Shares same inode; file persists even if original is deleted |
| **Symbolic Link** | `ln -s file linkname` | Points to another file; breaks if target deleted |

**Examples:**
```bash
# Create original file
echo "Hello World" > ~/day11_test/original.txt

# Create hard and symbolic links
ln ~/day11_test/original.txt ~/day11_test/hardlink.txt
ln -s ~/day11_test/original.txt ~/day11_test/symlink.txt

# View inodes and link relationships
ls -li ~/day11_test/*.txt

# Delete original and test behavior
rm ~/day11_test/original.txt
cat ~/day11_test/hardlink.txt   # Works fine
cat ~/day11_test/symlink.txt    # Broken link
```

---

## 🧰 Best Practices
✅ Chain commands using pipes for automation  
✅ Use `>` and `>>` carefully — overwriting logs is risky  
✅ Use `ls` before `rm` when wildcards are involved  
✅ Prefer symbolic links for configs and reusable scripts  

---

## 🧩 Exercises

1. Count error lines in a log file using pipes.  
2. Redirect both stdout and stderr to a file.  
3. List all `.sh` files starting with "test".  
4. Create hard and symbolic links, then observe differences.  
5. Delete all `.tmp` files in a directory using wildcards.  
6. Build a complex log analyzer using pipes.  
7. Use brace expansion to create directory trees.

---

## 💻 Solutions

```bash
# 1️⃣ Count error lines
grep error logfile.txt | wc -l

# 2️⃣ Redirect output and errors
command > output.txt 2>&1

# 3️⃣ Wildcard usage
ls test*.sh
ls test?.sh
ls test[0-9].sh

# 4️⃣ Create links
echo "Hello" > original.txt
ln -s original.txt symlink.txt
ln original.txt hardlink.txt
ls -li *.txt

# 5️⃣ Delete .tmp files
ls *.tmp
rm *.tmp

# 6️⃣ Complex pipeline
cat access.log | grep "404" | awk '{print $1}' | sort | uniq -c | sort -nr | head -10

# 7️⃣ Directory structure
mkdir -p project/{src/{main,test},docs,config}
touch project/src/main/app.{py,js,go}
```

---

## ❓ Interview Questions

| Question | Answer |
|-----------|---------|
| Pipe vs Redirect | Pipe connects commands; Redirect sends output/input to files |
| Append Output | Use `>>` to append |
| Hard vs Soft Link | Hard link shares inode; symlink points to path |
| Wildcards | `*`, `?`, `[a-z]`, `{}` |
| Redirect both stdout & stderr | `command > file 2>&1` |
| Delete Behavior | Hard link keeps data; symlink breaks |
| Recursive find | `find . -name "*.ext"` |
| Wildcard Risks | Can delete unintended files |
| Check inode | `ls -li filename` |
| Command chaining | `ps aux | grep process | awk '{print $2}' | xargs kill` |

---

## 🏁 Summary

| Tool | Key Usage |
|------|------------|
| `|` | Connect commands dynamically |
| `>` / `>>` | Save command outputs to files |
| `* ? [] {}` | Match filenames flexibly |
| `ln` | Create file links for redundancy and reuse |

---
