Task 1: \
[docker файл](hw4_1/Dockerfile) \
[docker image](https://hub.docker.com/repository/docker/kh4k1/archlinux-ponysay)
```
Reist@MacBookRIK hw4 % docker run --name ponysay-archlinux kh4k1/archlinux-ponysay
 _______________
< Hey, netology >
 ---------------
   \
    \
     \
      \        █▄▄▄▄▄
       \       ▀▄█▄█▄▄
        \        █▄▄▄█
         \       ▀█████
          \       █▄▄█▄▄          ▄▄
           \       ███▄█       ▄▄▄██▄▄▄
            \     █▄▄▄█  ▄▄▄▄▄▄██▄██▄███
             \   █▄▄▄██▄▄█▄██▄▄▄▄▄▄▀▀▀▀
    ▄▄▄▄▄▄▄     ██▄▄████▄▄▄▄█▄██
  ▄▄█▄▄▄▄▄█▄▄▄  █████████▄▄▄▄▄▄▀
 ██████▄█▀▄█▄▄▄▄▄██▄▄▄▄▄▄▄█▄▄▄▄
 ▀▄███▄██▄▄▄█▄▄▄▄▄▄▄████▄███▄█▄█▄▄
  ██▄█▄█▄█▄▄██▄██████▄█████████████
   ███ ██▄█▄██▄▄▄▄▄▄▄████▄▄▄▄▄▄▄▄▀
    ███ ██▄▄█▀█▄▄█▄████▄▄▄█▄▄▄▀▀
     ▀▀  ▀▀      ▀▄▄▄▄▄▄▄▄▄▀
                  ▄█▄▄▄▄▄█▄
                 █▄██▄█▄██▄█
               ▄▄█▄▄▄███▄▄▄█▄▄
               ███▄███████▄███
               ▄▄████▄▄▄████▄▄
              ▄▄████▄██▄██▄██▄▄
            ▄▄▄███▄█▄▄▄██▄▄███▄▄▄
            ██▄█▄██▀███▄▄███▄█▄██
            ▀▄▄▄▀▀▀████▄████▀▄▄▄▀
                  █████████
                 █████▄█▄▀
                 ▀▄██▄▄▄
                  ▀▄▄▄█
                    ███
                     ▄█
                     █▄
                    █▄▄
                     ██
                     ██
                     ██▄
                     █▄▀
                     ██
                     ██
                     ██
                     ▀▀
```
Task 2:
[docker image](https://hub.docker.com/repository/docker/kh4k1/jenkins-custom)

[docker c amazoncorretto файл](hw4_2/ver1/Dockerfile)
```
Running from: /home/jenkins/jenkins.war
webroot: $user.home/.jenkins
2021-10-12 20:53:57.548+0000 [id=1] INFO org.eclipse.jetty.util.log.Log#initialized: Logging initialized @858ms to org.eclipse.jetty.util.log.JavaUtilLog
2021-10-12 20:53:57.666+0000 [id=1] INFO winstone.Logger#logInternal: Beginning extraction from war file
2021-10-12 20:53:59.235+0000 [id=1] WARNING o.e.j.s.handler.ContextHandler#setContextPath: Empty contextPath
2021-10-12 20:53:59.332+0000 [id=1] INFO org.eclipse.jetty.server.Server#doStart: jetty-9.4.43.v20210629; built: 2021-06-30T11:07:22.254Z; git: 526006ecfa3af7f1a27ef3a288e2bef7ea9dd7e8; jvm 11.0.12+7-LTS
2021-10-12 20:53:59.777+0000 [id=1] INFO o.e.j.w.StandardDescriptorProcessor#visitServlet: NO JSP Support for /, did not find org.eclipse.jetty.jsp.JettyJspServlet
2021-10-12 20:53:59.842+0000 [id=1] INFO o.e.j.s.s.DefaultSessionIdManager#doStart: DefaultSessionIdManager workerName=node0
2021-10-12 20:53:59.843+0000 [id=1] INFO o.e.j.s.s.DefaultSessionIdManager#doStart: No SessionScavenger set, using defaults
2021-10-12 20:53:59.844+0000 [id=1] INFO o.e.j.server.session.HouseKeeper#startScavenging: node0 Scavenging every 600000ms
2021-10-12 20:54:00.515+0000 [id=1] INFO hudson.WebAppMain#contextInitialized: Jenkins home directory: /root/.jenkins found at: $user.home/.jenkins
2021-10-12 20:54:00.894+0000 [id=1] INFO o.e.j.s.handler.ContextHandler#doStart: Started w.@41522537{Jenkins v2.316,/,file:///root/.jenkins/war/,AVAILABLE}{/root/.jenkins/war}
2021-10-12 20:54:00.944+0000 [id=1] INFO o.e.j.server.AbstractConnector#doStart: Started ServerConnector@15cafec7{HTTP/1.1, (http/1.1)}{0.0.0.0:8080}
2021-10-12 20:54:00.945+0000 [id=1] INFO org.eclipse.jetty.server.Server#doStart: Started @4257ms
2021-10-12 20:54:00.948+0000 [id=24] INFO winstone.Logger#logInternal: Winstone Servlet Engine running: controlPort=disabled
2021-10-12 20:54:01.314+0000 [id=31] INFO jenkins.InitReactorRunner$1#onAttained: Started initialization
2021-10-12 20:54:01.377+0000 [id=29] INFO jenkins.InitReactorRunner$1#onAttained: Listed all plugins
WARNING: An illegal reflective access operation has occurred
WARNING: Illegal reflective access by com.google.inject.internal.cglib.core.$ReflectUtils$2 (file:/root/.jenkins/war/WEB-INF/lib/guice-4.0.jar) to method java.lang.ClassLoader.defineClass(java.lang.String,byte[],int,int,java.security.ProtectionDomain)
WARNING: Please consider reporting this to the maintainers of com.google.inject.internal.cglib.core.$ReflectUtils$2
WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
WARNING: All illegal access operations will be denied in a future release
2021-10-12 20:54:02.813+0000 [id=29] INFO jenkins.InitReactorRunner$1#onAttained: Prepared all plugins
2021-10-12 20:54:02.821+0000 [id=34] INFO jenkins.InitReactorRunner$1#onAttained: Started all plugins
2021-10-12 20:54:02.829+0000 [id=36] INFO jenkins.InitReactorRunner$1#onAttained: Augmented all extensions
2021-10-12 20:54:04.258+0000 [id=36] INFO jenkins.InitReactorRunner$1#onAttained: System config loaded
2021-10-12 20:54:04.260+0000 [id=30] INFO jenkins.InitReactorRunner$1#onAttained: System config adapted
2021-10-12 20:54:04.261+0000 [id=30] INFO jenkins.InitReactorRunner$1#onAttained: Loaded all jobs
2021-10-12 20:54:04.263+0000 [id=34] INFO jenkins.InitReactorRunner$1#onAttained: Configuration for all jobs updated
2021-10-12 20:54:04.298+0000 [id=49] INFO hudson.model.AsyncPeriodicWork#lambda$doRun$0: Started Download metadata
2021-10-12 20:54:04.322+0000 [id=49] INFO hudson.util.Retrier#start: Attempt #1 to do the action check updates server
2021-10-12 20:54:04.683+0000 [id=29] INFO jenkins.install.SetupWizard#init:
*************************************************************
*************************************************************
*************************************************************
Jenkins initial setup is required. An admin user has been created and a password generated.
Please use the following password to proceed to installation:
7d6057560275454094da651035c7159f
This may also be found at: /root/.jenkins/secrets/initialAdminPassword
*************************************************************
*************************************************************
*************************************************************
2021-10-12 20:54:36.600+0000 [id=34] INFO jenkins.InitReactorRunner$1#onAttained: Completed initialization
2021-10-12 20:54:36.634+0000 [id=23] INFO hudson.WebAppMain$3#run: Jenkins is fully up and running
2021-10-12 20:54:37.271+0000 [id=49] INFO h.m.DownloadService$Downloadable#load: Obtained the updated data file for hudson.tasks.Maven.MavenInstaller
2021-10-12 20:54:37.272+0000 [id=49] INFO hudson.util.Retrier#start: Performed the action check updates server successfully at the attempt #1
2021-10-12 20:54:37.278+0000 [id=49] INFO hudson.model.AsyncPeriodicWork#lambda$doRun$0: Finished Download metadata. 32,968 ms
```

[docker c ubuntu файл](hw4_2/ver2/Dockerfile)
```
Running from: /usr/share/jenkins/jenkins.war
webroot: $user.home/.jenkins
2021-10-12 20:27:42.766+0000 [id=1] INFO org.eclipse.jetty.util.log.Log#initialized: Logging initialized @832ms to org.eclipse.jetty.util.log.JavaUtilLog
2021-10-12 20:27:42.873+0000 [id=1] INFO winstone.Logger#logInternal: Beginning extraction from war file
2021-10-12 20:27:44.636+0000 [id=1] WARNING o.e.j.s.handler.ContextHandler#setContextPath: Empty contextPath
2021-10-12 20:27:44.766+0000 [id=1] INFO org.eclipse.jetty.server.Server#doStart: jetty-9.4.43.v20210629; built: 2021-06-30T11:07:22.254Z; git: 526006ecfa3af7f1a27ef3a288e2bef7ea9dd7e8; jvm 11.0.11+9-Ubuntu-0ubuntu2.20.04
2021-10-12 20:27:45.492+0000 [id=1] INFO o.e.j.w.StandardDescriptorProcessor#visitServlet: NO JSP Support for /, did not find org.eclipse.jetty.jsp.JettyJspServlet
2021-10-12 20:27:45.561+0000 [id=1] INFO o.e.j.s.s.DefaultSessionIdManager#doStart: DefaultSessionIdManager workerName=node0
2021-10-12 20:27:45.561+0000 [id=1] INFO o.e.j.s.s.DefaultSessionIdManager#doStart: No SessionScavenger set, using defaults
2021-10-12 20:27:45.564+0000 [id=1] INFO o.e.j.server.session.HouseKeeper#startScavenging: node0 Scavenging every 600000ms
2021-10-12 20:27:46.507+0000 [id=1] INFO hudson.WebAppMain#contextInitialized: Jenkins home directory: /root/.jenkins found at: $user.home/.jenkins
2021-10-12 20:27:46.860+0000 [id=1] INFO o.e.j.s.handler.ContextHandler#doStart: Started w.@3cee53dc{Jenkins v2.316,/,file:///root/.jenkins/war/,AVAILABLE}{/root/.jenkins/war}
2021-10-12 20:27:46.907+0000 [id=1] INFO o.e.j.server.AbstractConnector#doStart: Started ServerConnector@3fed2870{HTTP/1.1, (http/1.1)}{0.0.0.0:8080}
2021-10-12 20:27:46.908+0000 [id=1] INFO org.eclipse.jetty.server.Server#doStart: Started @4999ms
2021-10-12 20:27:46.910+0000 [id=24] INFO winstone.Logger#logInternal: Winstone Servlet Engine running: controlPort=disabled
2021-10-12 20:27:47.405+0000 [id=31] INFO jenkins.InitReactorRunner$1#onAttained: Started initialization
2021-10-12 20:27:47.445+0000 [id=31] INFO jenkins.InitReactorRunner$1#onAttained: Listed all plugins
WARNING: An illegal reflective access operation has occurred
WARNING: Illegal reflective access by com.google.inject.internal.cglib.core.$ReflectUtils$2 (file:/root/.jenkins/war/WEB-INF/lib/guice-4.0.jar) to method java.lang.ClassLoader.defineClass(java.lang.String,byte[],int,int,java.security.ProtectionDomain)
WARNING: Please consider reporting this to the maintainers of com.google.inject.internal.cglib.core.$ReflectUtils$2
WARNING: Use --illegal-access=warn to enable warnings of further illegal reflective access operations
WARNING: All illegal access operations will be denied in a future release
2021-10-12 20:27:49.116+0000 [id=35] INFO jenkins.InitReactorRunner$1#onAttained: Prepared all plugins
2021-10-12 20:27:49.135+0000 [id=29] INFO jenkins.InitReactorRunner$1#onAttained: Started all plugins
2021-10-12 20:27:49.154+0000 [id=35] INFO jenkins.InitReactorRunner$1#onAttained: Augmented all extensions
2021-10-12 20:27:50.871+0000 [id=31] INFO jenkins.InitReactorRunner$1#onAttained: System config loaded
2021-10-12 20:27:50.873+0000 [id=31] INFO jenkins.InitReactorRunner$1#onAttained: System config adapted
2021-10-12 20:27:50.874+0000 [id=31] INFO jenkins.InitReactorRunner$1#onAttained: Loaded all jobs
2021-10-12 20:27:50.875+0000 [id=31] INFO jenkins.InitReactorRunner$1#onAttained: Configuration for all jobs updated
2021-10-12 20:27:50.934+0000 [id=51] INFO hudson.model.AsyncPeriodicWork#lambda$doRun$0: Started Download metadata
2021-10-12 20:27:50.959+0000 [id=51] INFO hudson.util.Retrier#start: Attempt #1 to do the action check updates server
2021-10-12 20:27:51.422+0000 [id=30] INFO jenkins.install.SetupWizard#init: 
*************************************************************
*************************************************************
*************************************************************
Jenkins initial setup is required. An admin user has been created and a password generated.
Please use the following password to proceed to installation:
234bfb44a9f245db9b9e9fd3c11e983f
This may also be found at: /root/.jenkins/secrets/initialAdminPassword
*************************************************************
*************************************************************
*************************************************************
2021-10-12 20:28:16.615+0000 [id=30] INFO jenkins.InitReactorRunner$1#onAttained: Completed initialization
2021-10-12 20:28:16.641+0000 [id=23] INFO hudson.WebAppMain$3#run: Jenkins is fully up and running
2021-10-12 20:28:17.253+0000 [id=51] INFO h.m.DownloadService$Downloadable#load: Obtained the updated data file for hudson.tasks.Maven.MavenInstaller
2021-10-12 20:28:17.256+0000 [id=51] INFO hudson.util.Retrier#start: Performed the action check updates server successfully at the attempt #1
2021-10-12 20:28:17.261+0000 [id=51] INFO hudson.model.AsyncPeriodicWork#lambda$doRun$0: Finished Download metadata. 26,324 ms
2021-10-12 20:29:21.989+0000 [id=74] INFO hudson.model.AsyncPeriodicWork#lambda$doRun$0: Started Periodic background build discarder
2021-10-12 20:29:22.001+0000 [id=74] INFO hudson.model.AsyncPeriodicWork#lambda$doRun$0: Finished Periodic background build discarder. 9 ms
```

Task 3: \
Создадим сеть.
```
docker network create -d bridge node_app_net
```
[docker образ приложения node.js](hw4_3/node/Dockerfile) \

Соберем образ
```
docker build -t node_app .
```
Запустим образ приложения node.js.
```
docker run -dit --name node_app_test --network=node_app_net -p 3000:3000 node_app
```
Запустим образ ubuntu.
```
docker run -dit --name ubuntu-test --network=node_app_net ubuntu:latest
```
Выполним.
```
docker exec ubuntu-test curl -v node_app_test:3000/ > curl_out.txt
```
```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0*   Trying 172.20.0.2:3000...
* TCP_NODELAY set
* Connected to node_app_test (172.20.0.2) port 3000 (#0)
> GET / HTTP/1.1
> Host: node_app_test:3000
> User-Agent: curl/7.68.0
> Accept: */*
>
* Mark bundle as not supporting multiuse
< HTTP/1.1 200 OK
< Cache-Control: private, no-cache, no-store, no-transform, must-revalidate
< Expires: -1
< Pragma: no-cache
< Content-Type: text/html; charset=utf-8
< Content-Length: 524711
< ETag: W/"801a7-7i7iWYtCHD8BTiEYmO87uSlG9KQ"
< Date: Sun, 17 Oct 2021 16:40:24 GMT
< Connection: keep-alive
< Keep-Alive: timeout=5
<
{ [14162 bytes data]
100  512k  100  512k    0     0   626k      0 --:--:-- --:--:-- --:--:--  626k
* Connection #0 to host node_app_test left intact
```
Список сетей.
```
Reist@MacBookRIK node % docker network ls
NETWORK ID     NAME                  DRIVER    SCOPE
3302249d3173   bridge                bridge    local
562f4535b135   dockerfiles_default   bridge    local
a564174e847f   host                  host      local
9db848831282   node_app_net          bridge    local
fd631c4a02ad   none                  null      local
```
