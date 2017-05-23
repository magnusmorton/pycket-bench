#! /bin/sh

PROGRAM=`echo $0 | sed 's%.*/%%'`
PROGDIR="$(cd `dirname $0`; echo $PWD)"

if [ ! -z "$ZSH_VERSION" ]; then
  setopt shwordsplit
fi
ECHO="/usr/bin/printf %b\\n"
if command -v wget >/dev/null 2>/dev/null; then
  FETCH="wget --quiet"
elif command -v curl >/dev/null 2>/dev/null; then
  FETCH="curl -L -s -S -O"
else
  FETCH="$ECHO Please download "
fi

_go() {
    _OLD=`echo $PWD`
    cd "$1"
}
_gone() {
    cd "$_OLD"
}

RACKET="`command -v python`"
if [ -z "$RACKET" ]; then
    $ECHO "Cannot find pyhton. Really?" 1>&2
    exit 1
fi

REBENCH="`command -v rebench`"
if [ -z "$REBENCH" ]; then
    $ECHO "installing ReBench"
    _go $PROGDIR
    pip install --user -r requirements.txt
    _gone
fi

RACKET="`command -v racket`"
if [ -z "$RACKET" ]; then
    $ECHO "Cannot find racket" 1>&2
    exit 1
fi

RACKET="`command -v pypy`"
if [ -z "$RACKET" ]; then
    $ECHO "Cannot find pypy" 1>&2
    exit 1
fi


if [ ! -f "$PROGDIR/ShootoutBenchmarks/fasta-1000000" ]; then
    $ECHO "generating input files for some Racket benchmarks"
    _go "$PROGDIR/ShootoutBenchmarks"
    racket gen-inputs.rkt
    gunzip ulysses.gz
    _gone
fi
