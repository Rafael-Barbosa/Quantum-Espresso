#!/bin/bash

mkdir plot

cd afm/
sh afm.sh
cp parameter-afm.dat ../plot

cd ../nm
sh nm.sh
cp parameter-nm.dat ../plot

cd ../plot

cat > fe2se2-lattice.gp << EOF

#set term png
#set output "lattice-parameter.png"
set grid
set format y "%6.3f"
set title "pbe-n-kjpaw-psl.1.0.0.UPF"
set ylabel "Total energy (Ry)"
set xlabel "Lattice Parameter (A)"

plot 'parameter-afm.dat' w linespoints lw 2 pt 4 ps 1.2 title "AFM",\
'parameter-nm.dat' w linespoints lw 2 pt 4 ps 1.2 title "NM"
pause -1

EOF

gnuplot fe2se2-lattice.gp



