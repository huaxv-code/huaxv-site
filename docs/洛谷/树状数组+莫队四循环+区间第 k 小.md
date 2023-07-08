# [树状数组+莫队四循环+区间第 k 小](https://www.luogu.com.cn/problem/P3834)

=== "树状数组 + 莫队四循环 + 区间第 k 小"

    时间复杂度：$n\sqrt{n}\log(n)$

    对询问的区间进行排序，从一个查询区间跃迁到另外一个查询区间，利用莫队四循环的写法跃迁，每跃迁一次的时间复杂度最大平均很有可能达到 $\sqrt{n}$.

    用二分枚举前缀和查找第 $k$ 小，前缀和如何求？用树状数组，每求一次耗时 $\log(n)$，二分可能要枚举 $\log(n)$ 次，所以每查询一次的时间复杂度：$\log^2(n)$

    $10 ^ 5$ 次方级别的数据量需要 $16$ 秒才能求出，严重超时！

    ```c++
    #include <bits/stdc++.h>


    const long long N = 2e5 + 100;
    long long n, m;
    long long a[N];
    long long sr[N], len;
    long long c[N];

    const long long inf = ~(1 << 31);

    struct Query
    {
        long long l, r, k, id;
        bool operator<(const Query& Q) const
        {
            if (l == Q.l && r == Q.r && k == Q.k && id == Q.id) return false;
            if (l == Q.l && r == Q.r && k == Q.k) return id < Q.id; 
            if (l == Q.l) return r < Q.r;
            return l < Q.l;
        }
    };

    Query Q[N];
    long long K[N];

    long long lowbit(long long x)
    {
        return x & -x;
    }

    long long find(long long x)
    {
        long long l = 1, r = len, mid;
        while (l < r)
        {
            mid = (l + r) >> 1;
            if (sr[mid] < x) l = mid + 1;
            else r = mid;
        }
        return r;
    }

    void add(long long id, long long x)
    {
        while (id <= len)
        {
            c[id] += x;
            id += lowbit(id);
        }
    }

    long long sum(long long id)
    {
        long long res = 0;
        while (id > 0)
        {
            res += c[id];
            id -= lowbit(id);
        }
        return res;
    }

    void jump(long long l, long long r, long long l_, long long r_)
    {
        while (l < l_) add(find(a[l ++]), -1);
        while (l_ < l) add(find(a[l_ ++]), 1);
        while (r < r_) add(find(a[++ r]), 1);
        while (r_ < r) add(find(a[++ r_]), -1);
    }

    long long query(long long l, long long r, long long kth)
    {
        if (l == r) return l;
        long long mid = (l + r) >> 1;
        
        long long t = sum(mid) - sum(l - 1);
        if (t < kth) return query(mid + 1, r, kth - t);
        else return query(l, mid, kth);
    }

    void solve()
    {
        
        scanf ("%lld%lld", &n, &m);
        for (long long i = 1; i <= n; i ++)
        {
            scanf ("%lld", &a[i]);
            sr[++ len] = a[i];
        }
        
        std::sort(sr + 1, sr + 1 + n);
        len = std::unique(sr + 1, sr + 1 + n) - sr - 1;
        
        for (long long i = 1; i <= m; i ++)
        {
            long long l, r, k; 
            scanf ("%lld%lld%lld", &l, &r, &k);
            Q[i] = Query{l, r, k, i};
        }
        
        std::sort(Q + 1, Q + 1 + m);
        
        for (long long i = Q[1].l; i <= Q[1].r; i ++)
        {
            add(find(a[i]), 1);
        }
        
        K[Q[1].id] = sr[query(1, len, Q[1].k)];
        
        for (long long i = 2; i <= m; i ++)
        {
            jump(Q[i - 1].l, Q[i - 1].r, Q[i].l, Q[i].r);
            long long id = Q[i].id;
            K[id] = sr[query(1, len, Q[i].k)];
        }
        
        for (long long i = 1; i <= m; i ++)
        {
            printf ("%lld\n", K[i]);
        }
        
    }

    int main()
    {   
        
        
        solve();
        return 0;
    }

    ```
