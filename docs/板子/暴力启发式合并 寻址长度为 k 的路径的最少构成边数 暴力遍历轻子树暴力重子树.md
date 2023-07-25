# [暴力启发式合并 寻址长度为 k 的路径的最少构成边数 暴力遍历轻子树暴力重子树](https://www.luogu.com.cn/problem/P4149)

保留重树的内容，但是可以对轻子树暴力遍历一遍完全没有问题。

不选择保留当前的信息，是当前树、子树的信息可以完全删除不用保留。

时间复杂度：$O(n \log(n))$

```c++
#include <bits/stdc++.h>

const long long N = 2e6;
long long n, m;
long long g[N], e[N], w[N], ne[N], ant;

void add(long long x, long long y, long long z)
{
    ant ++;
    e[ant] = y;
    w[ant] = z;
    ne[ant] = g[x];
    g[x] = ant;
} 

long long size[N], hson[N], hsonw[N];
long long __;

void dfs_1(long long u, long long v)
{
    size[u] = 1;
    for (long long i = g[u]; i; i = ne[i])
    {
        if (e[i] == v) continue;
        dfs_1(e[i], u);
        size[u] += size[e[i]];
        if (hson[u] == 0 || size[hson[u]] < size[e[i]])
        {
            hson[u] = e[i];
            hsonw[u] = w[i];
        }
    }
}

long long ans = 1e9;
std::map<long long, long long> mp;
long long sum, len;

void find_ans(long long u, long long v, long long sm, long long ln)
{
    long long x_ = sm - sum;
    long long y_ = ln - len;
    if (mp.count(m - sum))
    {
        ans = std::min(ans, mp[m - sum] + len);
    }
    if (mp.count(m - sum - sm))
    {
        ans = std::min(ans, mp[m - sum - sm] + len + ln);
    }
    for (long long i = g[u]; i; i = ne[i])
    {
        if (e[i] == v) continue;
        find_ans(e[i], u, sm + w[i], ln + 1);
    }
}

void add_path(long long u, long long v, long long sm, long long ln)
{
    long long x_ = sm - sum;
    long long y_ = ln - len;
    if (mp.count(x_))
    {
        mp[x_] = std::min(mp[x_], y_);
    }
    else 
    {
        mp[x_] = y_;
    }
    for (long long i = g[u]; i; i = ne[i])
    {
        if (e[i] == v) continue;
        add_path(e[i], u, sm + w[i], ln + 1);
    }
}

void dfs_2(long long u, long long v, long long keep)
{
    for (long long i = g[u]; i; i = ne[i])
    {
        if (e[i] == v || e[i] == hson[u]) continue;
        dfs_2(e[i], u, 0);
    }
    
    if (hson[u]) 
    {
        dfs_2(hson[u], u, 1);
        sum += hsonw[u];
        len += 1;
        mp[hsonw[u] - sum] = 1 - len;
        if (mp.count(m - sum))
        {
            ans = std::min(mp[m - sum] + len, ans);
        }
    }
    
    for (long long i = g[u]; i; i = ne[i])
    {
        if (e[i] == v || e[i] == hson[u]) continue;
        find_ans(e[i], u, w[i], 1);
        add_path(e[i], u, w[i], 1);
    }
    
    if (keep == 0)
    {
        sum = 0; len = 0; mp.clear();
    }
}

void solve()
{
    std::cin >> n >> m;
    for (long long i = 1; i < n; i ++)
    {
        long long x, y, z; std::cin >> x >> y >> z;
        x ++; y ++;
        add(x, y, z); add(y, x, z);
    }
    
    dfs_1(1, 0);
    dfs_2(1, 0, 1);
    if (ans == 1e9) ans = -1;
    std::cout << ans << '\n';
}

int main()
{
    std::ios::sync_with_stdio(0);
    std::cin.tie(0); std::cout.tie(0);
    
    solve();
    return 0;
}
```
