# [bellman-ford 求最多经过 k 条边的最短路径](https://www.acwing.com/problem/content/855/)

```c++
#include <bits/stdc++.h>


const long long N = 1e3;
const long long M = 2e4 + 1000;
const long long inf = 1e9;
long long n, m, k;
long long g[M], e[M], ne[M], w[M], ant;

long long dp[N][N]; // 到达起点的最短路径长度 

void add(long long x, long long y, long long z)
{
	ant ++;
	e[ant] = y;
	w[ant] = z;
	ne[ant] = g[x];
	g[x] = ant;
}  

void solve()
{
	std::cin >> n >> m >> k;
	for (long long i = 1; i <= m; i ++)
	{
		long long x, y, z;
		std::cin >> x >> y >> z;
		add(x, y, z);
	}
	
	for (long long i = 0; i < N; i ++)
	{
		for (long long j = 0; j < N; j ++)
			dp[i][j] = inf;
	}
	
	dp[1][0] = 0;
		
	for (long long i = 1; i <= k; i ++)
	{
		for (long long j = 1; j <= n; j ++)
		{
			for (long long l = g[j]; l; l = ne[l])
			{
				long long u = j, v = e[l], t = w[l];
				if (dp[u][i - 1] != inf) dp[v][i] = std::min(dp[v][i], dp[u][i - 1] + t);
				dp[v][i] = std::min(dp[v][i], dp[v][i - 1]);
			}
		}
	}
	
	if (dp[n][k] == inf) std::cout << "impossible" << '\n';
	else std::cout << dp[n][k] << '\n';
}

int main()
{
	std::ios::sync_with_stdio(0);
	std::cin.tie(0); std::cout.tie(0);
	
	solve();
	
	return 0;
}
```