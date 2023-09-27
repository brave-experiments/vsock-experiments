#!/bin/sh

sh -c 'while true; do top -b -n 1 -o %MEM | head -n 13; sleep 2; done' &
#sh -c 'while true; do cat /proc/meminfo; sleep 10; done' &
#sh -c 'while true; do slabtop -o; sleep 10; done' &
#sh -c 'while true; do cat /proc/meminfo; slabtop -o; echo "alloc calls:"; cat /sys/kernel/slab/kmalloc-4096/alloc_calls; echo "free calls:"; cat /sys/kernel/slab/kmalloc-4096/free_calls; echo 3 > /proc/sys/vm/drop_caches; sleep 10; done' &

vsock-experiment &

sleep infinity
