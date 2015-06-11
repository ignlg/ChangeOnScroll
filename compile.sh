#!/bin/sh

coffee --compile --bare --no-header jquery-changeonscroll.coffee
uglify --source jquery-changeonscroll.js --output jquery-changeonscroll.min.js
