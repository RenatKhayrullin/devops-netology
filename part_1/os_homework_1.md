Task 1:
```
chdir("/tmp")
```

Task 2: 
```
/usr/share/misc/magic.mgc
```

Task 3:
```
ps a <-- узнаем pid процесса который пишел в файл
sudo find /proc/[pid]/fd -ls | grep 'deleted' <- найдем fd 
sudo -s
>/proc/[pid]/fd/[fd]
```

Task 4: Зомби процесс имеет только запись в таблице процессов, ресурсы освобождаются после выполнения exit().

Task 5:
```
ping yandex.ru > log.txt
sudo /usr/sbin/opensnoop-bpfcc -n ping
```
Результат
```
PID    COMM               FD ERR PATH <-- open() syscalls
1280   ping                3   0 /etc/ld.so.cache
1280   ping                3   0 /lib/x86_64-linux-gnu/libcap.so.2
1280   ping                3   0 /lib/x86_64-linux-gnu/libgcrypt.so.20
1280   ping                3   0 /lib/x86_64-linux-gnu/libresolv.so.2
1280   ping                3   0 /lib/x86_64-linux-gnu/libc.so.6
1280   ping                3   0 /lib/x86_64-linux-gnu/libgpg-error.so.0
1280   ping                3   0 /usr/lib/locale/locale-archive
1280   ping                5   0 /etc/nsswitch.conf
1280   ping                5   0 /etc/host.conf
1280   ping                5   0 /etc/resolv.conf
1280   ping                5   0 /etc/ld.so.cache
1280   ping                5   0 /lib/x86_64-linux-gnu/libnss_files.so.2
1280   ping                5   0 /etc/hosts
1280   ping                5   0 /etc/ld.so.cache
1280   ping                5   0 /lib/x86_64-linux-gnu/libnss_dns.so.2
1280   ping                5   0 /etc/gai.conf
1280   ping                5   0 /usr/share/locale/locale.alias
1280   ping               -1   2 /usr/share/locale/en_US/LC_MESSAGES/iputils.mo
1280   ping               -1   2 /usr/share/locale/en/LC_MESSAGES/iputils.mo
1280   ping               -1   2 /usr/share/locale-langpack/en_US/LC_MESSAGES/iputils.mo
1280   ping               -1   2 /usr/share/locale-langpack/en/LC_MESSAGES/iputils.mo
1280   ping                5   0 /etc/hosts
```

Task 6: 
```
Part of the utsname information is also accessible via
/proc/sys/kernel/{ostype, hostname, osrelease, version, domainname}.
```

Task 7: \
``` command_1 ;  command_2 ``` если ```command_1``` завершится с ошибкой, ```command_2``` продолжит работать \
``` command_1 && command_2 ``` если ```command_1``` завершится с ошибкой, ```command_2``` не будет запущена \
```-e``` Exit immediately if a command exits with a non-zero status --> cмысла использовать не будет.

Task 8: \
```-e```  Exit immediately if a command exits with a non-zero status. \
```-u```  Treat unset variables as an error when substituting. \
```-x```  Print commands and their arguments as they are executed. \
```-o pipefail``` The return value of a pipeline is the status of the last command to exit with a non-zero status, \
or zero if no command exited with a non-zero status 

Task 9:
```
ps ax -o stat | sort | uniq -c
```
Результат 
```
     11 I
     44 I< -- high-priority idle kernel thread
      1 R+
     37 S
      4 S+
      1 Sl
      1 SLsl
      2 SN
      1 S<s
     17 Ss
      1 Ss+
      4 Ssl
      1 STAT
```