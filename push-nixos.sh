#!/bin/sh
export PATH=/run/current-system/sw/bin:$PATH

cd /etc/nixos || exit 1

git config user.name "bagel"
git config user.email "bagel2255@protonmail.com"

git add .
git commit -m "Auto backup on $(date '+%Y-%m-%d %H:%M:%S')" || true

export GIT_SSH_COMMAND='ssh -i /root/.ssh/id_ed25519 -o IdentitiesOnly=yes'
git push origin main

