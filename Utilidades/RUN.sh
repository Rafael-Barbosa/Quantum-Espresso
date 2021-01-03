#!/bin/sh


echo "" 
echo "RUN IV-VI-TETRAGONAL"
echo "" 
echo ""
echo "CX, GeX, SiX e SnX"

echo "===================================================================================================="
DIR=CX
echo "=== CS ==="

MAT=CS

cd /home/padilha/Work/Barbosa/IV-VI-HEXAGONAL/$DIR/$MAT/scf/

echo "=== CALCULANDO SCF ==="
echo ""

mpirun -np 8 pw.x < $MAT-scf.in > $MAT-scf.out

echo "==== CALCULADO SCF ===="
echo ""
echo ""
echo "=== CALCULANDO BANDS PBE ==="
cd ..
cp -r scf bands
cd bands/
cp $MAT-scf.in $MAT-bands.in
NUMA=$(grep -n "K_POINTS" $MAT-bands.in | cut -d: -f1)
NUMA1=$(($NUMA+1))
sed -i "$NUMA,$NUMA1 d" $MAT-bands.in
sed -i "s/scf/bands/" $MAT-bands.in
sed -i "/ecutrho/a \ \ nbnd=30" $MAT-bands.in
cat /home/padilha/Work/Barbosa/IV-VI-HEXAGONAL/KPOINTS >> $MAT-bands.in

mpirun -np 8 pw.x < $MAT-bands.in > $MAT-bands.out 

cp /home/padilha/Work/Barbosa/IV-VI-HEXAGONAL/Qe_Bands.sh .
./Qe_Bands.sh $MAT-bands.out 0.0

echo "==== CALCULO DE BANDAS OK  ==="

cd ..

cp -r scf nscf

cd nscf/
cp $MAT-scf.in $MAT-nscf.in
sed -i "s/scf/nscf/" $MAT-nscf.in
sed -i "/verbosity/a \ \ wf_collect=.TRUE.," $MAT-nscf.in
sed -i "/ecutrho/a \ \ nbnd=200," $MAT-nscf.in
sed -i "/&ELECTRONS/a \ \ diago_full_acc=.TRUE.," $MAT-nscf.in
NSCFK=$(grep -n "K_POINTS" $MAT-nscf.in | cut -d: -f1)
NSCFK1=$(($NSCFK+1))
sed -i "$NSCFK1 d" $MAT-nscf.in
sed -i "/K_POINTS/a \ \ 32\ 32\ 1\ 0\ 0\ 0" $MAT-nscf.in

echo "==== CALCULANDO NSCF  ==="
mpirun -np 8 pw.x < $MAT-nscf.in > $MAT-nscf.out

echo "=== CALCULADO NSCF - FINALIZADO  ==="


echo "===================================================================================================="


