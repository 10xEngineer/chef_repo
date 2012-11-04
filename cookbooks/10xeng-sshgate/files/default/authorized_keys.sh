#!/bin/sh

PROXY_USER=$1

curl "http://api.eu-1-aws.10xlabs.net/v1/proxy_users/${PROXY_USER}?token=MnMFqjHo368Pmf2R" -H "Accept: text/plain"