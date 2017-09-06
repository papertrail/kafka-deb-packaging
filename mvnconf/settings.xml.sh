#!/bin/bash

REPO_LOC=$1
SET_LOC=$2

cat > $SET_LOC <<EOXML
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
          xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
          xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">
  <!-- Maven is ☠☢©☭€∞☠ garbage, if it doesn't have its
  local repository it throws a tantrum and dies, whether it needs the
  damn thing or not for the requested operation. -->
  <localRepository>${REPO_LOC}</localRepository>
  <pluginGroups>
  </pluginGroups>
  <proxies>
  </proxies>
  <servers>
  </servers>
  <mirrors>
  </mirrors>
  <profiles>
  </profiles>
</settings>
EOXML
