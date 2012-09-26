#!/usr/bin/env bash

identity_key=/mnt/sandbox/$(whoami)/.ssh/identity

if [ -f $identity_key ]; then
	/usr/bin/env ssh -i $identity_key -o "StrictHostKeyChecking=no" ${@}
else
	/usr/bin/env ssh -i $identity_key -o "StrictHostKeyChecking=no" ${@}
fi
