#!/bin/sh

cp nixos/configuration.nix nixos/flake.nix /etc/nixos

nixos-rebuild $1
