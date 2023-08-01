# [神 tm 搜索树](https://acm.hdu.edu.cn/showproblem.php?pid=7332)

```c++
#include <bits/stdc++.h>

const long long N = 5e6 + 100;
long long n;
struct Node
{
    long long e, ne;
} nd[N];
long long ant;
long long g[N];
long long link[N];
long long point[N];
long long hson[N];
long long LOG[N];

void add_g(long long x, long long y)
{
    ant ++;
    nd[ant].e = y;
    nd[ant].ne = g[x];
    g[x] = ant;
}

void add_link(long long x, long long y)
{
    ant ++;
    nd[ant].e = y;
    nd[ant].ne = link[x];
    link[x] = ant;
}

void add_point(long long x, long long y)
{
    ant ++;
    nd[ant].e = y;
    nd[ant].ne = point[x];
    point[x] = ant;
}

void dfs_init(long long u, long long head, long long on)
{
    add_link(head, u);
    if (on) add_point(on, u);
    for (long long i = g[u]; i; i = nd[i].ne)
    {
        if (hson[u] == nd[i].e) dfs_init(nd[i].e, head, 0);
        else dfs_init(nd[i].e, nd[i].e, u);
    }
}

long long dfs_solve(long long u)
{
    long long link_len = 0;
    long long res = 0;
    for (long long i = point[u]; i; i = nd[i].ne)
    {
        long long t = dfs_solve(nd[i].e);
        if (t > res) res = t;
    }
    for (long long i = link[u]; i; i = nd[i].ne)
    {
        link_len ++;
        long long v = nd[i].e;
        if (v == u) continue;
        long long t = dfs_solve(v) - 1;
        if (t > res) res = t;
    }
    if (link_len == 0 || link_len == 1) return res + 1;
    long long t = LOG[link_len];
    res += t + 1;
    if ((1 << t) != link_len) res ++;
    return res;
}

void solve()
{
    std::cin >> n;
    for (long long i = 0; i <= ant; i ++)
    {
        nd[i].e = nd[i].ne = 0;
    }
    ant = 0;
    for (long long i = 1; i <= n; i ++)
    {
        g[i] = link[i] = point[i] = 0;
    }
    for (long long i = 1; i <= n; i ++)
    {
        long long x; std::cin >> x;
        add_g(x, i);
    }
    for (long long i = 1; i <= n; i ++)
    {
        long long x; std::cin >> x;
        hson[i] = x;
    }
    dfs_init(1, 1, 0);
    std::cout << dfs_solve(1) << '\n';
}

int main()
{
    int size(512<<20); // 512M
    __asm__ ( "movq %0, %%rsp\n"::"r"((char*)malloc(size)+size)); // YOUR CODE
    std::ios::sync_with_stdio(0);
    std::cin.tie(0); std::cout.tie(0);
    for (long long i = 2; i < N; i ++) 
        LOG[i] = LOG[i >> 1] + 1;
    long long t; std::cin >> t; while (t --)
    solve();
    exit(0);
    return 0;
}
```
