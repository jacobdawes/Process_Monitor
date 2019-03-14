#!/bin/sh

# This script prompts the user and generates process parameter based on known experiments
# Input: user prompted input, files in ./data directory
# Output: files in './experiments' directory

clear

echo ""
echo "This script prompts the user and generates process parameter based on known experiments"
echo "### Input: user prompted input, files in ./data directory"
echo "### Output: files in './experiments' directory"
echo ""


# Experiment description
echo "Number of wafers:"
read NUM_WAFERS
echo "Substrate material: (EMC, SI, SU8, S1818, CR_AL, CU)"
read MATERIAL_SUBSTRATE
echo "Material to be deposited/patterned (SU8, LOR, LOR_S1818, S1818, CR_AL_EVAP, CR_AL_SPUT, CU...)"
read MATERIAL_LAYER
echo "Material thickness (um)"
read LAYER_THICKNESS

# Read back
echo ""
echo "Number of wafers: $NUM_WAFERS"
echo "Substrate material: $MATERIAL_SUBSTRATE"
echo "Material to be deposited/patterned: $LAYER_THICKNESS um of $MATERIAL_LAYER"
echo "See ./experiments for process description"

# Read relevant data from ./data

# Write experiment output file
# -------- call script depending on layer material
./processes/su8_2000.sh $NUM_WAFERS $MATERIAL_SUBSTRATE $LAYER_THICKNESS

