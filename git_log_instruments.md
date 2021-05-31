Task 1: aefead2207ef7e2aa5dc81a34aedf0cad4c32545 \
<code>git rev-parse aefea</code>
> aefead2207ef7e2aa5dc81a34aedf0cad4c32545

Task 2: tag: v0.12.23 \
<code>git show --pretty=oneline 85024d3</code> \
>85024d3100126de36331c6982bfaac02cdab9e76 (tag: v0.12.23) v0.12.23
 
Task 3: Формально 2 родителя: 9ea88f22f 56cd7859e \
<code>git log --pretty='%h %s' --graph b8d720 -n 3</code>
\*   b8d720f83 Merge pull request #23916 from hashicorp/cgriggs01-stable \
>|\\\
>| * 9ea88f22f add/update community provider listings \
>|/
>\*   56cd7859e Merge pull request #23857 from hashicorp/cgriggs01-stable \
>|\

Task 4: \
<code>git log --pretty=oneline v0.12.24 --not v0.12.23</code> \
<code>git log --pretty=oneline v0.12.23 --not v0.12.24</code>

>33ff1c03bb960b332be3af2e333462dde88b279e (tag: v0.12.24) v0.12.24 \
>b14b74c4939dcab573326f4e3ee2a62e23e12f89 [Website] vmc provider links \
>3f235065b9347a758efadc92295b540ee0a5e26e Update CHANGELOG.md \
>6ae64e247b332925b872447e9ce869657281c2bf registry: Fix panic when server is unreachable \
>5c619ca1baf2e21a155fcdb4c264cc9e24a2a353 website: Remove links to the getting started guide's old location \
>06275647e2b53d97d4f0a19a0fec11f6d69820b5 Update CHANGELOG.md \
>d5f9411f5108260320064349b757f55c09bc4b80 command: Fix bug when using terraform login on Windows \
>4b6d06cc5dcb78af637bbb19c198faff37a066ed Update CHANGELOG.md \
>dd01a35078f040ca984cdd349f18d0b67e486c35 Update CHANGELOG.md \
>225466bc3e5f35baa5d07197bbc079345b77525e Cleanup after v0.12.23 release \


Task 5: 8c928e835 \
<code>git log --oneline -G'func\sproviderSource\('</code>
>5af1e6234 main: Honor explicit provider_installation CLI config when present \
>8c928e835 main: Consult local directories as potential mirrors of providers \

Task 6: 
* 78b12205587fe839f10d946ea3fdc06719decb05
* 52dbf94834cb970b510f2fba853a5b49ad9b1a46
* 41ab0aef7a0fe030e84018973a64135b11abcd70 
* 66ebff90cdfaa6938f26f908c7ebad8d547fea17
* 8364383c359a6b738a436d1b7745ccdce178df47 

<p>1) Нашли коммит в котором функция была добавленя или удалена</p>

<code>git log --oneline -G'func\sglobalPluginDirs\('</code>

> 8364383c3 Push plugin discovery down into command package

<p>2) Вытащим из инфы о коммите файл в котором живет функция</p>

<code>git diff-tree -p 8364383c3</code>

> diff --git a/plugins.go b/plugins.go \
> new file mode 100644 \
> index 000000000..9717724a0 \
> --- /dev/null \
> +++ b/plugins.go \
> @@ -0,0 +1,37 @@ \
> +package main \
> \+ \
> +import ( \
> \+ "log" \
> \+ "path/filepath" \
> \+ \
> \+ "github.com/kardianos/osext" \
> +) \
> \+ \
> +// globalPluginDirs returns directories that should be searched for \
> +// globally-installed plugins (not specific to the current configuration). \
> +// \
> +// Earlier entries in this slice get priority over later when multiple copies \
> +// of the same plugin version are found, but newer versions always override \
> +// older versions where both satisfy the provider version constraints. \
> +func globalPluginDirs() []string \

<p>3) Ищем коммиты с изменениями</p>

<code>git log -L :globalPluginDirs:plugins.go --pretty=oneline</code>


> 78b12205587fe839f10d946ea3fdc06719decb05 Remove config.go and update things using its aliases \
> diff --git a/plugins.go b/plugins.go \
> --- a/plugins.go \
> +++ b/plugins.go \
> @@ -16,14 +18,14 @@ \
> func globalPluginDirs() []string { \
>         var ret []string \
>         // Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX \
> \-       dir, err := ConfigDir() \
> \+       dir, err := cliconfig.ConfigDir() \
>         if err != nil { \
>                 log.Printf("[ERROR] Error finding global config directory: %s", err) \
>         } else { \
>                 machineDir := fmt.Sprintf("%s_%s", runtime.GOOS, runtime.GOARCH) \
>                 ret = append(ret, filepath.Join(dir, "plugins")) \
>                 ret = append(ret, filepath.Join(dir, "plugins", machineDir)) \
>         } \
>         return ret \
>  } \
> 52dbf94834cb970b510f2fba853a5b49ad9b1a46 keep .terraform.d/plugins for discovery \
> diff --git a/plugins.go b/plugins.go \
> --- a/plugins.go \
> +++ b/plugins.go \
> @@ -16,13 +16,14 @@ \
>  func globalPluginDirs() []string { \
>         var ret []string \
>         // Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX \
>         dir, err := ConfigDir() \
>         if err != nil { \
>                 log.Printf("[ERROR] Error finding global config directory: %s", err) \
>         } else { \
>                 machineDir := fmt.Sprintf("%s_%s", runtime.GOOS, runtime.GOARCH) \
> \+               ret = append(ret, filepath.Join(dir, "plugins")) \
>                 ret = append(ret, filepath.Join(dir, "plugins", machineDir)) \
>         } \
>        return ret \
> } \
> 41ab0aef7a0fe030e84018973a64135b11abcd70 Add missing OS_ARCH dir to global plugin paths \
> diff --git a/plugins.go b/plugins.go \
> --- a/plugins.go \
> +++ b/plugins.go \
> @@ -14,12 +16,13 @@ \
>  func globalPluginDirs() []string { \
>         var ret []string \
>         // Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX \
>         dir, err := ConfigDir() \
>         if err != nil { \
>                 log.Printf("[ERROR] Error finding global config directory: %s", err) \
>         } else { \
> \-               ret = append(ret, filepath.Join(dir, "plugins")) \
> \+               machineDir := fmt.Sprintf("%s_%s", runtime.GOOS, runtime.GOARCH) \
> \+               ret = append(ret, filepath.Join(dir, "plugins", machineDir)) \
>         } \
>         return ret \
>  } \
> 66ebff90cdfaa6938f26f908c7ebad8d547fea17 move some more plugin search path logic to command \
> diff --git a/plugins.go b/plugins.go \
> --- a/plugins.go \
> +++ b/plugins.go \
> @@ -16,22 +14,12 @@ \
> func globalPluginDirs() []string { \
>        var ret []string \
> \- \
> \-       // Look in the same directory as the Terraform executable. \
> \-       // If found, this replaces what we found in the config path. \
> \-       exePath, err := osext.Executable() \
> \-       if err != nil { \
> \-               log.Printf("[ERROR] Error discovering exe directory: %s", err) \
> \-       } else { \
> \-               ret = append(ret, filepath.Dir(exePath)) \
> \-       } \
> \- \
>         // Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX \
>         dir, err := ConfigDir() \
>         if err != nil { \
>                 log.Printf("[ERROR] Error finding global config directory: %s", err) \
>         } else { \
>                 ret = append(ret, filepath.Join(dir, "plugins")) \
>         } \
>         return ret \
>  } \
> 8364383c359a6b738a436d1b7745ccdce178df47 Push plugin discovery down into command package \
> diff --git a/plugins.go b/plugins.go \
> --- /dev/null \
> +++ b/plugins.go \
> @@ -0,0 +16,22 @@ \
> +func globalPluginDirs() []string { \
> \+       var ret []string \
> \+       // Look in the same directory as the Terraform executable. \
> \+       // If found, this replaces what we found in the config path. \
> \+       exePath, err := osext.Executable() \
> \+       if err != nil { \
> \+               log.Printf("[ERROR] Error discovering exe directory: %s", err) \
> \+       } else { \
> \+               ret = append(ret, filepath.Dir(exePath)) \
> \+       } \
> \+       // Look in ~/.terraform.d/plugins/ , or its equivalent on non-UNIX \
> \+       dir, err := ConfigDir() \
> \+       if err != nil { \
> \+               log.Printf("[ERROR] Error finding global config directory: %s", err) \
> \+       } else { \
> \+               ret = append(ret, filepath.Join(dir, "plugins")) \
> \+       } \
> \+       return ret \
> \+}

Task 7: James Bardin <j.bardin@gmail.com>

<code>git log -G'func\ssynchronizedWriters\('</code>

> commit bdfea50cc85161dea41be0fe3381fd98731ff786 \
> Author: James Bardin <j.bardin@gmail.com> \
> Date:   Mon Nov 30 18:02:04 2020 -0500 \
> \
>     remove unused \
> \
> commit bdfea50cc85161dea41be0fe3381fd98731ff786 \
> Author: James Bardin <j.bardin@gmail.com> \
> Date:   Mon Nov 30 18:02:04 2020 -0500 \
> \
>     remove unused \
> \
> commit 5ac311e2a91e381e2f52234668b49ba670aa0fe5 \
> Author: Martin Atkins <mart@degeneration.co.uk> \
> Date:   Wed May 3 16:25:41 2017 -0700 \
> \
>     main: synchronize writes to VT100-faker on Windows \
> \
>     We use a third-party library "colorable" to translate VT100 color \
>     sequences into Windows console attribute-setting calls when Terraform is \
>     running on Windows. \
> \
>     colorable is not concurrency-safe for multiple writes to the same console, \
>     because it writes to the console one character at a time and so two \
>     concurrent writers get their characters interleaved, creating unreadable \
>     garble. \
> \
>     Here we wrap around it a synchronization mechanism to ensure that there \
>     can be only one Write call outstanding across both stderr and stdout, \
>     mimicking the usual behavior we expect (when stderr/stdout are a normal \
>     file handle) of each Write being completed atomically. \

