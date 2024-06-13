#!/bin/bash
# Copyright 2024 ARC Centre of Excellence for Climate Extremes
#
# author: Sam Green <sam.green@unsw.edu.au>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
#This script is to concatenate the mswep monthly/daily data into yearly files and 3hourly data into monthly files.
#
#Date created: 06-06-2024

# The frequency to concatenate:
if [ "$1" == "-f" ]; then
    freq=$2
    if [[ "$freq" == "day" || "$freq" == "mon" || "$freq" == "3hr" ]]; then
        echo "The data frequency is $freq"
    else
        echo "Invalid frequency: $freq"
        echo "Usage: $0 -f <freq>; freq = day, mon, 3hr"
    fi
else
    echo "Usage: $0 -f <freq>; freq = day, mon, 3hr"
fi

root_dir="/g/data/ia39/aus-ref-clim-data-nci/mswep/data/$freq/tmp/"
outdir="/g/data/ia39/aus-ref-clim-data-nci/mswep/data/$freq"

if [ -d "$outdir" ]; then
    echo "Directory $outdir exists."
else
    echo "Directory $outdir does not exist. Creating now..."
    mkdir -p "$outdir" || { echo "Failed to create directory $outdir" >&2; exit 1; }
fi

if [ "$freq" == "day" ]; then
    chunk=366
elif [ "$freq" == "mon" ]; then
    chunk=12
else
    chunk=248
fi

for year in {1979..2020}
do
    echo "Processing year: $year at freq: $freq"
        
    f_in=$root_dir/$year*.nc
    f_tmp=$outdir/tmp_$year.nc
    f_out=$outdir/mswep_v280_${freq}_${year}.nc

    if [ -f "$f_out" ]; then
        echo "$f_out exists already, deleting"
        rm $f_out
    else
        echo "File doesn't exist, proceeding"
    fi

    # Concatenate all files from a year together, save as a tmp.nc file
    cdo --silent --no_history -L -s -f nc4c -z zip_4 cat $f_in $f_tmp
    # Re-chunk the tmp.nc file
    echo "Concatenating complete, now re-chunking...."
    ncks --cnk_dmn time,$chunk --cnk_dmn lat,600 --cnk_dmn lon,600 $f_tmp $f_out
    rm $f_tmp
    # rewrite history attribute
    hist="downloaded original files from 
        https://www.gloh2o.org/mswep/
        Using cdo to concatenate files, and nco to modify chunks: 
        cdo --silent --no_history -L -s -f nc4c -z zip_4 cat $f_in $f_tmp
        ncks --cnk_dmn time,$chunk --cnk_dmn lat,600 --cnk_dmn lon,600 $f_tmp $f_out"
    # Add what we've done into the history attribute in the file. 
    ncatted -h -O -a history,global,o,c,"$hist" ${f_out}

done