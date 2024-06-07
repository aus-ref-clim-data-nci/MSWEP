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
#This script is to download the mswep using rclone from a google drive hosted by https://www.gloh2o.org.
#
#Date created: 06-06-2024

# The frequency to download:
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

dir="/g/data/ia39/aus-ref-clim-data-nci/mswep/data/$freq/tmp/"

if [ "$freq" == "day" ]; then
    rclone sync -v --drive-shared-with-me GoogleDrive:/MSWEP_V280/Past/Daily/ ./

if [ "$freq" == "mon" ]; then
    rclone sync -v --drive-shared-with-me GoogleDrive:/MSWEP_V280/Past/Monthly/ ./

if [ "$freq" == "3hr" ]; then
    rclone sync -v --drive-shared-with-me GoogleDrive:/MSWEP_V280/Past/3hourly/ ./
