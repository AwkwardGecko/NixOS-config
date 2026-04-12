#!/usr/bin/env bash
mpc -q clear
mpc -q load global
mpc -q shuffle
mpc -q play
mpc status
