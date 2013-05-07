#!/bin/bash

eth=eth0
tc qdisc del dev $eth root 2>/dev/null
tc -batch << EOF
qdisc add dev $eth root handle 1: prio bands 3
qdisc add dev $eth parent 1:1 handle 11: fq_codel
qdisc add dev $eth parent 1:2 handle 12: fq_codel
qdisc add dev $eth parent 1:3 handle 13: fq_codel
EOF
