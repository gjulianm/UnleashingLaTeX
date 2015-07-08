#!/usr/bin/gnuplot

set termoption dashed
set term cairolatex color size 4.7in,3in dashed font ",10"

set output "graph.tex"

set title "A test"

set grid x y

set key center top

set rmargin 0.1

plot 'datafile.txt' using 1:2 with lines lt 2
