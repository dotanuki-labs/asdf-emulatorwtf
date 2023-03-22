# asdf-emulatorwtf

[![CI](https://github.com/dotanuki-labs/asdf-emulatorwtf/actions/workflows/ci.yml/badge.svg)](https://github.com/dotanuki-labs/asdf-emulatorwtf/actions/workflows/ci.yml)
[![Code Style](https://img.shields.io/badge/code%20style-%E2%9D%A4-FF4081.svg)](https://shellcheck.net/)
[![License](https://img.shields.io/github/license/dotanuki-labs/asdf-emulatorwtf)](https://choosealicense.com/licenses/mit)


A [ew-cli](https://docs.emulator.wtf/integrations/cli/) plugin for [asdf](https://github.com/asdf-vm/asdf).


## Installing

Installing this plugin:

```bash
$> asdf plugin add ew-cli https://github.com/dotanuki-labs/asdf-emulatorwtf.git
```

## Using

Managing `ew-cli` with `asdf`:

```bash

# Show all installable versions
$> asdf list-all ew-cli

# Download the latest version
$> asdf install ew-cli latest

# Define the latest version for your local project (writes <project>/.tool-versions)
$> asdf local ew-cli latest

# Now ew-cli commands are available
$> ew-cli --help

```

You may also want to check the [official documentation](https://asdf-vm.com/) to learn more about `asdf`.

## License

Copyright (c) 2023 - Dotanuki Labs - [The MIT license](https://choosealicense.com/licenses/mit/)

