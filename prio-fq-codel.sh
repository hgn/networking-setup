#!/bin/bash

if [ $# -eq 0 ]
then
	echo "Usage $0 <dev>"
	exit
fi

tc qdisc del dev $1 root 2>/dev/null
tc -batch << EOF
qdisc add dev $1 root handle 1: prio bands 3
qdisc add dev $1 parent 1:1 handle 11: fq_codel
qdisc add dev $1 parent 1:2 handle 12: fq_codel
qdisc add dev $1 parent 1:3 handle 13: fq_codel
EOF
