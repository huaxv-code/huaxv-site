# [tmux 使用]()

## **session**

### 创建 `session`

```shell
tmux new -s desktop
```

### 查看 `session` 列表

```shell
tmux ls
```

### 删除指定的 `session`

```shell
tmux kill-session -t desktop
```

### 退出 `session`

`ctrl + b, d`

### 进入指定 `session`

```shell
tmux at -t desktop
```

---

---


## **window**

### 创建 window

```ctrl + b, c```

### 查看 window 列表

```ctrl + b, w```

### 删除 window

```ctrl + b, &```

---

---

## **panl**

### 分左右两屏

`ctrl + b, %` 切分左右两屏幕

### 上下两屏

`ctrl + b, "`，切分上下两屏幕

### 关闭当前屏幕

`ctrl + d`，关闭当前屏幕

### 切换屏幕

`ctrl + b，方向键`，根据方向键切换屏幕

### 调整屏幕

`ctrl + (b, 方向键)`，根据方向键调整屏幕大小
