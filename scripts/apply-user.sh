#!/usr/bin/env bash
set -euo pipefail

cd "$(readlink -f "$(dirname "$(readlink -f "$0")")/..")"

nix build .#homeConfigurations."$(nix eval --impure --raw --expr 'builtins.currentSystem')".hackson.activationPackage
./result/activate

#home-manager switch -f hackson-home.nix