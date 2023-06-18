# cmd 小脚本

## 编译选项

=== "compiler_c.bat"

    ```bat
    @echo off

    ccache gcc -w -std=c99 -static %*.cpp -o %* -O2 -Wall -Wextra -Wl,--stack=134217728
    ```

=== "compiler_cpp.bat"

    ```bat
    @echo off

    ccache g++ -w -std=c++14 -static %*.cpp -o %* -O2 -Wall -Wextra -Wl,--stack=134217728
    ```

=== "compiler_java.bat"

    ```bat
    @echo off

    javac -encoding utf8 %*.java
    ```

## 耗时统计脚本

=== "UseTime.py"

    ```py
    import re
    import sys
    import os
    import time
    import signal
    from multiprocessing import Process

    def main():
        sls = sys.argv
        s = ""
        for i in range(1, len(sls)):
            s += sls[i] + " "
        s = s[:-1]
        
        start = time.time()
        os.system(s)
        end = time.time()
        
        start = int(start * 1000)
        end = int(end * 1000)
        
        print('耗时  %d  ms' % (end - start))
        
    if __name__ == '__main__':
        
        p = Process(target=main)
        p.start()
        
        for i in range(500):
            if p.is_alive():
                if os.path.getsize('out.txt') >= 100 * 1024 * 1024:
                    if p.is_alive():
                        os.system(f'taskkill /pid {p.pid} -t -f 1>nul 2>nul')
                    p.join()
                    
                    print("输出超限！")
                    os.system('type nul > out.txt')
                    exit()
                time.sleep(0.01)
            else :
                exit()

        if p.is_alive():
            os.system(f'taskkill /pid {p.pid} -t -f 1>nul 2>nul')
        p.join()
        
        print("运行超时！")
        os.system('type nul> out.txt')
        # g++ Main.cpp -o Main && python -u UseTime.py Main
    ```

## 初始化项目文件脚本

=== "create_files.bat"

    ```bat
    @echo off

    copy %~dp0UseTime.py UseTime.py > nul
    copy %~dp0EncodePy.py EncodePy.py > nul
    if not exist in.txt type nul> in.txt
    type nul> out.txt
    type nul> .out.txt
    if not exist res.txt type nul> res.txt
    ```

## 解决 python 重定向到文件乱码问题

=== "EncodePy.py"

    ```py
    with open('.out.txt', encoding='gbk', mode='r') as cin, open('out.txt', encoding='utf-8', mode='w') as cout:
        cout.write(cin.read())
    ```

## mkdocs 编译并提交脚本

=== "push.bat"

    ```bat
    @echo off

    mkdocs build && git add . && git commit -m "%*" && git push
    ```

## 运行程序脚本

=== "run_c.bat"

    ```bat
    @echo off

    %* <in.txt >out.txt
    ```

=== "run_cpp.bat"

    ```bat
    @echo off

    %* <in.txt >out.txt
    ```

=== "run_java.bat"

    ```bat
    @echo off

    java %* <in.txt >out.txt
    ```

=== "run_python.bat"

    ```bat
    @echo off

    python -u %*.py <in.txt >.out.txt

    python -u EncodePy.py
    ```

## 运行脚本

=== "running_code.bat"

    ```bat
    @echo off

    set d=%1

    cd %d:~1,-1%

    if "%2" == "c" (create_files && compiler_c %3 && python -u UseTime.py run_c %3)
    if "%2" == "cpp" (create_files && compiler_cpp %3 && python -u UseTime.py run_cpp %3)
    if "%2" == "java" (create_files && compiler_java %3 && python -u UseTime.py run_java %3)
    if "%2" == "py" (create_files && python -u UseTime.py run_python %3)
    ```

=== "pip 下载"

    ```bat
    @echo off

    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple --upgrade pip

    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pymssql 

    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple requests

    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pymysql

    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple mkdocs-material

    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple mkdocs-glightbox

    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple numpy

    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple matplotlib

    pip install -i https://pypi.tuna.tsinghua.edu.cn/simple pyodbc
    ```

## 文件打包下载

[Cmd_Tool.zip](./Cmd_Tool.zip)