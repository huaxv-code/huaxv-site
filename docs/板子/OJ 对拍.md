# OJ 对拍

```c++
#include <bits/stdc++.h>
#include <windows.h>

using namespace std;
set<char> st = {'\f', '\b', '\n', ' ', '\t'};

string gss(string s) {
    string res, ts;
    for (auto c : s) {
        if (st.count(c)) {
            if (ts != "") res += ts + " ";
            ts = "";
        }
        else ts += c;
    }
    if (ts != "") res += ts + " ";
    return res;
}

int check(string f1 = "out.txt", string f2 = "res.txt") {
    ifstream fout(f1);
    ifstream fres(f2);
    int line = 0;
    while (++ line) {
        string s1, s2;
        auto& x = getline(fout, s1);
        auto& y = getline(fres, s2);
        if (!x && !y) {
            line = 0; break;
        }
        else if (gss(s1) != gss(s2)) break;
    }
    fout.close(); fres.close();
    return line;
}

int main() {
    int N = 10;
    system("g++ -std=c++14 Main.cpp -o Main");
    system("g++ -std=c++14 Random.cpp -o Random");
    system("g++ -std=c++14 Answer.cpp -o Answer");
    while (N --) {
        system("Random >in.txt && Answer <in.txt>res.txt && Main <in.txt>out.txt");
        int ln = check(); if (ln) {
            cout << "Different in line: " << ln << '\n'; return 0;
        } else cout << "Pass\n";
    }
    cout << "All Accept\n";
    return 0;
}
```