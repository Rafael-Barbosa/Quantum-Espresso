#!/bin/sh                                                                                                                                      


echo
echo "run_all"
D=GeX
# run all examples
for dir in MAT*  GeS GeSe GeTe ;
do
    if test -f $D/$dir/RUN.sh
    then
        sh $D/$dir/RUN.sh
    fi
done


D1=SiX
# run all examples
for dir1 in MAT1*  SiO SiS SiSe SiTe ;
do
    if test -f $D1/$dir1/RUN.sh
    then
        sh $D1/$dir1/RUN.sh
    fi
done


D2=SnX
# run all examples
for dir2 in MAT2*  SnO SnS SnSe ;
do
    if test -f $D2/$dir2/RUN.sh
    then
        sh $D2/$dir2/RUN.sh
    fi
done

echo
echo "run_all: done"

