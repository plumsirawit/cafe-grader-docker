#!/bin/bash
while true; do
  source /cafe_grader/judge/scripts/grader-process-check 2&>1 > /dev/null
  sleep 5
done

