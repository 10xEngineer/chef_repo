#!/usr/bin/env bash

/usr/bin/env ssh -A -o "StrictHostKeyChecking=no" -i "/home/labsys/.ssh/labs_deploy" $1 $2