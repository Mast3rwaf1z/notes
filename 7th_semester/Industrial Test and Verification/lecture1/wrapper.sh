#!/bin/bash

iteration=0

for O in $(seq 0 50); do
	for B in $(seq 0 50); do
		for R in $(seq 0 3); do
			for S in 1; do
				for P in 10; do
					((iteration=iteration+1))
					output=$(./discount_calc $O $B $R $S $P)
					if ! [ -z $output ]; then
						echo "---------------"
						echo "$iteration] O: $O B: $B R: $R S: $S P: $P"
						echo "Output: $output"
					fi
				done
			done
		done
	done
done
