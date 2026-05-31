#!/bin/sh

if command -v xbps-remove >/dev/null; then
  xbps-remove -O
fi
