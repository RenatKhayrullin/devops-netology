Task 1:

>a = 1 \
>b = '2' \
>c = a + b 

<code>c = a + b</code> -- вернет ошибку приведения типов

<code>c = str(a) + b</code> --  12 типа string

<code>c = a + int(b)</code> -- 3 типа integer

Task 2: 

```
import os

git_possible_statuses = {
    "modified",
    "added",
    "deleted",
    "renamed",
    "copied",
    "new file",
    "unmerged"
}


def check_repository(git_repository_path):
    bash_command = ["export LANG=en_GB git", git_repository_path, "git status"]

    result_os = os.popen(' && '.join(bash_command)).read()
    result_rows = result_os.split('\n')

    for prefix in git_possible_statuses:
        for result in result_rows:
            if result.find(prefix) != -1:
                prepare_result = result.replace('\t%s:   ' % prefix, '')
                print(prepare_result)


if __name__ == '__main__':
    path = "cd ~/netology/sysadm-homeworks"
    check_repository(path)
```

Task 3: 

```
import os
import sys
import git #pip install gitpython 

git_possible_file_statuses = {
    "modified",
    "added",
    "deleted",
    "renamed",
    "copied",
    "new file",
    "unmerged"
}


def is_git_repo(git_repository_path):
    try:
        _ = git.Repo(git_repository_path).git_dir
        return True
    except git.exc.InvalidGitRepositoryError:
        return False


def check_repository(git_repository_path):
    cd_command = "cd " + git_repository_path;
    bash_command = ["export LANG=en_GB git", cd_command, "git status"]

    result_os = os.popen(' && '.join(bash_command)).read()
    result_rows = result_os.split('\n')

    for prefix in git_possible_file_statuses:
        for result in result_rows:
            if result.find(prefix) != -1:
                prepare_result = result.replace('\t%s:   ' % prefix, '')
                print(prepare_result)


if __name__ == '__main__':

    path = sys.argv[1]

    if path is None:
        print("Need to enter path argument")

    isDirectory = os.path.isdir(path)

    if not isDirectory:
        print("Entered path is incorrect or doesn't exist")

    if not is_git_repo(path):
        print("Entered path is not Git repository")

    check_repository(path)
```

Task 4:

