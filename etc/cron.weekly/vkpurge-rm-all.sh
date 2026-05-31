#!/bin/sh

if command -v vkpurge >/dev/null; then
  vkpurge rm all
fi
