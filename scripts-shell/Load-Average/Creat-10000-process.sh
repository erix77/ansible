#!/bin/bash

for i in $(seq 1 10000)
do
  ./Process.sh &
done
