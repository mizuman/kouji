#!/bin/sh

cd ${HOME}/hoge
#unicorn_rails -c config/unicorn.rb --path /announces -E development -D
unicorn_rails -c config/unicorn.rb --path /announces -E production -D
