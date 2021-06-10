Task 1:

<code>c=a+b</code>
> echo $c --> a+b, так как a, + и b строковые символы

<code>d=$a+$b</code>
> echo $d --> 1+2, так как $a, и $b обращение к переменным с значениями 1 и 2

<code>e=$(($a+$b))</code>
> echo $e --> 3, так как $(команда), ($a+$b) -- команда сложения двух переменных

Task 2:

<p>В скрипте неверно указано условие выхода из цикла</p>
 
```
#!/bin/bash

cond=1

while [[ $cond -ne 0 ]]
do
curl https://localhost:4757
if [[ $? -ne 0 ]] 
then
    date >> curl.log
else
    cond=$(($?))
fi
done
#EOF
```

Task 3:

<p>Скрипт checker.sh, аргументы ip-address и port</p>

```
#!/bin/bash

#read host  parameter
ip_host=$1
ip_port=$2

address=$ip_host:$ip_port
availabel_msg="$address -- is available"
not_available_msg="$address -- is not available"

echo "Check: Host=$ip_host Port=$ip_port"

for ((i=1; i<=5; ++i));
do
    #check ip_address:port accessibility
    nc -z -w 5 $ip_host $ip_port
    if [[ $? -eq 0 ]];
    then
        echo `date` $available_msg >> $address.log
    else
        echo `date` $not_available_msg >> $address.log
    fi
done
#EOF
```

<p>Скрипт запуска проверок checker_runner.sh</p>

```
#!/bin/bash

addresses=("192.168.0.1:80" "173.194.222.113:80" "87.250.250.242:80")

for addr in ${addresses[@]};
do
    IFS=':' read -ra splitted <<< "$addr"
    ip_host=${splitted[0]}
    ip_port=${splitted[1]}
    echo "Run checker for $ip_host $ip_port" 
    bash ./checker.sh $ip_host $ip_port >> checker.log & 
done

#EOF
```

<p>Кладем скрипты checker_runner.sh и checker.sh в одну директорию и запускаем ./checker_runner.sh</p>

Task 4:

<p>Модификация checker.sh</p>

```
#!/bin/bash

#read host  parameter
ip_host=$1
ip_port=$2

address=$ip_host:$ip_port
availabel_msg="$address -- is available"
not_available_msg="$address -- is not available"

echo "Check: Host=$ip_host Port=$ip_port"

cond=0

while [[ $cond -eq 0 ]];
do
    #check ip_address:port accessibility
    nc -z -w 5 $ip_host $ip_port
    if [[ $? -eq 0 ]];
    then
        echo `date` $available_msg >> $address.log
    else
        echo `date` $not_available_msg >> $address_error.log
        cond=$(($?))
    fi
done
#EOF
```
