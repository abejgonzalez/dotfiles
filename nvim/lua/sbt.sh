#!/bin/bash

# Used by Scala metals (to use env. vars SBT/JAVA_OPTS)

set -ex

sbt  "$@"
