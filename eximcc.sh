#!/bin/bash

cd /var/spool/exim/db && rm -f retry retry.lockfile && rm -f wait-remote_smtp wait-remote_smtp.lockfile && service exim restart && pwd

