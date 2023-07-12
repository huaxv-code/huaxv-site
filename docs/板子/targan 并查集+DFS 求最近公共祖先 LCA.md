# [targan 并查集+DFS 求最近公共祖先 LCA](https://www.luogu.com.cn/problem/P3379)

先简化成二叉树的模型

如果某子树的根节点 $u$，能够作为某两点 $x$ 和 $y$ 的最近公共祖先，那么 $x$ 和 $y$ 必定分别坐落与 $u$ 的左子树和右子树
 
利用 $dfs$ 遍历的特性，先遍历完节点 $x$ 后，逐渐回溯，将 $u$ 的左子树都归类与 $u$ 再去遍历右子树，如果某次询问的某个节点已经被遍历过，那么这次询问的最近公共祖先都是 $u$。

```c++
#include <bits/stdc++.h>


const long long N = 2e6;
long long n, m, R;
long long g[N], e[N], ne[N], ant;

std::vector<long long> edges[N];
std::pair<long long, long long> querys[N];

void add(long long x, long long y)
{
    ant ++;
    e[ant] = y;
    ne[ant] = g[x];
    g[x] = ant;
}

// 并查集
long long dsu[N];
long long vis[N];

void init()
{
    for (long long i = 1; i < N; i ++)
        dsu[i] = i;
}

long long find(long long x)
{
    if (x == dsu[x]) return x;
    return dsu[x] = find(dsu[x]);
}

void set_fa(long long x, long long fa)
{
    long long t = find(x);
    dsu[t] = fa;
}

std::map<std::pair<long long, long long>, long long> mp;

void dfs(long long u, long long fa)
{
    vis[u] = 1;
    
    for (long long v : edges[u])
    {
        if (vis[v])
        {
            long long gf = find(v);
            mp[{u, v}] = mp[{v, u}] = gf;
        }
    }
    
    for (long long i = g[u]; i; i = ne[i])
    {
        if (e[i] == fa) continue;
        
        dfs(e[i], u);
        set_fa(e[i], u);
    }
}

void solve()
{
    
    std::cin >> n >> m >> R;
    init();
    for (long long i = 1; i < n; i ++)
    {
        long long x, y; std::cin >> x >> y;
        add(x, y);
        add(y, x);
    }
    
    for (long long i = 1; i <= m; i ++)
    {
        long long x, y; 
        std::cin >> x >> y;
        
        querys[i].first = x; 
        querys[i].second = y;
        
        edges[x].push_back(y);
        edges[y].push_back(x);
    }
    
    dfs(R, 0);
    
    for (long long i = 1; i <= m; i ++)
    {
        std::cout << mp[{querys[i]}] << '\n';
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
