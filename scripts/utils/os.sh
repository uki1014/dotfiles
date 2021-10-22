#!/bin/bash -ue

is_darwin() {
  [ "$(uname -s)" == 'Darwin' ] > /dev/null 2>&1
}

is_linux() {
  [ "$(uname -s)" == 'Linux' ] > /dev/null 2>&1
}
