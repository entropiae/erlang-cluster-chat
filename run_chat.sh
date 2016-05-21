#!/usr/bin/env bash
erl -pa ebin  -eval 'chat:start_link()' -sname node"$1" -setcookie MY_SECRET_ERLANG_COOKIE
