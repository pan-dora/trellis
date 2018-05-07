#!/bin/sh

/usr/bin/nghttpx --conf /etc/nghttpx/nghttpx.conf "$KEY_FILE" "$CERT_FILE"

### Keep PID1 alive with tail
tail -f /dev/null