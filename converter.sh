#!/bin/bash

input=${1}
width=120
height=30

width_=$((width-1))
height_=$((height-1))

rm -r "./"$input
ffmpeg -i $input".gif" -vsync 0 $input"%02d.bmp"

mkdir $input
mv *.bmp "./"$input

cd "./"$input

for a in $(ls)
do
	ffmpeg -i $a -vf scale=120:30 $a -y
	b=$(xxd -s 0x36 -p $a | tr -d '\12')
	echo -n $b >> $a"_"	
	a=${a:0:-4}

	for i in $(seq 0 $width_)
	do
		for j in $(seq 0 $height_)
		do
			offset=$((8*(i*width+j)))
			s=${b:$offset:6}
			echo -n $s >> $a"_"$i
		done
	done
done

mkdir bmp
mv *.bmp "./bmp"
