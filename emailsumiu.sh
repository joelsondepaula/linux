#!/bin/bash

mailaccount=${1}

doveadm force-resync -u $mailaccount INBOX