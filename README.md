# Ubuntu_latex_jp

Ubuntu_latex_jp provides a docker image which contains full versions of TeX Live running on Ubuntu 20.04.
Ubuntu_latex_jp includes a package for CJK (Chinese, Japanese and Korean) Characters.
You can build your project including Chinese, Japanese and Korean.


## Why do I use a docker image ?

- You can start to use Latex easily.
- You do not need to install all latex packages on your system any more.
- You can use the same latex packages on your machines or in a team members.

## Usage

### Building a docker image

First, You have to build a docker image your self.

```
docker build ./ -t ubuntu_latex-jp
``` 

### Options to build a Latex project 

You have options to build your project.
- Command-line interface
- LaTeX Workshop(Extension) on VS code

### Command-line interface

#### Powershell

For example,When you want make pdf from your tex file, you can build a Latex file by the following sequence of cmmands `platex` -> `dvipdfmx`.

1. Compiling a Latex file.

```sh
docker run --rm -v "${PWD}/:/working" ubuntu_latex-jp platex -synctex=1 -interaction=nonstopmode -file-line-error -kanji=utf8 -guess-input-enc {foo_bar_baz}.tex
```

2. Making a pdf from dvi

```sh
docker run --rm -v "${PWD}/:/working" ubuntu_latex-jp dvipdfmx -f yu-win10.map {foo_bar_baz}.dvi 
```

### VS code with LaTeX Workshop(Extension)

You can build your latex project with LaTeX Workshop(Extension) on VS code.

#### Requirements
- VS code (at least 1.42.0) 
- [LaTeX Workshop(Extention of VS code)](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)
  - Project repository: https://github.com/James-Yu/LaTeX-Workshop.

#### Latexmk(recommendation)

Latexmk is a Perl script which you run sequence of commands for building.
By the use of Latexmk,:
- You have setup for VS code just once.
- you can change commands for each project easily. 

1. Make `.latexmkrc` or copy `.latexmkrc` in this repository to your Latex project.
   - `Latexmkrc/For_platex/.latexmkrc`: platex is used.
   - `Latexmkrc/For_uplatex/.latexmkrc`: uplatex is used. 
2. Open the Settings editor from the Command Palette(`Ctrl+Shift+P`) with Preferences: Open Settings (JSON).

3. Enable Docker and set your docker image([using-docker](https://github.com/James-Yu/LaTeX-Workshop/wiki/Install#using-docker)).

```json
    "latex-workshop.docker.enabled": true,
    "latex-workshop.docker.image.latex": "ubuntu_latex_jp",    
```

4. Overwrite LaTeX recipes and tools([latex-recipes](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile#latex-recipes))

```json
    "latex-workshop.latex.tools": [
        {
            "name": "latexmk + Docker",
            "command": "latexmk",
            "args": [
              "%DOC%"
            ]
        },
    ],
    "latex-workshop.latex.recipes": [
        {
            "name": "latexmk + your .latexmkrc with Docker",
            "tools": [
                "latexmk + Docker"
            ]            
        },
    ],


```

5. Call the command to build LaTeX project from the Command Palette(`Ctrl+Shift+P`) or `Ctrl+Alt+B`. 

#### Direct definition of Docker commands

You can directly define commands which you use commands in Command-line interface.

1. Open the Settings editor from the Command Palette (`Ctrl+Shift+P`) with Preferences: Open Settings (JSON).

2. Overwrite LaTeX recipes and tools([latex-recipes](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile#latex-recipes)):

```json
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
    ]
```

3. Call the command to build LaTeX project from the Command Palette(`Ctrl+Shift+P`) or `Ctrl+Alt+B`. 


Options:

Automatically cleaing files.
Check [Compile](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile)

```json
    "latex-workshop.latex.autoClean.run": "onBuilt",
    "latex-workshop.latex.clean.fileTypes": [
        "*.aux",
        "*.log",
        "*.dvi",
        "*.synctex.gz"
```
