# [区间 dp-序列删除](http://oj.daimayuan.top/course/5/problem/202)

给定一个长度为 $n$ 的序列 $a[n]$，你需要删除 $a_2, a_3, \cdots, a_{n - 1}$ 使得序列最后只剩下 $a_1, a_n$

删除一个元素的代价等于该元素乘以此时与他相邻的左右元素的乘积

问最小代价是多少

---

对于区间 $[l, r]$ 如果最后删除时只剩下 $l, r$ 两个元素，问最小代价是多少？

如果最终只能剩下 $l,r$ 两个元素，那么最后面必定有一步是只剩下 $3$ 个元素 $l, k, r$，那么此时的代价为：

$dp[l, k] + dp[k, r] + k * l * r$

```c++
#include <bits/stdc++.h>

const long long N = 1e3;
const long long inf = 1e9;
long long n;
long long a[N];
long long dp[N][N];

void solve() {
    std::cin >> n;
    for (long long i = 1; i <= n; i ++) {
        std::cin >> a[i];
    }
    for (long long i = 3; i <= n; i ++) {
        long long st = 1, ed = st + i - 1;
        for (; ed <= n; st ++, ed = st + i - 1) {
            for (long long j = st + 1; j < ed; j ++) {
                long long t = dp[st][j] + dp[j][ed] + a[j] * a[st] * a[ed];
                if (dp[st][ed]) dp[st][ed] = std::min(dp[st][ed], t);
                else dp[st][ed] = t;
            }
        }
    }
    std::cout << dp[1][n] << '\n';
}

int main() {
    std::ios::sync_with_stdio(0);
    std::cin.tie(0);
    std::cout.tie(0);
    
    solve();
    return 0;
}
```