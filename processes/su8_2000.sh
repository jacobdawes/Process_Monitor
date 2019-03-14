#!/bin/sh

# This script is called by process.sh to generate a file containing process parameters
# Arguments:
#   -number of wafers in experiment
#   -substrate
#   -material thickness (um)



# MATERIAL INDEPENDENT (MOSTLY)
NUM_WAFER=$1
MAT_SUBST=$2
MAT_THICK=$3

# Generate experiment number and filename
um="UM_"
dash="_"
base_path_name="./experiments/SU8_"
base_path_name=$base_path_name$MAT_THICK$um$MAT_SUBST$dash
filetype=".txt"

xp_num=1
test_path_name="$base_path_name$xp_num$filetype"
echo $test_path_name
while [ -f $test_path_name ]
do
    echo $test_path_name
    xp_num=$(($xp_num + 1))
    test_path_name="$base_path_name$xp_num$filetype"
done

echo $test_path_name

# Date
TODAY=$(date +'%m/%d/%y')




# MATERIAL DEPENDENT OUTPUTS
# SU-8 type
SU8_TYPE="nice"

# Bake parameters
D_BAKE_TEMP=0
D_BAKE_TIME=0
S_BAKE_TEMP=0
S_BAKE_TIME=0
PE_BAKE_TEMP=0
PE_BAKE_TIME=0
H_BAKE_TEMP=0
H_BAKE_TIME=0

# Spin parameters
SPIN_SPEED=0
SPIN_TIME=0
SPIN_ACCEL=0

# Exposure Parameters
EXP_E=0
EXP_T=0

# Development Parameters
DEV_TIME=0



# READ VALUES FROM DATA FILES
d_bake_params="./data/su8_2000/dehydration_bake.csv"
spin_params="./data/su8_2000/spin_speed.csv"




# WRITE ALL TO EXPERIMENT FILE
{
    echo "Experiment $xp_num"
    echo "date: $TODAY"
    echo ""
    echo "Deposit/pattern $MAT_THICK um SU8 on $MAT_SUBST substrate for $NUM_WAFER wafers."
    echo ""
    echo ""
    echo "Dehydration bake: $D_BAKE_TIME minutes at $D_BAKE_TEMP C"
    echo "Spin: $SU8_TYPE for $SPIN_TIME at $SPIN_SPEED rpm with acceleration of $SPIN_ACCEL"
    echo "Soft bake: $S_BAKE_TIME minutes at $S_BAKE_TEMP C"
    echo "Exposure: $EXP_E mJ (currently $EXP_T s)"
    echo "Post exposure bake: $PE_BAKE_TIME minutes at $_PE_BAKE_TEMP C"
    echo "Develop: $DEV_TIME minutes in SU8 developer"
    echo "Hard bake (optional): $H_BAKE_TIME minutes at $H_BAKE_TEMP C"
    echo ""
    echo "Please provide results for this experiment in the data directory."
    echo ""
}>$test_path_name




