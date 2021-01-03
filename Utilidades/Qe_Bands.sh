#!/bin/bash
#
# variables used :
# 1) KSstates           = number of Kohn-Sham states in the system
# 2) nkpts              = total number of K points
# 3) EnergyValues.txt   = output file

## for this job == bash ./Qe_Bands.sh BANDS_out -2.3692

if [ $# != 2 ]
then
    echo
    echo "Usage : bash $0 BANDS_out <Fermi energy>"
    echo
    exit
else
    InputFile=$1
    FermiEnergy=$2
fi

if [ -f "$InputFile" ]
then
	spin=`grep " SPIN " $InputFile | wc -l`
	if [ $spin == 0 ]
	then
		echo "SPIN UNPOLARIZED CALCULATION"
	else
		echo "SPIN POLARIZED CALCULATION"
        echo "Following k-points found in the $InputFile file"
	fi
	KSstates=`grep "number of Kohn-Sham states=" $InputFile | head -1 | awk '{printf "%d\n",$5}'`
        klength=`echo "${#KSstates}"`
	rem=$(( $KSstates % 8 ))
	if [ $rem -eq 0 ]
	then
		lines=`expr $KSstates / 8`
	else
		lines=`expr $KSstates / 8 + 1`
	fi
	nkpts=`grep "number of k points=" $InputFile | awk '{printf "%d\n",$5}'`
	length=`echo "${#nkpts}"`
	LN=`grep -n "   k = " $InputFile | cut -d ":" -f 1 | awk '{printf "%d\n",$1}'`
	array1=($LN)

	for i in `seq 0 1 $(($((${#array1[*]}))-1))`
	do
        kpoint=`expr $i + 1`
        grep " $kpoint) = (" $InputFile | grep "wk" | tail -1 | awk '{printf "k ( %'$length's) = %f  %f  %f\n",'$kpoint',$5,$6,$7}'
		EigenValues=`head -$((${array1[i]}+$lines+1)) $InputFile | tail -$lines`
		array=($EigenValues)
		for j in `seq 0 1 $(($((${#array[*]}))-1))`
		do
			E_Ef=`echo "${array[j]} - $FermiEnergy" | bc -l`
			echo -n " "$E_Ef    >> FILE
		done
		echo							>> FILE
	done
else
	echo "File $InputFile doesn't exist"
	exit
fi

if [ $spin == 2 ]
then
    echo "#  band    Energy (Up)    Energy (down)" > EnergyValues.txt
else
    echo "#  band         Energy"                   > EnergyValues.txt
fi
for k in `seq 1 $KSstates`
do
	awk '{printf "%15s\n",$'$k'}' FILE					>  FAKE.txt
	if [ $spin == 2 ]
	then
		head -$(($nkpts/$spin)) FAKE.txt 			>  F1
		tail -$(($nkpts/$spin)) FAKE.txt 			>  F2
		paste F1 F2 | awk '{printf "%12s%15s\n",$1,$2}'		>  F3
		nl F3							>> EnergyValues.txt
        rm F1 F2 F3 FAKE.txt
	else
		nl FAKE.txt						>> EnergyValues.txt
        rm FAKE.txt
	fi
	echo                >> EnergyValues.txt
done
rm FILE
echo
echo "The output is written to EnergyValues.txt"
echo "The energy values are with respect to Fermi energy (E - $FermiEnergy)."
echo
