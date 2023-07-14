# [dijkstra 求正权值最短路径](https://www.acwing.com/problem/content/852/)

从某点开始向周围辐射，每次选取队列中最近的节点，如果该节点到起点的路径长度有更新，那么继续从该点开始向周围辐射。

其实每次从队列中选取的最近的点，必定是从该点到达起点的最短路径的点。

```c++
#include <bits/stdc++.h>


const long long N = 2e6;
const long long inf = 2e9;
long long n, m;
long long g[N], e[N], ne[N], w[N], ant;
long long d[N];

void add(long long x, long long y, long long z)
{
	ant ++;
	e[ant] = y;
	w[ant] = z;
	ne[ant] = g[x];
	g[x] = ant;
}

struct cmp
{// 优先级小的就是 true 
	bool operator()(const std::vector<long long>& x, const std::vector<long long>& y)
	{
		if (x[1] != y[1]) return x[1] > y[1];
		return x[0] > y[0];
	}
};

std::priority_queue<std::vector<long long>, std::vector<std::vector<long long>>, cmp> qu;


void solve()
{
	std::cin >> n >> m;
	
	for (long long i = 1; i <= m; i ++)
	{
		long long x, y, z;
		std::cin >> x >> y >> z;
		add(x, y, z);
	}
	
	for (long long i = 0; i < N; i ++) d[i] = inf;
	
	qu.push({1, 0});
	
	while (qu.size())
	{
		
		auto nd = qu.top(); qu.pop();
		long long u = nd[0];
		long long t = nd[1];
		
		if (d[u] > t)
		{ // 我的这种写法，其实是 spfa 用优先队列的形式
			d[u] = t;
			for (long long i = g[u]; i; i = ne[i])
			{
				qu.push({e[i], t + w[i]});
			}
		}
	}
	
	if (d[n] == inf) std::cout << -1 << '\n';
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