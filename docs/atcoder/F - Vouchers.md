# [F - Vouchers](https://atcoder.jp/contests/abc308/tasks/abc308_f)

=== "线段树"

    如果价格比较低的物品，相对大的物品可选择的优惠卷就会少很多；

    所以从小的物品开始选择，对于小物品来说，可能会有很多张优惠卷可以选择，我只需要选择最大的那一张就行

    对于所有物品，上述思路仍然行得通。

    线段树时间复杂度：$nlog(n)$

    ```c++
    #include <bits/stdc++.h>

    const long long N = 2e5 + 10;
    long long n, m;
    long long a[N];

    struct Node
    {
        long l, d;
        bool operator<(const Node& nd) const 
        {
            return l < nd.l;
        }
    };

    Node b[N];

    long long find(long long price)
    {
        long long l = 1, r = m, mid;
        while (l < r)
        {
            mid = (l + r + 1) >> 1;
            if (b[mid].l <= price) l = mid;
            else r = mid - 1;
        }
        if (b[l].l <= price) return l;
        return -1;
    }

    struct Elem
    {
        long long val, pos;
    };

    Elem tr[N << 2];

    long long ls(long long p) { return p << 1; }
    long long rs(long long p) { return p << 1 | 1; }

    void push_up(long long p, long long pl, long long pr)
    {
        if (pl == pr) return;
        if (tr[ls(p)].val >= tr[rs(p)].val)
        {
            tr[p].val = tr[ls(p)].val;
            tr[p].pos = tr[ls(p)].pos;
        }
        else
        {
            tr[p].val = tr[rs(p)].val;
            tr[p].pos = tr[rs(p)].pos;
        }
    }

    void build(long long p, long long pl, long long pr)
    {
        if (pl == pr)
        {
            tr[p].val = b[pl].d;
            tr[p].pos = pl;
            return;
        }
        
        long long mid = (pl + pr) >> 1;
        
        build(ls(p), pl, mid);
        build(rs(p), mid + 1, pr);
        
        push_up(p, pl, pr);
    }

    Elem query(long long p, long long pl, long long pr, long long l, long r)
    {
        if (l <= pl && pr <= r)
            return tr[p];
        long long mid = (pl + pr) >> 1;
        
        Elem t1 = {0, 0}, t2 = {0, 0};
        
        if (mid >= l) t1 = query(ls(p), pl, mid, l, r);
        if (r > mid) t2 = query(rs(p), mid + 1, pr, l, r);
        
        if (t1.val > t2.val) return t1;
        else if (t1.val < t2.val) return t2;
        else return Elem{0, std::max(t1.pos, t2.pos)};
    }

    void del(long long p, long long pl, long long pr, long long pos)
    {
        if (pos <= pl && pr <= pos)
        {
            tr[p].val = 0;
            return;
        }
        
        long long mid = (pl + pr) >> 1;
        
        if (pos <= mid) del(ls(p), pl, mid, pos);
        else del(rs(p), mid + 1, pr, pos);
        
        push_up(p, pl, pr);
    }

    long long ans;

    void solve()
    {
        
        std::cin >> n >> m;
        for (long long i = 1; i <= n; i ++)
            std::cin >> a[i];
            
        for (long long i = 1; i <= m; i ++)
            std::cin >> b[i].l;
        for (long long i = 1; i <= m; i ++)
            std::cin >> b[i].d;
            
        std::sort(b + 1, b + 1 + m);
        std::sort(a + 1, a + 1 + n);
        
        for (long long i = 1; i <= n; i ++)
            ans += a[i];
        
        build(1, 1, m);
            
        for (long long i = 1; i <= n; i ++)
        {

            long long pos = find(a[i]);
            
            if (pos == -1) continue;
    
            Elem e = query(1, 1, m, 1, pos);
            ans -= e.val; 
            
            del(1, 1, m, e.pos);
            
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
