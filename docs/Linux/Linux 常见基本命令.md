# [Linux 常见基本命令]()

## 切换/退出 root 权限

``` shell
sudo su     # 进入 root 模式

su huaxv    # 退出 root 模式
```

## 查看当前路径 **pwd**

``` shell
pwd
```

## 清屏 **clear**

``` shell
clear
```

## 查看当前目录文件 **ls**

``` shell
ls -a   # 列出目录所有文件

ls -t   # 以修改时间排序
ls -s   # 以文件大小排序
ls -r   # 倒序排列

ls -h   # 以易读大小显示
ls -l   # 显示文件的详细信息
```

## 切换目录 **cd**

```shell
cd ~    # 切换到 /home/huaxv 目录

cd /    # 进入根目录

cd -    # 进入上一次的工作目录
```

## 创建文件夹 **mkdir**

```shell
mkdir -p ~/desktop/     # 在 /home/huaxv 下新建文件夹 desktop

mkdir desktop       # 在当前目录下新建文件夹 desktop
```

## 创建文件 **touch**

```shell
touch test.txt      # 创建文件 test.txt

touch ~/desktop/files/test_{1..10}.txt  # 批量创建文件
```

## 删除文件和文件夹 **rm**

```shell
rm *.txt    # 删除 txt 文件

rm -r files # 删除文件夹 files
```

## 移动文件或文件夹 **mv**

```shell
mv code demo        # 将 code 移动成 demo
mv code demo/code   # 将 code 移动到 demo 文件夹下改名成 code

mv test.txt test.cpp    # 将 test.txt 移动到当前目录下并改名成 test.cpp
```

## 复制文件或文件夹 **cp**

```shell
cp code demo        # 将 code 复制成 demo
cp code demo/code   # 将 code 复制到 demo 文件夹下改名成 code

cp test.txt test.cpp    # 将 test.txt 复制到当前目录下并改名成 test.cpp
```

## 展示文件内容 **cat**

```shell
cat test.txt    # 展示文件 test.txt 的内容
```
