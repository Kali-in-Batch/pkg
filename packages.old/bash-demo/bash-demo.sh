#!/bin/bash

hello="Hello, "
world="World!"

echo $hello $world

echo "This is a demonstration of basic bash scripting."
sleep 1
echo "Math:"
echo "1 + 1 = $((1 + 1))"
sleep 1
echo "2 * 2 = $((2 * 2))"
sleep 1
echo "10 / 2 = $((10 / 2))"
sleep 1
echo "Loop:"
sleep 1
count=0
while [ $count -lt 10 ]
do
    count=$((count + 1))
    echo $count
    sleep 0.5
done