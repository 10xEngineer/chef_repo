#!/usr/bin/env bash

/usr/bin/env ssh -A -o "StrictHostKeyChecking=no" -i "/home/manage_app/.ssh/deploy_key" $1 $2