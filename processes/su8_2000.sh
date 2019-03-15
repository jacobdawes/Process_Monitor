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
<<<<<<< HEAD
SPIN_TIME=30
=======
SPIN_TIME=0
>>>>>>> 5e8758bfc701611072da34b25c1c0ce29ae4562c
SPIN_ACCEL=0

# Exposure Parameters
EXP_E=0
EXP_T=0

# Development Parameters
DEV_TIME=0



# READ VALUES FROM DATA FILES
d_bake_params="./data/su8_2000/dehydration_bake.csv"
<<<<<<< HEAD
spin_params="./data/su8_2000/spin.csv"
s_bake_params="/data/su8_2000/soft_bake.csv"
exposure_params="/data/su8_2000/exposure.csv"
pe_bake_params="/data/su8_2000/pe_bake.csv"
develop_params="/data/su8_2000/develop.csv"
h_bake_params="/data/su8_2000/hard_bake.csv"
if [ "$MAT_SUBST" = "EMC" ]
then
    D_BAKE_TEMP=$(awk 'BEGIN { FS = ","} ; {if(NR==2) print $2}' <"$d_bake_params")
    D_BAKE_TIME=$(awk 'BEGIN { FS = ","} ; {if(NR==2) print $3}' <"$d_bake_params")
elif [ "$MAT_SUBST" = "SU8" ]
then
    D_BAKE_TEMP=$(awk 'BEGIN { FS = ","} ; {if(NR==3) print $2}' <"$d_bake_params")
    D_BAKE_TEMP=$(awk 'BEGIN { FS = ","} ; {if(NR==3) print $3}' <"$d_bake_params")
elif [ "$MAT_SUBST" = "SI" ]
then
    D_BAKE_TEMP=$(awk 'BEGIN { FS = ","} ; {if(NR==4) print $2}' <"$d_bake_params")
    D_BAKE_TEMP=$(awk 'BEGIN { FS = ","} ; {if(NR==4) print $3}' <"$d_bake_params")
else
    D_BAKE_TEMP=$(awk 'BEGIN { FS = ","} ; {if(NR==2) print $2}' <"$d_bake_params")
    D_BAKE_TEMP=$(awk 'BEGIN { FS = ","} ; {if(NR==2) print $3}' <"$d_bake_params")
fi
if [ "$MAT_THICK" -lt "51" ]
then
    SU8_TYPE=$(awk -v thickness=$MAT_THICK 'BEGIN { FS = ","} ; {if(NR==thickness) print $2}' <"$spin_params")
    echo "$SU8_TYPE"
    if [ "$SU8_TYPE" = " NA" ]
    then
        echo "Parameters for $MAT_THICK um not found."
        SU8_TYPE="SU8_200xx"
        SPIN_SPEED="3000 (default)"
        SPIN_ACCEL="300 (default)"
    else 
        SPIN_SPEED=$(awk -v thickness=$MAT_THICK 'BEGIN { FS = ","} ; {if(NR==thickness) print $3}' <"$spin_params")
        SPIN_ACCEL=$(awk -v thickness=$MAT_THICK 'BEGIN { FS = ","} ; {if(NR==thickness) print $4}' <"$spin_params")
    fi
fi
=======
spin_params="./data/su8_2000/spin_speed.csv"


>>>>>>> 5e8758bfc701611072da34b25c1c0ce29ae4562c


# WRITE ALL TO EXPERIMENT FILE
{
    echo "Experiment $xp_num"
<<<<<<< HEAD
    echo "Date: $TODAY"
=======
    echo "date: $TODAY"
>>>>>>> 5e8758bfc701611072da34b25c1c0ce29ae4562c
    echo ""
    echo "Deposit/pattern $MAT_THICK um SU8 on $MAT_SUBST substrate for $NUM_WAFER wafers."
    echo ""
    echo ""
<<<<<<< HEAD
    echo "O2 plasma ash for 2 minutes"
    echo ""
    echo "Dehydration bake: $D_BAKE_TIME minutes at $D_BAKE_TEMP C"
    echo ""
    echo "Spin:$SU8_TYPE for $SPIN_TIME seconds at$SPIN_SPEED rpm with acceleration of$SPIN_ACCEL rpm/s"
    echo ""
    echo "Soft bake: $S_BAKE_TIME minutes at $S_BAKE_TEMP C"
    echo ""
    echo "Exposure: $EXP_E mJ (currently $EXP_T s)"
    echo ""
    echo "Post exposure bake: $PE_BAKE_TIME minutes at $_PE_BAKE_TEMP C"
    echo ""
    echo "Develop: $DEV_TIME minutes in SU8 developer"
    echo ""
    echo "Hard bake (optional): $H_BAKE_TIME minutes at $H_BAKE_TEMP C"
    echo ""
    echo ""
=======
    echo "Dehydration bake: $D_BAKE_TIME minutes at $D_BAKE_TEMP C"
    echo "Spin: $SU8_TYPE for $SPIN_TIME at $SPIN_SPEED rpm with acceleration of $SPIN_ACCEL"
    echo "Soft bake: $S_BAKE_TIME minutes at $S_BAKE_TEMP C"
    echo "Exposure: $EXP_E mJ (currently $EXP_T s)"
    echo "Post exposure bake: $PE_BAKE_TIME minutes at $_PE_BAKE_TEMP C"
    echo "Develop: $DEV_TIME minutes in SU8 developer"
    echo "Hard bake (optional): $H_BAKE_TIME minutes at $H_BAKE_TEMP C"
    echo ""
>>>>>>> 5e8758bfc701611072da34b25c1c0ce29ae4562c
    echo "Please provide results for this experiment in the data directory."
    echo ""
}>$test_path_name




