#!/bin/bash

trigger1="has exceeded the max emails per hour"

zgrep "$trigger1" /var/log/exim_mainlog*