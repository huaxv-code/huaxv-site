# [双指针或者称尺取法 解决两数之和不超过 k 的个数](https://www.luogu.com.cn/problem/U319460)

用类似归并排序找逆序对的合并方式

令 $i = 1, j = m$

如果 $a[i] + b[j] > k$ 说明 $b[j]$ 太大了，$j$ 要左移

如果此时 $a[i] + b[j] <= k$ 那么 $b[1 \sim j]$ 的所有数加上 $a[i]$ 都只会小于或者等于 $k$

此时 $i$ 要向右移动，如果 $i$ 向右移动，要查找此时 $i$ 的结果，那么区间肯定坐落于比 $j$ 还要小的地方

```c++
#include <bits/stdc++.h>

const long long N = 2e6;
long long n, m, k;
long long a[N], b[N];
long long ans;

void solve()
{
    std::cin >> n >> m >> k;
    for (long long i = 1; i <= n; i ++) std::cin >> a[i];
    for (long long i = 1; i <= m; i ++) std::cin >> b[i];
    std::sort(a + 1, a + 1 + n);
    std::sort(b + 1, b + 1 + m);
    long long i = 1, j = m;
    while (i <= n && j >= 1)
    {
        long long t = a[i] + b[j];
        if (t > k) j --;
        else
        {
            ans += j; i ++;
        }
    }
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
