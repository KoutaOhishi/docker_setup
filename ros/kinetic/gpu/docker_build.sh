#!/bin/bash
docker build \
   --tag kinetic_gpu \
   --network host \
   . 
