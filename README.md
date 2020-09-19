# ubuntu_latex_jp

## Usage

Building a Latex project

> docker run --rm -it -v "${PWD}/:/working" ubuntu_latex-jp platex -synctex=1 -interaction=nonstopmode -file-line-error -kanji=utf8 -guess-input-enc {foo_bar_baz}.tex


Making pdf from dvi

> docker run --rm -it -v "${PWD}/:/working" ubuntu_latex-jp dvipdfmx -f yu-win10.map {foo_bar_baz}.dvi 