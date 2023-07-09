# [vector 实现搜索树](https://www.luogu.com.cn/problem/P3369)


```c++
#include <bits/stdc++.h>

std::vector<long long> v;
long long n;

void solve()
{
    
    std::cin >> n;
    while (n --)
    {
        long long opt, x; std::cin >> opt >> x;
        if (opt == 1) v.insert(std::lower_bound(v.begin(), v.end(), x), x);
        if (opt == 2) v.erase(std::lower_bound(v.begin(), v.end(), x));
        if (opt == 3) std::cout << std::lower_bound(v.begin(), v.end(), x) - v.begin() + 1 << '\n';
        if (opt == 4) std::cout << v[x - 1] << '\n';
        if (opt == 5) std::cout << v[std::lower_bound(v.begin(), v.end(), x) - v.begin() - 1] << '\n';
        if (opt == 6) std::cout << v[std::upper_bound(v.begin(), v.end(), x) - v.begin()] << '\n';
    }
    
}

int main()
{
    
    
    solve();
    return 0;
}

```
