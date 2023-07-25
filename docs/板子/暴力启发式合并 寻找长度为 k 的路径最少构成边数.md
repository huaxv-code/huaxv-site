# [暴力启发式合并 寻找长度为 k 的路径最少构成边数](https://www.luogu.com.cn/problem/P4149)

先遍历重儿子

将儿子们的信息合并到根节点上，将信息少的合并到信息大的上面

时间复杂度：$n\log(n)$

空间复杂度：$n ^ 2$

```c++
#include <bits/stdc++.h>

const long long N = 4e5 + 10;
const long long M = 2e5 + 10;
long long n, m;
long long g[N], e[N], ne[N], w[N], ant;
std::map<long long, long long> mp[M];
long long tag[M], len[M];
long long size[M], hson[M], hsonw[M];
long long ans = 1e9;

void add(long long x, long long y, long long z)
{
    e[ant] = y;
    w[ant] = z;
    ne[ant] = g[x];
    g[x] = ant;
    ant ++;
}

void dfs_1(long long u, long long v)
{
    size[u] = 1;
    for (long long i = g[u]; ~i; i = ne[i])
    {
        if (e[i] == v) continue;
        dfs_1(e[i], u);
        size[u] += size[e[i]];
        if (hson[u] == -1 || (size[hson[u]] < size[e[i]]))
        {
            hson[u] = e[i];
            hsonw[u] = w[i];
        }
    }
}

void print(long long v)
{
    std::cout << v << ": \n";
    for (auto [x, y] : mp[v])
    {
        long long x_ = x + tag[v];
        long long y_ = y + len[v];
        
        std::cout << x_ << " -> " << y_ << '\n';
    }
    
    std::cout << '\n';
}

void merge(long long u, long long v)
{
    long long rt = u;
    
    // print(u);
    // print(v);
    
    if (mp[u].size() < mp[v].size()) std::swap(u, v);
    if (mp[u].count(m - tag[u]))
    {
        ans = std::min(ans, mp[u][m - tag[u]] + len[u]);
    }
    if (mp[v].count(m - tag[v]))
    {
        ans = std::min(ans, mp[v][m - tag[v]] + len[v]);
    }
    for (auto [x, y] : mp[v])
    {
        long long x_ = x + tag[v];
        long long y_ = y + len[v];
        if (x_ > m) continue;
        if (mp[u].count(m - tag[u] - x_))
        {
            ans = std::min(ans, mp[u][m - tag[u] - x_] + len[u] + y_);
        }
    }
    for (auto [x, y] : mp[v])
    {
        long long x_ = x + tag[v];
        long long y_ = y + len[v];
        if (x_ > m) continue;
        // if (mp[u].count(m - tag[u] - x_))
        // {
        //     ans = std::min(ans, mp[u][m - tag[u] - x_] + len[u] + y_);
        // }
        if (mp[u].count(x_ - tag[u]))
        {
            mp[u][x_ - tag[u]] = std::min(mp[u][x_ - tag[u]], y_ - len[u]);
        }
        else
        {
            mp[u][x_ - tag[u]] = y_ - len[u];
        }
    }
    std::map<long long, long long>().swap(mp[v]);
    mp[rt] = mp[u];
    auto st = mp[rt].lower_bound(m - tag[rt] + 1);
    mp[rt].erase(st, mp[rt].end());
    tag[rt] = tag[u];
    len[rt] = len[u];
    
    // print(rt);
    // std::cout << "------------------------\n\n";
}

void dfs_2(long long u, long long v)
{
    mp[u][0] = 0;
    if (hson[u] != -1)
    {
        dfs_2(hson[u], u);
        tag[hson[u]] += hsonw[u];
        len[hson[u]] += 1;
        merge(u, hson[u]);
    }
    for (long long i = g[u]; ~i; i = ne[i])
    {
        if (e[i] == v) continue;
        if (e[i] == hson[u]) continue;
        dfs_2(e[i], u);
        tag[e[i]] += w[i];
        len[e[i]] += 1;
        merge(u, e[i]);
    }
}

void solve()
{
    std::cin >> n >> m;
    memset(g, -1, sizeof g);
    memset(e, -1, sizeof e);
    memset(ne, -1, sizeof ne);
    memset(hson, -1, sizeof hson);
    for (long long i = 1; i < n; i ++)
    {
        long long x, y, z; std::cin >> x >> y >> z;
        add(x, y, z); add(y, x, z);
    }
    dfs_1(0, -1);
    dfs_2(0, -1);
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
