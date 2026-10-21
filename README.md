
# onesixtyone.nix

A Nix flake packaging [onesixtyone](https://github.com/trailofbits/onesixtyone),
the fast SNMP scanner by Trail of Bits.

## Usage

### Run directly

```bash
nix run github:dundorma/onesixtyone.nix -- --help
```

### Install in a NixOS configuration

Add the flake as an input:

```nix
{
  inputs.onesixtyone.url =
    "github:dundorma/onesixtyone.nix";
}
```

Then add the package to your system packages:

```nix
environment.systemPackages = [
  inputs.onesixtyone.packages.${pkgs.system}.default
];
```

### Install with Home Manager

```nix
home.packages = [
  inputs.onesixtyone.packages.${pkgs.system}.default
];
```
