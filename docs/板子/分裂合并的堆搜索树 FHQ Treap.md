# [分裂合并的堆搜索树 FHQ Treap]()

所有操作都基于分裂合并！

```c++
#include <bits/stdc++.h>


const long long N = 2e6;
long long n;
long long V[N], K[N], S[N], ls[N], rs[N], ant;
long long root;

void set_size(long long u)
{
    if (u == 0) return;
    S[u] = 1 + S[ls[u]] + S[rs[u]];
}

void split(long long u, long long x, long long& l, long long& r)
{
    if (u == 0)
    {
        l = r = 0; return;
    }
    
    if (V[u] < x)
    {
        l = u;
        split(rs[u], x, rs[u], r);
    }
    else
    {
        r = u;
        split(ls[u], x, l, ls[u]);
    }
    
    set_size(l);
    set_size(r);
}

void meld(long long& u, long long l, long long r)
{
    if (l == 0 || r == 0) 
    {
        u = l + r; 
        set_size(u);
        return;
    }
    
    if (K[l] > K[r])
    {
        u = l;
        meld(rs[u], rs[u], r);
    }
    else 
    {
        u = r;
        meld(ls[u], l, ls[u]);
    }
    
    set_size(u);
}

void insert(long long& u, long long x)
{
    long long l, r;
    split(u, x, l, r);
    long long t = ++ ant;
    V[t] = x;
    K[t] = rand();
    meld(u, l, t);
    meld(u, u, r);
}

void erase(long long& u, long long x)
{
    long long l, r;
    split(u, x, l, r);
    long long l_, r_;
    split(r, x + 1, l_, r_);
    meld(u, l, ls[l_]);
    meld(u, u, rs[l_]);
    meld(u, u, r_);
}

// 如果要插入当前元素，那么能排在第几位？
long long id(long long& u, long long x)
{
    long long l, r;
    split(u, x, l, r);
    long long res = S[l] + 1;
    meld(u, l, r);
    return res;
}

long long kth(long long u, long long k)
{
    long long t = S[ls[u]] + 1;
    if (t == k) return V[u];
    else if (k > t) return kth(rs[u], k - t);
    else return kth(ls[u], k);
}

// 前驱
long long pre(long long& u, long long x)
{
    return kth(u, id(u, x) - 1);
}

// 后继
long long post(long long& u, long long x)
{
    long long t = id(u, x + 1) - 1;
    return kth(u, t + 1);
}

void dfs(long long u)
{
    if (u == 0) return;
    dfs(ls[u]);
    printf ("val = %lld, size = %lld, l = %lld, r = %lld\n", 
        V[u], S[u], ls[u], rs[u]
    );
    dfs(rs[u]);
}

void solve()
{
    
    scanf ("%lld", &n);
    while (n --)
    {
        long long opt, x;
        scanf ("%lld%lld", &opt, &x);
        if (opt == 1) insert(root, x);
        if (opt == 2) erase(root, x);
        if (opt == 3) printf ("%lld\n", id(root, x));
        if (opt == 4) printf ("%lld\n", kth(root, x));
        if (opt == 5) printf ("%lld\n", pre(root, x));
        if (opt == 6) printf ("%lld\n", post(root, x));
    }
    
    // dfs(root);
    
}

int main()
{
    
    
    solve();
    return 0;
}

```
