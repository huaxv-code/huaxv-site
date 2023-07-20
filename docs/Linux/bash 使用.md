# [bash 使用]()

## 创建批处理文件 **test.sh**

```shell
#! /bin/bash

echo "hello world!"
```

## 执行批处理文件 **bash**

方式一：

```shell
bash test.sh
```

方式二：

```shell
chmod +x test.sh    # 使 test.sh 具有可执行的权限

./test.sh           # 执行 test.sh 脚本
```

## 添加全局环境变量

```shell
vi /etc/profile

# 在末尾添加
export PATH="${PATH}:/home/huaxv/.huaxv_cmd/bin"

# 应用修改
source /etc/profile

# 查看环境变量
echo $PATH
```

## 注释

```shell
# 这是一行注释

```

```shell
:<< note

这是多行注释

note
```

## 变量

单引号和双引号虽然都表示字符串，但是双引号里面的变量还是可以执行！

```shell
#! /bin/bash

author='huaxv'
email='huaxv@qq.com'

info="author = ${author}, email = ${email}"

echo $author
echo $email
echo $info
```

将变量设置成只读变量：

```shell
name='huaxv'
declare -r name     # 将 name 声明为只读变量
```

删除变量：

```shell
name='huaxv'
unset name
```

获取字符串长度：

```shell
name="huaxv"

len=${#name}
```


字符串切片：

```shell
email='huaxv-home@qq.com'

name=${email:0:5}
```

## 传递参数

**$#**  获取传入的参数个数

**$\*** 将传入的参数全部输出

**$1**  获取第一个传递参数

**$$**  获取当前进程的 id

## 数组

```shell
a=(1 2 "hello world")

a[3]="c++"
a[4]="java"
a[5]="python"

echo ${a[0]}
echo ${a[1]}
echo ${a[2]}
echo ${a[3]}
echo ${a[4]}
echo ${a[5]}

echo ${a[*]} # 遍历整个数组

echo ${#a[*]} # 获取整个数组的长度
```

## 输入 **read**

```shell
>> read -p "please input your name: " name
please input your name: huaxv
>> echo $name
huaxv 
```

## 格式化输出 **printf**

```shell
#! /bin/bash

printf "please input your name: "
read name

printf "please input the value of \$a: "
read a

printf "please input the value of \$b: "
read b

printf "\n\nI think your name is: %s\n" $name
printf "%5d*%5d=%5d\n" $a $b `expr $a '*' $b`
```

## 