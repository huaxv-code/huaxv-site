# [FHQ 封装]()

```c++
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
```
