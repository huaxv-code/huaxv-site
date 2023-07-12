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

## 创建文件夹 $mkdir$

```shell
mkdir -p ~/desktop     # 在 /home/huaxv 下新建文件夹 desktop

mkdir desktop          # 在当前目录下新建文件夹 desktop
```
