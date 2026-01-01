#!/usr/bin/env fish

# vscode is the preferred editor for ib111 exams
if which code >/dev/null 2>/dev/null
  set editor code
else if which codium >/dev/null 2>/dev/null
  set editor codium
else
  set editor $EDITOR
end

set path $(find . -regextype egrep -regex "\.\/(([0-1][1-9])|10)\/(p|v|r)[0-6]_.*" | shuf -n 1)
echo 🐱 Picking $path
if not timeout 5 python $path >/dev/null 2>/dev/null
  if cat $path | grep "†" >/dev/null
    echo 🐈️ Too difficult. Rerunning.
    exec fish (status filename)
  else
    echo 😺 Chosen $path
    exec $editor $path
    cd $(dirname $path)
  end
else
  echo 😼 Already done. Rerunning.
  exec fish (status filename)
end

