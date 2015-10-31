#!/bin/bash

for i in `ps -ef |grep -E "python|go" | awk -F" " '{print $2}'`
do
  echo $i
  kill $i
done
