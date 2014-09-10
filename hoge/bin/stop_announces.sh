#!/bin/sh

cd ${HOME}/hoge
kill `cat tmp/pids/unicorn.pid`
