# [二分+hash+lcp](https://www.matiji.net/exam/brushquestion/7/4347/179CE77A7B772D15A8C00DD8198AAC74)

```c++
#include <bits/stdc++.h>

const long long N = 1e6 +  100;
const long long mod = 1e9 + 7, rr = 233;
long long n, m;
char s[N];
long long hs[N], pr[N];
long long a[N], pre[N], post[N];
long long big[N];

inline void init() {
    pr[0] = 1;
    for (long long i = 1; i <= n; i ++) {
        hs[i] = (hs[i - 1] * rr % mod + s[i]) % mod;
        pr[i] = pr[i - 1] * rr % mod;
    }
}

inline long long get(long long l, long long r) {
    return ((hs[r] - hs[l - 1] * pr[(r - l + 1)] % mod) % mod + mod) % mod;
}

long long lcp(long long x, long long y, long long n) {
    long long l = 1, r = n, mid;
    while (l < r) {
        mid = (l + r + 1) >> 1;
        if (get(x, x + mid - 1) == get(y, y + mid - 1)) l = mid;
        else r = mid - 1;
    }
    if (get(x, x + l - 1) == get(y, y + l - 1)) return l;
    return 0;
}

void solve() {
    scanf ("%lld%lld%s", &n, &m, s + 1);
    init();
    for (long long i = 1; i <= n; i ++) a[i] = s[i] - '0';
    for (long long i = 1; i <= n; i ++) pre[i] = pre[i - 1] + a[i];
    for (long long i = 1; i <= n; i ++) post[i] = post[i - 1] + a[n - i + 1];
    long long mx = 1;
    for (long long i = 1; i + n - m - 1 <= n; i ++) {
        long long p = lcp(mx, i, n - m);
        if (p == n - m) continue;
        // std::cout << mx << ' ' << p << ' ' << s[mx + p] << ' ' << s[i + p] << '\n';
        if (s[mx + p] < s[i + p]) mx = i;
    }
    // std::cout << mx << '\n';
    long long sum = pre[mx - 1] + post[m - mx + 1];
    for (long long i = mx + n - m - 1, j = 1; i >= mx; i --, j ++) {
        big[j] = a[i];
    } 
    long long len = n - m;
    for (long long i = 1, t = sum; t != 0; i ++) {
        big[i] += t;
        t = big[i] / 10;
        big[i] %= 10;
        len = std::max(i, len);
    }
    for (long long i = len; i; i --) printf ("%d", big[i]);
    puts("");
}

int main() {
    solve();
    return 0;
}
```