#!/bin/bash
PATH=/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin:~/bin:/opt/homebrew/bin
export PATH

curPath=`pwd`
rootPath=$(dirname "$curPath")
rootPath=$(dirname "$rootPath")
rootPath=$(dirname "$rootPath")
rootPath=$(dirname "$rootPath")

# echo $rootPath

SERVER_ROOT=$rootPath/lib
SOURCE_ROOT=$rootPath/source/lib
FREETYPE_VERSION=2.7.1
FREETYPE_FILE=freetype-${FREETYPE_VERSION}.tar.bz2
FREETYPE_SHA256=3a3bb2c4e15ffb433f2032f50a5b5a92558206822e22bfe8cbe339af4aa82f88
FREETYPE_URL=https://download.savannah.gnu.org/releases/freetype/${FREETYPE_FILE}

if [ ! -d ${SERVER_ROOT}/freetype_old ];then
    cd "$SOURCE_ROOT" || exit 1

    if [ ! -f "$SOURCE_ROOT/$FREETYPE_FILE" ];then
        wget -O "$FREETYPE_FILE" "$FREETYPE_URL" -T 5
    fi

    echo "${FREETYPE_SHA256}  ${FREETYPE_FILE}" | sha256sum -c - || exit 1

    if [ ! -d "$SOURCE_ROOT/freetype-${FREETYPE_VERSION}" ];then
        tar jxvf "$FREETYPE_FILE"
        cd "freetype-${FREETYPE_VERSION}"
    else
        cd "freetype-${FREETYPE_VERSION}"
    fi
    
    ./configure --prefix=${SERVER_ROOT}/freetype_old && make && make install
    cd $SOURCE_ROOT && rm -rf freetype-2.7.1
    cd $SOURCE_ROOT && rm -rf $SOURCE_ROOT/freetype-2.7.1
    #rm -rf freetype-2.7.1.tar.gz
fi
