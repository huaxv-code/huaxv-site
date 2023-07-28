# vscode 配置

=== "settings.json"

    ```json
    {
        "editor.fontSize": 24,
        "terminal.integrated.fontSize": 24,
        "code-runner.executorMapByFileExtension": {
            ".yml": "push setting",
            ".md": "push $fileName",
            ".vb": "cd $dir && vbc /nologo $fileName && $dir$fileNameWithoutExt",
            ".vbs": "cscript //Nologo",
            ".scala": "scala",
            ".jl": "julia",
            ".cr": "crystal",
            ".ml": "ocaml",
            ".zig": "zig run",
            ".exs": "elixir",
            ".hx": "haxe --cwd $dirWithoutTrailingSlash --run $fileNameWithoutExt",
            ".rkt": "racket",
            ".scm": "csi -script",
            ".ahk": "autohotkey",
            ".au3": "autoit3",
            ".kt": "cd $dir && kotlinc $fileName -include-runtime -d $fileNameWithoutExt.jar && java -jar $fileNameWithoutExt.jar",
            ".kts": "kotlinc -script",
            ".dart": "dart",
            ".pas": "cd $dir && fpc $fileName && $dir$fileNameWithoutExt",
            ".pp": "cd $dir && fpc $fileName && $dir$fileNameWithoutExt",
            ".d": "cd $dir && dmd $fileName && $dir$fileNameWithoutExt",
            ".hs": "runhaskell",
            ".nim": "nim compile --verbosity:0 --hints:off --run",
            ".csproj": "dotnet run --project",
            ".fsproj": "dotnet run --project",
            ".lisp": "sbcl --script",
            ".kit": "kitc --run",
            ".v": "v run",
            ".vsh": "v run",
            ".sass": "sass --style expanded",
            ".cu": "cd $dir && nvcc $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
            ".ring": "ring",
            ".sml": "cd $dir && sml $fileName"
        },
        "code-runner.executorMap": {

            "javascript": "node",

            // "java": "cd $dir && javac $fileName && start cmd /k java $fileNameWithoutExt",
            // "c": "cd $dir && gcc $fileName -o $fileNameWithoutExt && start cmd /k  $dir$fileNameWithoutExt",
            // "cpp": "cd $dir && g++ $fileName -o $fileNameWithoutExt && start cmd /k  $dir$fileNameWithoutExt",
            // "python": "start cmd /k  python -u",

            "java": "check $dir java $fileNameWithoutExt",
            "c": "check $dir c $fileNameWithoutExt",
            "cpp": "check $dir cpp $fileNameWithoutExt",
            "python": "check $dir py $fileNameWithoutExt",

            "zig": "zig run",
            "objective-c": "cd $dir && gcc -framework Cocoa $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
            "php": "php",
            "perl": "perl",
            "perl6": "perl6",
            "ruby": "ruby",
            "go": "go run",
            "lua": "lua",
            "groovy": "groovy",
            "powershell": "powershell -ExecutionPolicy ByPass -File",
            "bat": "cmd /c",
            "shellscript": "bash",
            "fsharp": "fsi",
            "csharp": "scriptcs",
            "vbscript": "cscript //Nologo",
            "typescript": "ts-node",
            "coffeescript": "coffee",
            "scala": "scala",
            "swift": "swift",
            "julia": "julia",
            "crystal": "crystal",
            "ocaml": "ocaml",
            "r": "Rscript",
            "applescript": "osascript",
            "clojure": "lein exec",
            "haxe": "haxe --cwd $dirWithoutTrailingSlash --run $fileNameWithoutExt",
            "rust": "cd $dir && rustc $fileName && $dir$fileNameWithoutExt",
            "racket": "racket",
            "scheme": "csi -script",
            "ahk": "autohotkey",
            "autoit": "autoit3",
            "dart": "dart",
            "pascal": "cd $dir && fpc $fileName && $dir$fileNameWithoutExt",
            "d": "cd $dir && dmd $fileName && $dir$fileNameWithoutExt",
            "haskell": "runghc",
            "nim": "nim compile --verbosity:0 --hints:off --run",
            "lisp": "sbcl --script",
            "kit": "kitc --run",
            "v": "v run",
            "sass": "sass --style expanded",
            "scss": "scss --style expanded",
            "less": "cd $dir && lessc $fileName $fileNameWithoutExt.css",
            "FortranFreeForm": "cd $dir && gfortran $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
            "fortran-modern": "cd $dir && gfortran $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
            "fortran_fixed-form": "cd $dir && gfortran $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
            "fortran": "cd $dir && gfortran $fileName -o $fileNameWithoutExt && $dir$fileNameWithoutExt",
            "sml": "cd $dir && sml $fileName"
        },
        "terminal.integrated.defaultProfile.windows": "Command Prompt",
        "code-runner.runInTerminal": true,
        "redhat.telemetry.enabled": true,
        "code-runner.languageIdToFileExtensionMap": {

            "bat": ".bat",
            "powershell": ".ps1",
            "typescript": ".ts"
        },
        "workbench.startupEditor": "none",
        // "editor.stickyScroll.enabled": true,
        "cph.general.defaultLanguage": "cpp",
        "cph.language.cpp.Args": "-w -std=c++17 -static -O2 -Wall -Wextra -Wl,--stack=549453824",
        "cph.general.retainWebviewContext": true,
        "update.enableWindowsBackgroundUpdates": false,
        "update.showReleaseNotes": false,
        "extensions.autoCheckUpdates": false,
        "editor.fontFamily": "'Cascadia Code', Consolas, 'Courier New', monospace",
        "editor.fontLigatures": true,

        // 下面三个选项是禁用代码提示功能
        "editor.hover.enabled": false,
        "editor.parameterHints.enabled": false,
        "editor.quickSuggestions": {
            "other": "on"
        },
        "update.mode": "none",
        "editor.tabCompletion": "on",
        "editor.acceptSuggestionOnEnter": "off",
        "explorer.confirmDelete": false,
        "editor.trimAutoWhitespace": false,
        "cph.language.java.Args": "-encoding utf8",
        "settingsSync.ignoredExtensions": [
            "ms-vsliveshare.vsliveshare"
        ],
        "workbench.colorTheme": "Solarized Light",
        // "update.mode": "none",
        "files.exclude": {
            "**/.git": true,
            "**/.svn": true,
            "**/.hg": true,
            "**/CVS": true,
            "**/.DS_Store": true,
            "**/Thumbs.db": true,
            "**/*.exe": true, // 忽视文件 *.exe
        },
        "terminal.integrated.windowsEnableConpty": false,
        "cph.general.timeOut": 5000,
        "markdown-preview-enhanced.previewTheme": "atom-dark.css",
        "workbench.sideBar.location": "right",
    }
    ```

=== "cpp.json"

    ```json
    {
        // Place your snippets for cpp here. Each snippet is defined under a snippet name and has a prefix, body and 
        // description. The prefix is what is used to trigger the snippet and the body will be expanded and inserted. Possible variables are:
        // $1, $2 for tab stops, $0 for the final cursor position, and ${1:label}, ${2:another} for placeholders. Placeholders with the 
        // same ids are connected.
        // Example:
        "Print to console": {
            "prefix": "code",
            "body": [
                "#include <bits/stdc++.h>",
                "",
                "using namespace std;",
                "#define ll long long",
                "#define rll register long long",
                "#define endl '\\n'",
                "template <typename T>",
                "void read(T& x);",
                "const ll N = 2000000;",
                "",
                "",
                "${0}",
                "",
                "",
                "void solve()",
                "{",
                "    ",
                "    ",
                "    ",
                "}",
                "",
                "int main()",
                "{",
                "    // ios::sync_with_stdio(0);",
                "    // cin.tie(0); cout.tie(0);",
                "    ",
                "",
                "    solve();",
                "    return 0;",
                "}",
                "",
                "template <typename T>",
                "void read(T& x)",
                "{",
                "    x = 0; ",
                "    T f = 1;",
                "    register char c = getchar();",
                "    while (!(c >= '0' && c <= '9'))",
                "    {",
                "        if (c == '-') f = -1;",
                "        c = getchar();",
                "    }",
                "    while (c >= '0' && c <= '9')",
                "    {",
                "        x = x * 10 + c - '0';",
                "        c = getchar();",
                "    }",
                "    x *= f;",
                "}",
            ],
            "description": "Log output to console"
        }
    }
    ```

=== "java.json"

    ```json
    {
        // Place your snippets for java here. Each snippet is defined under a snippet name and has a prefix, body and 
        // description. The prefix is what is used to trigger the snippet and the body will be expanded and inserted. Possible variables are:
        // $1, $2 for tab stops, $0 for the final cursor position, and ${1:label}, ${2:another} for placeholders. Placeholders with the 
        // same ids are connected.
        // Example:
        "Print to console": {
            "prefix": "code",
            "body": [
                "import java.util.*;",
                "import java.io.*;",
                "import java.math.*;",
                "",
                "public class Main",
                "{",
                "	",
                "	",
                "	",
                "    void solve() throws Exception",
                "    {",
                "		",
                "		",
                "		",
                "    }",
                "",
                "    public static void main(String[] args) throws Exception",
                "    {",
                "        Main cmd = new Main();",
                "        cmd.solve();",
                "        cout.flush();",
                "    }",
                "",
                "    public static BufferedReader cin = new BufferedReader(new InputStreamReader(System.in));",
                "    public static PrintWriter cout = new PrintWriter(new OutputStreamWriter(System.out));",
                "    public static String space = \"\\\\\\s+\";",
                "",
                "    public static String[] gss() throws Exception",
                "    {",
                "        return cin.readLine().split(space);",
                "    }",
                "",
                "    public static int gii(String s)",
                "    {",
                "        return Integer.parseInt(s);",
                "    }",
                "",
                "    public static long gll(String s)",
                "    {",
                "        return Long.parseLong(s);",
                "    }",
                "",
                "    public static double gff(String s)",
                "    {",
                "        return Double.parseDouble(s);",
                "    }",
                "    ",
                "}",
            ],
            "description": "Log output to console"
        }
    }
    ```

