Task 4:

```
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "bento/ubuntu-20.04"
  config.vm.provider "virtualbox" do |vb|
     # Display the VirtualBox GUI when booting the machine
     #vb.gui = true
     # Virtual Machine Name
     vb.name="devops-netology-vm"
     # Customize the amount of memory on the VM:
     vb.memory = "2048"
     vb.cpus = 4
     vb.customize ["modifyvm", :id, "--vram", 16]
  end
end
```

Task 8:

Вводим
>man bash \
>/HISTORY

Находим название параметров (строки ~630):

Размеры файла с историей задаются с помощью переменных окружения:
> HISTFILESIZE \
> HISTSIZE

Значение которое может принимать параметр HISTCONTROL:
> ignoreboth

что делает: заставляет выполняться одновременно директивы 

> ignorespace -- команды начинающиеся с пробела игнорируются \
> ignoredups -- не сохранять строки сопадающие с последней выполненной

Task 9:

Набираем:

> man bash \
> /\{ -- ищем вхождение в текст мануала '{' или \{ \} \
> n -- переход к следующему вхождению 

Некоторые из спобосов использования:

1) задание перечислений, например: {1,2,3,4}, {1..3}, {a, b{1..2}}
2) при обращении к переменным ${..имя переменной..}

Task 10:

> touch a{1..100}.txt

Task 11:

> [[ expression ]] -- возвращает 0 или 1 основываясь на резльутате вычисления expression \
> [[ -d /tmp ]] -- 0 если дирректория не существует и 1 иначе

Task 12:

1) создаем файл bash в /tmp/new_path_directory/bash/
2) даем права на исполнение \
   <code>chmod +x /tmp/new_path_directory/bash/bash</code>
3) добавляем путь /tmp/new_path_directory/bash/ в PATH в .profile файле \
   <code>export PATH="/tmp/new_path_directory/bash/:$PATH"</code>
   
Task 13:

> at -- одноразовое выполнение команды в заданное время \
> batch -- выполнение одноразовых команд когда загрузка системы меньше 1.5

