# Ubuntu_latex_jp

Ubuntu_latex_jp provides a docker image, which contains full versions of TeX Live running on Ubuntu 20.04.

## Why do I use a docker image ?

When you used docker imaged to build latex project:
- you do not need to install all latex packages on your system any more.
- you can use the same latex packages on your machines or in a team members.


## Building a docker image

Build a docker image with Dockerfile

```
docker build ./ -t ubuntu_latex-jp
``` 

## Usage


Building a Latex file

```sh
docker run --rm -v "${PWD}/:/working" ubuntu_latex-jp platex -synctex=1 -interaction=nonstopmode -file-line-error -kanji=utf8 -guess-input-enc {foo_bar_baz}.tex
```

Making a pdf from dvi

```sh
docker run --rm -v "${PWD}/:/working" ubuntu_latex-jp dvipdfmx -f yu-win10.map {foo_bar_baz}.dvi 
```

### On VS code 

You can build your latex project on VS code with an extension.

#### Requirements 
First, add [LaTeX Workshop](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)([Project repository](https://github.com/James-Yu/LaTeX-Workshop)) to your VS code.


#### Settings for LaTeX Workshop

You need edit settings.json with Settings editor.

1. Open the Settings editor from the Command Palette (Ctrl+Shift+P) with Preferences: Open Settings (JSON).

2. Add the followings:

```json
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
                "platex",
                "dvipdfmx"
            ]
        }
    ],
    "latex-workshop.latex.autoBuild.run": "never",
    ]
```

Options:

Automatically cleaing files.

```json
    //URL: https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile
    "latex-workshop.latex.autoClean.run": "onBuilt",
    "latex-workshop.latex.clean.fileTypes": [
        "*.aux",
        "*.log",
        "*.dvi",
        "*.synctex.gz"
```
