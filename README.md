# ubuntu_latex_jp

## Usage

Building a Latex project
```sh
docker run --rm -v "${PWD}/:/working" ubuntu_latex-jp platex -synctex=1 -interaction=nonstopmode -file-line-error -kanji=utf8 -guess-input-enc {foo_bar_baz}.tex
```


Making pdf from dvi
```sh
docker run --rm -v "${PWD}/:/working" ubuntu_latex-jp dvipdfmx -f yu-win10.map {foo_bar_baz}.dvi 
```



###  VS code 

#### requirement
- Latex-workshop

```json
    // using texlive
    "latex-workshop.view.pdf.viewer": "tab",
    "latex-workshop.latex.tools": [
    {
        "name" : "platex",
        "command": "docker",
        "args": [
            "run", 
            "--rm", 
            "-v",
            "%DIR%:/working",
            "ubuntu_latex-jp",
            "platex",
            "-synctex=1",
            "-interaction=nonstopmode",
            "-file-line-error",
            "-kanji=utf8",
            "-guess-input-enc",
            "%DOCFILE%.tex"
        ]
    },
    {
        "name" : "dvipdfmx",
        "command": "docker",
        "args": [
            "run", 
            "--rm", 
            "-v",
            "%DIR%:/working",
            "ubuntu_latex-jp",
            "dvipdfmx",
            "-f",
            "yu-win10.map",
            "%DOCFILE%"
        ]
    }
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "platex",
            "tools": [
                "platex",
                "dvipdfmx"
            ]
        }
    ],
    "latex-workshop.latex.autoBuild.run": "never",
    // Automatically cleaing files
    //URL: https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile
    "latex-workshop.latex.autoClean.run": "onBuilt",
    "latex-workshop.latex.clean.fileTypes": [
        "*.aux",
        "*.log",
        "*.dvi",
        "*.synctex.gz"
    ]
```
