#!/bin/bash

# Generate results file for a given experiment
clear


echo "Enter name of experiment (ex - SU8_2UM_EMC_1): "
read EXP_NAME
echo "Enter number of wafers in experiment: "
read NUM_WAFERS

# Generate file in ./experiments/results
base_path="./experiments/"
results_path="./experiments/results/"
file_type=".txt"
filepath="$base_path$EXP_NAME$file_type"
destination=""
cp "$filepath" "$results_path$EXP_NAME$file_type"
{
    echo "RESULTS"
    echo ""
}>>"$results_path$EXP_NAME$file_type"



# For each wafer, offer questionaire to determine quality of each sample
# Keep track of stats
# Write data to results file as we go
MAJOR_DELAM_COUNT=0
MAJOR_DELAM_AVG=0
DELAM_LEN_SUM=0
DELAM_LEN_AVG=0
VALID_WAFER_COUNT=0
for ((i=1; i<=$NUM_WAFERS; i++))
do

    # Read data
    echo "Were the suggested process steps exactly followed? (y/n)"
    read VALID_WAFER
    echo "Wafer $i - Major delamination of layer from substrate? (y/n)"
    read MAJOR_DELAM
    echo "Wafer $i - Length of average delamination of layer from substrate in um (0 if none present)"
    read DELAM_LEN
    echo "Comments?"
    read COMMENTS
    # Include other factors as they come up...
    
    # Keep track of stats - but they only count if the wafer was valid
    if [ "$VALID_WAFER" = "y" ]
    then
        ((VALID_WAFER_COUNT++))
        if [ "$MAJOR_DELAM" = "y" ]
        then
            ((MAJOR_DELAM_COUNT++))
        fi
        DELAM_LEN_SUM=$((DELAM_LEN_SUM+DELAM_LEN))
    fi

    # Append results to human readable file
    {
        echo "Wafer $i (valid? $VALID_WAFER)"
        echo "Major Delamination: $MAJOR_DELAM"
        echo "Delamination Length: $DELAM_LEN"
        echo "Comments: $COMMENTS"
        echo ""
    }>>"$results_path$EXP_NAME$file_type"
done


# Calculate averages
MAJOR_DELAM_AVG=$((100*MAJOR_DELAM_COUNT / VALID_WAFER_COUNT))
DELAM_LEN_AVG=$(((DELAM_LEN_SUM + NUM_WAFERS-1) / VALID_WAFER_COUNT))

# Write summary of data to file
{
    echo ""
    echo "SUMMARY"
    echo "Of the $NUM_WAFERS wafers, $VALID_WAFER_COUNT are valid for analysis"
    echo "Major delamination occured on $MAJOR_DELAM_AVG % of valid wafers"
    echo "Average delamination length was $DELAM_LEN_AVG um"
}>>"$results_path$EXP_NAME$file_type"






