#!/bin/bash

# ./rep_cut.sh ${filename} ${width} ${height}
# cutting 3bytes for every 4bytes

file=${1}
width=${2}
height=${3}

width_=$((width-1))
height_=$((height-1))

for i in $(seq 0 $height_)
do
	for j in $(seq 0 1)
	do
		offset=$((4*(i*width+j)))
		xxd -r -s $offset -l 3 -p $file | xxd -r -p >> $file"cut"$j
	done
done
