# [倍增法求最近公共祖先 LCA](https://www.luogu.com.cn/problem/P3379)

倍增思想

- 先将两个节点提到相同高度
- 再去查找它们的祖先

```c++
#include <bits/stdc++.h>


const long long N = 1e6 + 10;
long long n, m, R;
long long g[N], e[N], ne[N], ant;
long long ST[N][25];
long long deep[N];

void add(long long x, long long y)
{
    ant ++;
    e[ant] = y;
    ne[ant] = g[x];
    g[x] = ant;
}

// 初始化每个节点的祖宗是谁
// 核心思想还是基于动态规划
// 令 ST[u][i] 表示成 u 的第 1 << i 位祖先
// 那么 ST[u][i - 1] 的第 1 << i - 1 位祖先是不是 ST[u][i] 呢？
// 倍增是翻倍加法, u 的 1 << i - 1 的 1 << i - 1 = 1 << i
void dfs_dp(long long u, long long fa)
{
    ST[u][0] = fa;
    deep[u] = deep[fa] + 1;
    for (long long i = 1; i < 25; i ++)
    {
        ST[u][i] = ST[ST[u][i - 1]][i - 1];
    }
    for (long long i = g[u]; i; i = ne[i])
    {
        if (e[i] == fa) continue;
        dfs_dp(e[i], u);
    }
}

// 查找 u 和 v 的最近公共祖先
//      - 提到相同高度
//      - 遍历公共祖先
long long dfs_LCA(long long u, long long v)
{
    if (u == v) return u;
    
    if (deep[u] != deep[v])
    {
        if (deep[u] > deep[v]) std::swap(u, v);
        for (long long i = 24; ~i; i --)
        {
            long long gf = ST[v][i];
            if (deep[gf] >= deep[u]) 
            {
                v = gf; break;
            }
        }
        return dfs_LCA(u, v);
    }
    else
    {
        if (ST[u][0] == ST[v][0]) return ST[u][0];
        
        for (long long i = 24; ~i; i --)
        {
            if (ST[u][i] != ST[v][i])
            {
                u = ST[u][i];
                v = ST[v][i];
                break;
            }
        }
        
        return dfs_LCA(u, v);
    }
    
}

void solve()
{
    
    std::cin >> n >> m >> R;
    for (long long i = 1; i < n; i ++)
    {
        long long x, y; std::cin >> x >> y;
        add(x, y); add(y, x);
    }
    
    dfs_dp(R, 0);
    
    while (m --)
    {
        long long x, y; std::cin >> x >> y;
        std::cout << dfs_LCA(x, y) << '\n';
    }
    
}

int main()
{
    std::ios::sync_with_stdio(0);
    std::cin.tie(0); std::cout.tie(0);
    
    
    solve();
    return 0;
}

```
