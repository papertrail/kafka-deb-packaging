#!/bin/bash
set -e
set -u
name=kafka
rersion=0.11.0.2
scala_version=2.11
description="Apache Kafka is a distributed publish-subscribe messaging system."
url="https://kafka.apache.org/"
arch="all"
section="misc"
license="Apache Software License 2.0"
package_version="-1"
src_package="kafka_${scala_version}-${version}.tgz"
download_url="http://mirror.cc.columbia.edu/pub/software/apache/kafka/${version}/${src_package}"
origdir="$(pwd)"

DISTRIB_CODENAME=""
if [ -e /etc/lsb-release ]; then
  source /etc/lsb-release
fi

case "${1:-$DISTRIB_CODENAME}" in
  trusty)
    version_tag="~u1404"
    fpm_init_opts="--deb-upstart ../../../upstart/kafka-broker.conf"
  ;;
  xenial)
    version_tag="~u1604"
    fpm_init_opts="--deb-systemd ../../../systemd/kafka.service"
  ;;
  *)
    echo "Unrecognized host distribution or codename unspecified (try '$0 xenial' or '$0 trusty')!"
    exit 1
  ;;
esac

#_ MAIN _#
rm -rf ${name}*.deb
if [ ! -f "${src_package}" ]; then
  wget ${download_url}
fi
mkdir -p tmp && pushd tmp
rm -rf kafka
mkdir -p kafka
cd kafka
mkdir -p build/usr/lib/kafka
mkdir -p build/etc/default
mkdir -p build/etc/init
mkdir -p build/etc/kafka
mkdir -p build/var/log/kafka

tar zxf ${origdir}/${src_package}
cd kafka_${scala_version}-${version}
mv config/log4j.properties config/server.properties ../build/etc/kafka
mv * ../build/usr/lib/kafka
cd ../build

patch -p0 < ../../../kafka-server-start.sh.pidfile.patch

fpm -t deb \
    -n ${name} \
    -v ${version}${version_tag}${package_version} \
    --description "${description}" \
    --url="{$url}" \
    -a ${arch} \
    --category ${section} \
    --vendor "" \
    --license "${license}" \
    -m "${USER}@localhost" \
    --prefix=/ \
    ${fpm_init_opts} \
    -s dir \
    -- .
mv kafka*.deb ${origdir}
popd
