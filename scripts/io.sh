#!/usr/bin/env sh

GREEN='\033[0;32m'
ORANGE='\033[0;33m'  # Using yellow as a substitute for orange
RED='\033[0;31m'
NC='\033[0m' # No color

print() {
  printf "  > $1\n"
}

info() {
  printf "[${GREEN}info${NC}] - $1\n"
}

warn() {
  printf "[${ORANGE}warning${NC}] - $1\n"
}

error() {
  printf "[${RED}error${NC}] - $1\n"
}

debug_stop() {
  print "Press enter to continue"
  read test
}

print "debug print"
