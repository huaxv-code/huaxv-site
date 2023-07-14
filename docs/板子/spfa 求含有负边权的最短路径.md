# [spfa 求含有负边权的最短路径](https://www.acwing.com/problem/content/853/)

如果某个点的最短路径有更新，就丢入队列。

```c++
#include <bits/stdc++.h>


const long long N = 2e5 + 1000;
const long long inf = 1e9;
long long n, m;
long long g[N], e[N], ne[N], w[N], ant;

void add(long long x, long long y, long long z)
{
	ant ++;
	e[ant] = y;
	w[ant] = z;
	ne[ant] = g[x];
	g[x] = ant;
}

std::queue<long long> qu;
long long d[N];
long long s[N];
long long on[N];

void solve()
{
	std::cin >> n >> m;
	for (long long i = 1; i <= m; i ++)
	{
		long long x, y, z; 
		std::cin >> x >> y >> z;
		add(x, y, z);
	}
	
	for (long long i = 0; i < N; i ++)
		d[i] = inf;
		
	d[1] = 0;
	qu.push(1);
	on[1] = 1;
	
	while (qu.size())
	{
		long long u = qu.front(); qu.pop();
		on[u] = 0;
		
		for (long long i = g[u]; i; i = ne[i])
		{
			long long v = e[i];
			if (d[v] > d[u] + w[i])
			{
				d[v] = d[u] + w[i];
				s[v] = s[u] + 1; // 对于没有负环的图，最短路径长度是一定不会超过 n 的 
				if (on[v]) continue;
				on[v] = 1;
				qu.push(v);
			}
		}
	}
	
	if (d[n] == inf) std::cout << "impossible" << '\n';
	else std::cout << d[n] << '\n';
	
	
}

int main()
{
	std::ios::sync_with_stdio(0);
	std::cin.tie(0); std::cout.tie(0);
	
	solve();
	
	return 0;
}
```