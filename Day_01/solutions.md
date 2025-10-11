### Try Basic Commands
``` bash
pwd          # current directory
ls           # list files
man ls       # help page for ls
cat /etc/os-release   # see distro details
uname -r     # kernel version

```

### Run a Script

- Create a file: nano hello.sh

``` bash
#!/bin/bash
echo "Hello, Linux World!"
pwd
cat /etc/os-release | grep PRETTY_NAME

```
- Run the script:

``` bash
chmod +x hello.sh
./hello.sh
```