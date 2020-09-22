# Ubuntu_latex_jp

Ubuntu_latex_jp provides a docker image which contains full versions of TeX Live running on Ubuntu 20.04.
Ubuntu_latex_jp includes a package for CJK (Chinese, Japanese and Korean) Characters.
You can build your project including Chinese, Japanese and Korean.

## Why do I use a docker image?

- You can start to use Latex easily.
- You do not need to install all Latex packages on your system any more.
- You can use the same Latex packages on your machines or in a team members.

## Table of contents

- [Usage](https://github.com/satoshifuku/ubuntu_latex_jp#usage)
    - [Building a docker image](https://github.com/satoshifuku/ubuntu_latex_jp#building-a-docker-image)
    - [Options to build a Latex project](https://github.com/satoshifuku/ubuntu_latex_jp#options-to-build-a-latex-project)
    - [Command-line interface](https://github.com/satoshifuku/ubuntu_latex_jp#command-line-interface)
      - [Latexmk](https://github.com/satoshifuku/ubuntu_latex_jp/blob/master/README.md#latexmk)
      - [Run commands step-by-step](https://github.com/satoshifuku/ubuntu_latex_jp#run-commands-step-by-step)
    - [VS code with LaTeX Workshop(Extension)](https://github.com/satoshifuku/ubuntu_latex_jp#vs-code-with-latex-workshopextension)
      - [Latexmk(recommendation)](https://github.com/satoshifuku/ubuntu_latex_jp#latexmkrecommendation)
      -  [Direct definition of Docker commands](https://github.com/satoshifuku/ubuntu_latex_jp#direct-definition-of-docker-commands)
      -  [More options for LaTeX Workshop](https://github.com/satoshifuku/ubuntu_latex_jp#more-options-for-latex-workshop)
    - [Limitations](https://github.com/satoshifuku/ubuntu_latex_jp/blob/master/README.md#limitations)

## Usage

### Building a docker image

First, You have to build a docker image your self.

```sh
docker build ./ -t ubuntu_latex-jp
```

### Options to build a Latex project

You have options to build your project.
- Command-line interface.
- LaTeX Workshop(Extension) on VS code.

### Command-line interface

You can use any edites you are prefer and using, when you build on Command-line interface.

#### Latexmk
1. Make `.latexmkrc` yourself or copy `.latexmkrc` in this repository to a directory of your Latex project.
   - `Latexmkrc/For_platex/.latexmkrc`: platex is used.
   - `Latexmkrc/For_uplatex/.latexmkrc`: uplatex is used. 
2. Run latexmk with the Docker image.
```sh
docker run --rm -v "${PWD}/:/working" ubuntu_latex-jp latexmk {foo_bar_baz}.tex
```

#### Run commands step-by-step
For example, when you want make pdf from your tex file, you can build a Latex file by the following sequence of cmmands `platex` -> `dvipdfmx`.

1. You have to allow local directories on your computer to be shared with containers. 
Check your setting of a file sharing on your computer(`Preferences` / `Settings` > `Resources` >`File sharing`).
2. Compile a Latex file(.tex).

```sh
docker run --rm -v "${PWD}/:/working" ubuntu_latex-jp platex -synctex=1 -interaction=nonstopmode -file-line-error -kanji=utf8 -guess-input-enc {foo_bar_baz}.tex
```

3. Make a pdf from dvi

```sh
docker run --rm -v "${PWD}/:/working" ubuntu_latex-jp dvipdfmx -f yu-win10.map {foo_bar_baz}.dvi
```

### VS code with LaTeX Workshop(Extension)

You can build your Latex project with LaTeX Workshop(Extension) on VS code.

Requirements:
- VS code (at least 1.42.0) 
- [LaTeX Workshop(Extention of VS code)](https://marketplace.visualstudio.com/items?itemName=James-Yu.latex-workshop)
  - Project repository: https://github.com/James-Yu/LaTeX-Workshop.

#### Latexmk(recommendation)

Latexmk is a Perl script which you run sequence of commands for building.
By the use of Latexmk,:
- you edit seting.json for VS code just once.
- you can change commands for each project easily.

1. Make `.latexmkrc` yourself or copy `.latexmkrc` in this repository to a directory of your Latex project.
   - `Latexmkrc/For_platex/.latexmkrc`: platex is used.
   - `Latexmkrc/For_uplatex/.latexmkrc`: uplatex is used. 
2. Open the Settings editor from the Command Palette(`Ctrl+Shift+P`) with Preferences: Open Settings (JSON).

3. Enable Docker and set your docker image([using-docker](https://github.com/James-Yu/LaTeX-Workshop/wiki/Install#using-docker)).

```json
    "latex-workshop.docker.enabled": true,
    "latex-workshop.docker.image.latex": "ubuntu_latex_jp"
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
    ]
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

#### More options for LaTeX Workshop

Automatically cleaing files after building your LaTeX project .
Check [Compile](https://github.com/James-Yu/LaTeX-Workshop/wiki/Compile)

```json
    "latex-workshop.latex.autoClean.run": "onBuilt",
    "latex-workshop.latex.clean.fileTypes": [
        "*.aux",
        "*.log",
        "*.dvi",
        "*.synctex.gz"
    ]
```

### Limitations:
#### Not working synctex.

Temporary solution:

You may correctly work the internal synctex of Latex workshop by the following commands in a directory of your Latex project.

Powershell:
```powershell
((Get-Content (Get-Item *.synctex)).replace('/data', ${PWD})  -join "`n") + "`n" | Set-Content -NoNewline (Get-Item *.synctex)
```
