#!/bin/bash -ue

has() {
  which $1 > /dev/null 2>&1
}
