# Popcorn
An XCode tooling.

## Guide
Tooling is done via `./inferno`

### Setup
Run `./inferno setup` to bootstrap.

Setup script will sets up git hooks and swift-format via submodule.

### Format
Run `./inferno format` to format `Popcorn` in-place.
Run `./inferno sformat` to run internal swift-format.


## Configuration

### Formatter
`Tooling/formatter.json` is the default config file for `format` command. 
[documentation](https://github.com/apple/swift-format/blob/swift-5.1-branch/Documentation/Configuration.md)

