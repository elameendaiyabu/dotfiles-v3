#!/bin/bash

mode=$(echo supergfxctl -g)

case $mode in
	Hybrid)
		supergfxctl -m Integrated
		;;
	Integrated)
		supergfxctl -m Hybrid
		;;
esac


