iter=0
successes=0

function run(){
    ((iter=iter+1))
    out=$(./discount_calc $1 $2 $3 $4 $5)
    echo "---------------"
    echo "test #$iter"
    echo "O: $1 B: $2 R: $3 S: $4 P: $5"

    if [[ "$out" == "-2" ]]; then
        printf "\033[38;2;255;0;0minvalid input!\033[0m\n"
    elif [[ "$out" == "-1" ]]; then
        printf "\033[38;2;0;255;0mrefused!\033[0m\n"
        ((successes=successes+1))
    else
        printf "\033[38;2;0;255;0mtotal: %s\033[0m\n" "$out"
        ((successes=successes+1))
    fi
    
}

echo "Black box testing! - special-value testing"

# O
# 51
# integer limit
# 5
# 0

# B
# 0
# integer limit
# 5

# R
# 0
# 3
# integer limit

# P
# 0
# integer limit

# S
# true
# false

# defaults  
def_O=0
def_B=0
def_R=0
def_P=10
def_S=1


for O in 51 32768 5 0; do
    run $O $def_B $def_R $def_S $def_P
done

for B in 0 32768 5; do
    run $def_O $B $def_R $def_S $def_P
done

for R in 0 3 32768; do
    run $def_O $def_B $R $def_S $def_P
done

for S in 0 1; do
    run $def_O $def_B $def_R $S $def_P
done

for P in 0 32768; do
    run $def_O $def_B $def_R $def_S $P
done

echo "Boundary testing:"

for O in -32768 -32767 0 32767 32768; do
    run $O $def_B $def_R $def_S $def_P
done

for B in -32768 -32767 0 32767 32768; do
    run $def_O $B $def_R $def_S $def_P
done

for R in -32768 -32767 0 32767 32768; do
    run $def_O $def_B $R $def_S $def_P
done

for P in -32768 -32767 0 32767 32768; do
    run $def_O $def_B $def_R $def_S $P
done

printf "Results:\nSucceses: \033[38;2;0;255;0m%s \033[0mTests: \033[38;2;0;0;255m%s\n" "$successes" "$iter"