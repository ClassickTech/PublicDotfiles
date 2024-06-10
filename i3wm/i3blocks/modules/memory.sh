#!/bin/sh

# Display used, free and total memory with the help of freecolor utility

total_mem="$(freecolor -m -o | head -n 2 | tail -n 1 | cut -c14-18)"
used_mem="$(freecolor -m -o | head -n 2 | tail -n 1 | cut -c24-29)"

if [ "${used_mem}" -lt "${total_mem}" ]; then
   echo "${used_mem}/${total_mem} MB"
   echo " "
fi