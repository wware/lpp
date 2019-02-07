#!/bin/sh

HERE=.
if [ -f .lpprc ]; then . ./.lpprc; else
	if [ -f $HOME/.lpprc ]; then . $HOME/.lpprc; fi
fi
(cd $HERE; ./lpp < README.md) | grip -
