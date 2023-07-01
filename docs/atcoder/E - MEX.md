# [E - MEX](https://atcoder.jp/contests/abc308/tasks/abc308_e)

=== "动态规划"

    从左边往右边扫描，如果多一个 $M$ 应该如何处理？

    如果多一个 $E$ 又应该如何处理？

    如果多一个 $X$ 又应该如何处理？

    总共的状态数可以暴力一一枚举出来

    ```c++
    #include <bits/stdc++.h>


    const long long N = 2e5 + 10;

    long long n;
    long long a[N];
    std::string s;
    long long M[3];
    long long E[3][3];
    long long X[3][3][3];
    long long res;

    long long get_val(long long a_, long long b_, long long c_)
    {
        for (long long i = 0;; i ++)
        {
            if (i != a_ && i != b_ && i != c_) return i;
        }
        return -1;
    }

    void solve()
    {
        
        std::cin >> n;
        
        for (long long i = 1; i <= n; i ++)
            std::cin >> a[i];
        std::cin >> s; s = '?' + s;
        
        for (long long i = 1; i <= n; i ++)
        {
            if (s[i] == 'M')
            {
                M[a[i]] ++;
            }
            
            if (s[i] == 'E')
            {
                long long x = a[i];
                for (long long y = 0; y < 3; y ++)
                {
                    E[x][y] += M[y];
                }
            }
            
            if (s[i] == 'X')
            {
                long long x = a[i];
                for (long long y = 0; y < 3; y ++)
                {
                    for (long long z = 0; z < 3; z ++)
                    {
                        X[x][y][z] += E[y][z];
                    }
                }
            }
        }
        
        for (long long i = 0; i < 3; i ++)
        {
            for (long long j = 0; j < 3; j ++)
            {
                for (long long k = 0; k < 3; k ++)
                {
                    res += get_val(i, j, k) * X[i][j][k];
                }
            }
        }
        
        std::cout << res << '\n';
        
    }

    int main()
    {
        std::ios::sync_with_stdio(0);
        std::cin.tie(0); std::cout.tie(0);
        
        
        solve();
        return 0;
    }

    ```
