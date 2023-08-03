# [ST 表 求解走 L 步的终点问题](https://acm.hdu.edu.cn/showproblem.php?pid=7345)

在一幅边数和顶点数都为 $n$ 的有向图中

问从点 $x$ 出发走 $l$ 步会到达哪个终点呢？

非常注意：$l \leq 10 ^ 9$

如果我知道了从点 $x$ 出发走 $2 ^ k$ 步到达的终点是 $y$，如果我又知道了从点 $y$ 出发走 $2 ^ k$ 步到达的终点是 $z$

那么我是不是就知道从点 $x$ 出发走 $2 ^ {k + 1}$ 步会到达点 $z$ 了呢？

```c++
#include <bits/stdc++.h>

const long long M = 32;
const long long N = 2e5;
const long long mod = 1e9 + 7;
const long long inf = ~(1ll << 63);
long long n, m;
struct Node {
    long long k, b;
};
Node a[N];
Node dp[M + 10][N];
long long fa[M + 10][N];
long long nx[N];

Node merge(Node a, Node b) {
    if (a.k == inf && a.b == inf) return b;
    Node res;
    res.k = a.k % mod * (b.k % mod) % mod;
    res.b = a.b % mod * (b.k % mod) % mod + b.b;
    res.k %= mod;
    res.b %= mod;
    return res;
}

void init() {
    for (long long i = 0; i <= M; i ++) {
        for (long long j = 1; j <= n; j ++) {
            if (i == 0) {
                dp[i][j] = a[nx[j]];
                fa[i][j] = nx[j];
            }
            else {
                dp[i][j] = merge(
                    dp[i - 1][j], 
                    dp[i - 1][fa[i - 1][j]]
                );
                fa[i][j] = fa[i - 1][fa[i - 1][j]];
            }
        }
    }
}

void clear() {
    for (long long i = 0; i <= M; i ++) {
        for (long long j = 1; j <= n; j ++) {
            dp[i][j] = {0, 0};
            fa[i][j] = 0;
        }
    }
}

// long long lowbit(long long x) { return -x & x; }
// long long get_log(long long x) {
//     long long res = 0;
//     while ((x & 1) == 0) res ++, (x >>= 1);
//     return res;
// }

Node calc(long long start, long long step) {
    Node res = {inf, inf};
    long long t = 0;
    long long cur = 1;
    while (step >= cur) {
        if (step & cur) {
            res = merge(res, dp[t][start]);
            start = fa[t][start];
        }
        cur <<= 1; t ++;
    }
    return res;
}

void solve() {
    std::cin >> n >> m;
    for (long long i = 1; i <= n; i ++)
        std::cin >> a[i].k;
    for (long long i = 1; i <= n; i ++)
        std::cin >> a[i].b;
    for (long long i = 1; i <= n; i ++)
        std::cin >> nx[i];
    init();
    while (m --) {
        long long x, l, y; std::cin >> x >> l >> y;
        auto nd = calc(x, l);
        long long res = (y % mod * (nd.k % mod) % mod + nd.b % mod) % mod;
        std::cout << res << '\n';
    }
    clear();
}

int main() {
    std::ios::sync_with_stdio(0);
    std::cin.tie(0); std::cout.tie(0);
    long long t; std::cin >> t; while (t --)
    solve();
    return 0;
}
```
