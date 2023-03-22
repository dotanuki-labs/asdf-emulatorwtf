#!/usr/bin/env bash

set -euo pipefail

EW_CLI_DOWNLOADS="https://maven.emulator.wtf/releases/wtf/emulator/ew-cli"
TOOL_NAME="ew-cli"
TOOL_TEST="ew-cli --help"

fail() {
  echo -e "asdf-$TOOL_NAME: $*"
  exit 1
}

curl_opts=(-fsSL)

sort_versions() {
  sed 'h; s/[+-]/./g; s/.p\([[:digit:]]\)/.z\1/; s/$/.z/; G; s/\n/ /' |
    LC_ALL=C sort -t. -k 1,1 -k 2,2n -k 3,3n -k 4,4n -k 5,5n | awk '{print $2}'
}

list_all_versions() {
  local maven_index="$EW_CLI_DOWNLOADS/maven-metadata.xml"
  curl "${curl_opts[@]}" "$maven_index" | grep '<version>' | sed 's/<version>//g' | sed 's/<\/version>//g'
}

download_release() {
  local version download_url
  version="$1"

  # https://maven.emulator.wtf/releases/wtf/emulator/ew-cli/0.0.51/ew-cli-0.0.51.jar
  local download_url="$EW_CLI_DOWNLOADS/$version/ew-cli-$version.jar"

  echo "* Downloading $TOOL_NAME release $version..."
  echo
  curl "${curl_opts[@]}" -o "$ASDF_DOWNLOAD_PATH/ew-cli-$version.jar" -C - "$download_url" || fail "Could not download $url"
}

install_version() {
  local install_type="$1"
  local version="$2"
  local install_path="$3"

  if [ "$install_type" != "version" ]; then
    fail "asdf-$TOOL_NAME supports release installs only"
  fi

  (

    mkdir -p "$install_path/bin"

    # Creating a truly executable jar for ew-cli
    local bin_file="$install_path/bin/ew-cli"

    touch "$bin_file"
    echo "#!/bin/sh" >>"$bin_file"
    echo "" >>"$bin_file"
    echo "exec java -jar \$0 \"\$@\"" >>"$bin_file"

    echo "" >>"$bin_file"
    echo "" >>"$bin_file"
    echo "" >>"$bin_file"
    echo "" >>"$bin_file"

    cat "$ASDF_DOWNLOAD_PATH/ew-cli-$version.jar" >>"$bin_file"
    chmod +x "$bin_file"

    test -x "$bin_file" || fail "Expected $bin_file to be executable."

    rm "$ASDF_DOWNLOAD_PATH/ew-cli-$version.jar"
    echo "$TOOL_NAME $version installation was successful!"

  ) || (
    rm -rf "$install_path"
    fail "An error occurred while installing $TOOL_NAME $version."
  )
}
