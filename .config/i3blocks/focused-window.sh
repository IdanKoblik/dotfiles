#!/bin/bash

focused_window=$(xdotool getwindowfocus getwindowname)
if [[ -n "$focused_window" ]]; then
  echo "$focused_window"
  echo "$focused_window"
  echo "#A0393D"
else
  echo "No window"
  echo "No window"
  echo "#FFFFFF"
fi

