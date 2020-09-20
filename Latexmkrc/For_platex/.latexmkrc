#!/usr/bin/env perl

$latex = 'platex -synctex=1 -interaction=nonstopmode -file-line-error -kanji=utf8 -guess-input-enc';
$max_repeat = 3;

$lualatex = 'lualatex %O -synctex=1 -interaction=nonstopmode %S';

$bibtex  = 'pbibtex %O %B';

# index
$makeindex = 'mendex %O -o %D %S';

$dvipdf = 'dvipdfmx %O -o %D %S';
$pdf_mode = 3;
