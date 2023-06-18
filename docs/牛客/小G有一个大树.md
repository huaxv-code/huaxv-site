# [小G有一个大树](https://ac.nowcoder.com/acm/contest/25022/1001?&headNav=acm)

=== "动态规划、树的重心"

    结点数最大的子树最小，那么当前父节点就是重心

    ```c++
    #include <bits/stdc++.h>

    typedef long long ll;
    using namespace std;
    #define endl '\n'
    const ll N = 2000000;
    const ll inf = 1 << 30;

    ll n;
    vector<vector<ll>> g;
    ll sz[N];
    ll mx = inf, p;

    void add(ll a, ll b)
    {
        g[a].push_back(b);
    }

    void dfs(ll u, ll f)
    {
        sz[u] ++;
        ll t = 0;
        for (ll v : g[u])
        {
            if (v == f) continue;
            dfs(v, u);
            sz[u] += sz[v];
            t = max(t, sz[v]);
        }
        t = max(t, n - sz[u]);
        if (t < mx)
        {
            mx = t; p = u;
        }
    }

    void solve()
    {
        
        cin >> n;
        
        g = vector<vector<ll>>(n + 1);
        
        for (ll i = 1; i < n; i ++)
        {
            ll x, y; cin >> x >> y;
            add(x, y); add(y, x);
        }
        
        dfs(1, 0);
        
        cout << p << " " << mx << endl;
        
    }

    int main()
    {
        ios::sync_with_stdio(0);
        cin.tie(0); cout.tie(0);
        
        solve();
        return 0;
    }
    ```