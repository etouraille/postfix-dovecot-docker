#!/bin/bash
user=$1
password=$2
adduser --gecos "" --disabled-password $user
chpasswd <<<"$user:$password"
service dovecot restart