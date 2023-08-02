# [RGB 对对碰](https://acm.hdu.edu.cn/showproblem.php?pid=7329)

如果指针 $i$ 从左往右遍历，当前状态的影响只会受到前面状态的影响

对于当前节点，只需要获取选与不选两种状态跃迁的最大值就行

```c++
#include <bits/stdc++.h>

const long long N = 2e5;
long long dp_ex[N][40];
long long dp_val[N][40];
long long n;
std::vector<long long> tys[3];
std::string s;
long long a[N];

void solve()
{
    std::cin >> s;
    // std::cin >> n;
    n = s.size();
    for (long long i = 1; i <= n; i ++)
    {
        if (s[i - 1] == 'R') a[i] = 1;
        else if (s[i - 1] == 'G') a[i] = 2;
        else if (s[i - 1] == 'B') a[i] = 3;
    }
    for (long long i = 0; i <= n; i ++)
    {
        for (long long j = 0; j < 40; j ++)
        {
            dp_ex[i][j] = dp_val[i][j] = 0;
        }
    }
    dp_ex[0][0] = 1;
    for (long long i = 1; i <= n; i ++)
    {
        for (long long j = 0; j <= 2; j ++)
        {
            for (long long k : tys[j])
            {
                dp_ex[i][k] = dp_ex[i - 1][k];
                dp_val[i][k] = dp_val[i - 1][k];
            }
        }
        for (long long j = 0; j <= 2; j ++)
        {
            for (long long k : tys[j])
            {
                if (dp_ex[i - 1][k] == 0) continue;
                if (j == 0)
                {
                    long long t = a[i] * 10;
                    dp_ex[i][t] = 1;
                    dp_val[i][t] = std::max(dp_val[i][t], dp_val[i - 1][k]);
                    continue;
                }
                if (j == 1)
                {
                    long long t = k + a[i];
                    dp_ex[i][t] = 1;
                    dp_val[i][t] = std::max(dp_val[i][t], dp_val[i - 1][k]);
                    continue;
                }
                if (j == 2)
                {
                    long long t = k * 10 + a[i]; t %= 10;
                    long long x = k / 10 % 10, y = k % 10;
                    long long z = a[i];
                    if (x != y && x != z && y != z)
                    {
                        for (long long cur : tys[2])
                        {
                            dp_ex[i][cur] = 1;
                            dp_val[i][cur] = std::max(
                                dp_val[i][cur],
                                dp_val[i - 1][k]
                            );
                        }
                        continue;
                    }
                    else if (x != y)
                    {
                        dp_ex[i][t] = 1;
                        dp_val[i][t] = std::max(
                            dp_val[i][t], dp_val[i - 1][k]
                        );
                        continue;
                    }
                    if (x == y && y == z)
                    {
                        for (long long cur : tys[1])
                        {
                            dp_ex[i][cur] = 1;
                            dp_val[i][cur] = std::max(
                                dp_val[i][cur],
                                dp_val[i - 1][k] + 1
                            );
                        }
                        continue;
                    }
                    else 
                    {
                        dp_ex[i][t] = 1;
                        dp_val[i][t] = std::max(
                            dp_val[i][t], dp_val[i - 1][k]
                        );
                        continue;
                    }
                    
                }
            }
        }
    }
    long long res = 0;
    for (long long i = 0; i < 40; i ++)
    {
        if (dp_val[n][i] > res) res = dp_val[n][i];
    }
    std::cout << res << '\n';
}

int main()
{
    std::ios::sync_with_stdio(0);
    std::cin.tie(0); std::cout.tie(0);
    tys[0].push_back(0);
    for (long long i = 1; i <= 3; i ++)
    {
        long long t = i * 10;
        for (long long j = 0; j <= 3; j ++)
        {
            if (j == 0) tys[1].push_back(t);
            else tys[2].push_back(t + j);
        }
    }
    long long t; std::cin >> t; while (t --)
    solve();
    return 0;
}
```
