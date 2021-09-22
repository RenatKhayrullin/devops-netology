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

Task 4: Зомби процесс имеет только запись в таблице процессов, ресурсы освободаются посте выполнения exit().

