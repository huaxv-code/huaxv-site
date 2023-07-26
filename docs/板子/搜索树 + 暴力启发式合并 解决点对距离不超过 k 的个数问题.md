# [搜索树 + 暴力启发式合并 解决点对距离不超过 k 的个数问题]()

```c++
#include <iostream>
#include <vector>
#include <ctime>

const long long N = 5e4;
long long n, m;
long long g[N], e[N], ne[N], w[N], ant;
long long hson[N], hsonw[N], size[N];
long long ans;
long long out = 1;
class FHQ
{
private:

    const long long _size_;
    std::vector<long long> val, key;
    std::vector<long long> ls, rs;
    std::vector<long long> size;
    std::vector<long long> space;
    
    long long ant;
    long long root;
    
public:  

    FHQ(long long N = 2e6) : _size_(N), 
    val(_size_, 0), key(_size_, 0), 
    ls(_size_, 0), rs(_size_, 0), 
    size(_size_, 0), 
    space(_size_, 0), 
    ant(0), root(0)
    {
        srand(time(0));
        
        for (long long i = 1; i < _size_ - 10; i ++)
        {
            space[++ ant] = i;
        }
    }
    
private:

    long long get()
    {
        return space[ant --];
    }
    
    void del(long long pos)
    {
        val[pos] = 0; key[pos] = 0;
        ls[pos] = 0; rs[pos] = 0;
        size[pos] = 0;
        space[++ ant] = pos;
    }
    
    void push_up(long long rt)
    {
        if (rt == 0) return;
        size[rt] = 1 + size[ls[rt]] + size[rs[rt]];
    }
    
    void split(long long rt, long long x, long long& l, long long& r)
    {
        if (rt == 0) { l = r = 0; return; }
        if (val[rt] < x)
        {
            l = rt;
            split(rs[rt], x, rs[rt], r);
        }
        else
        {
            r = rt;
            split(ls[rt], x, l, ls[rt]);
        }
        push_up(l);
        push_up(r);
    }
    
    void meld(long long& rt, long long l, long long r)
    {
        if (l == 0 || r == 0)
        {
            rt = l + r;
            push_up(rt);
            return;
        }
        
        if (key[l] >= key[r])
        {
            rt = l;
            meld(rs[rt], rs[rt], r);
        }
        else 
        {
            rt = r;
            meld(ls[rt], l, ls[rt]);
        }
        
        push_up(rt);
    }
    
    // 查找第 k 大
    long long kth(long long root, long long k)
    {
        long long t = size[ls[root]] + 1;
        if (k == t) return val[root];
        else if (k > t) return kth(rs[root], k - t);
        else return kth(ls[root], k);
    }

    void clear(long long root)
    {
        if (root == 0) return;
        clear(ls[root]);
        clear(rs[root]);
        del(root);
    }

public:

    // 插入元素 x
    void insert(long long x)
    {
        long long l, r;
        split(root, x, l, r);
        long long p = get();
        val[p] = x;
        key[p] = rand();
        size[p] = 1;
        meld(root, l, p);
        meld(root, root, r);
    }
    
    // 删除一个元素 x
    void erase(long long x)
    {
        long long l, r;
        split(root, x, l, r);
        long long p, q;
        split(r, x + 1, p, q);
        if (p)
        {
            long long l = ls[p], r = rs[p];
            del(p);
            meld(p, l, r);
        }
        meld(root, l, p);
        meld(root, root, q);
    }

    // 元素个数
    long long length()
    {
        return size[root];
    }
    
    // 比 x 小的元素个数
    long long nleft(long long x)
    {
        long long l, r;
        split(root, x, l, r);
        long long res = size[l];
        meld(root, l, r);
        return res;
    }
    
    // 比 x 小或等的元素个数
    long long nleq(long long x)
    {
        return nleft(x + 1);
    }
    
    // 比 x 大的元素个数
    long long nright(long long x)
    {
        return length() - nleq(x);
    }
    
    // 比 x 大或等的元素个数
    long long nreq(long long x)
    {
        return length() - nleft(x);
    }
    
    // 查找第 k 大
    long long knum(long long k)
    {
        if (k > length()) exit(1);
        return kth(root, k);
    }
    
    // 删除第 k 大
    void dknum(long long k)
    {
        if (k > length()) exit(1);
        erase(knum(k));
    }
    
    void clear()
    {
        clear(root);
        root = 0;
    }
    
    // 查找左边第一个比 x 小的数
    long long pre(long long x)
    {
        if (nleft(x) == 0) exit(1);
        return knum(nleft(x));
    }
    
    // 查找右边第一个比 x 大的数
    long long nxt(long long x)
    {
        if (nleq(x) == length()) exit(1);
        return knum(nleq(x) + 1);
    }
    
    // 统计 l <= x <= r 的元素个数
    long long count(long long l, long long r)
    {
        long long x, y, z;
        split(root, l, x, y);
        split(y, r + 1, y, z);
        long long t = size[y];
        meld(root, x, y);
        meld(root, root, z);
        return t;
    }
    
    // 删除 l <= x <= r 的区间
    void del(long long l, long long r)
    {
        long long x, y, z;
        split(root, l, x, y);
        split(y, r + 1, y, z);
        clear(y);
        meld(root, x, z);
    }
    
    // 删除 <= x 的一段
    void del_pre(long long x)
    {
        long long l, r;
        split(root, x + 1, l, r);
        clear(l);
        l = 0;
        meld(root, l, r);
    }
    
    // 删除 >= x 的一段
    void del_post(long long x)
    {
        long long l, r;
        split(root, x, l, r);
        clear(r);
        r = 0;
        meld(root, l, r);
    }
};

FHQ set(N);
long long sum;

void add(long long x, long long y, long long z)
{
    ant ++;
    e[ant] = y;
    w[ant] = z;
    ne[ant] = g[x];
    g[x] = ant;
}

void dfs_1(long long u, long long v)
{
    size[u] = 1;
    for (long long i = g[u]; i; i = ne[i])
    {
        if (e[i] == v) continue;
        dfs_1(e[i], u);
        size[u] += size[e[i]];
        if (hson[u] == 0 || size[hson[u]] < size[e[i]])
        {
            hson[u] = e[i];
            hsonw[u] = w[i];
        }
    }
}

void find_ans(long long u, long long v, long long s)
{
    if (s > m) return;
    long long t = set.nleq(m - s - sum);
    ans += t + 1;
    for (long long i = g[u]; i; i = ne[i])
    {
        if (e[i] == v) continue;
        find_ans(e[i], u, s + w[i]);
    }
}

void add_path(long long u, long long v, long long s)
{
    if (s > m) return; 
    long long x = s - sum;
    set.insert(x);
    for (long long i = g[u]; i; i = ne[i])
    {
        if (e[i] == v) continue;
        add_path(e[i], u, s + w[i]);
    }
}

void dfs_2(long long u, long long v, long long keep)
{
    for (long long i = g[u]; i; i = ne[i])
    {
        if (e[i] == v || e[i] == hson[u]) continue;
        dfs_2(e[i], u, 0);
    }
    
    if (hson[u])
    {
        dfs_2(hson[u], u, 1);
        sum += hsonw[u];
        set.insert(hsonw[u] - sum);
        set.del_post(m - sum + 1);
        ans += set.length();
    }
    
    for (long long i = g[u]; i; i = ne[i])
    {
        if (e[i] == v) continue;
        if (e[i] == hson[u]) continue;
        find_ans(e[i], u, w[i]);
        add_path(e[i], u, w[i]);
    }
    
    if (keep == 0)
    {
        set.clear();
        sum = 0;
    }
}

void solve()
{
    std::cin >> n >> m;
    
    // if (n > 5000) exit(0);
    
    if (n == 0 && m == 0) {out = 0; return;}
    for (long long i = 1; i < n; i ++)
    {
        long long x, y, z; std::cin >> x >> y >> z;
        add(x, y, z); add(y, x, z);
    }
    
    dfs_1(1, 0);
    dfs_2(1, 0, 1);
    
    std::cout << ans << '\n';
}

int main()
{
    std::ios::sync_with_stdio(0);
    std::cin.tie(0); std::cout.tie(0);
    
    while (out) solve();
    return 0;
}
```
