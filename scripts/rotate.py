#!/usr/bin/env python

from time import sleep
from os import path as op
import sys
from subprocess import check_call, check_output
from glob import glob

def is_in_tablet_mode():
    with open("/sys/devices/platform/thinkpad_acpi/hotkey_tablet_mode", "r") as f:
        value = f.read().strip()
        return value == "1"

def bdopen(fname):
    return open(op.join(basedir, fname))


def read(fname):
    return bdopen(fname).read()


for basedir in glob('/sys/bus/iio/devices/iio:device*'):
    if 'accel' in read('name'):
        break
else:
    sys.stderr.write("Can't find an accellerator device!\n")
    sys.exit(1)


devices = check_output(['xinput', '--list', '--name-only']).decode().splitlines()

touchscreen_names = ['touchscreen', 'wacom']
touchscreens = [i for i in devices if any(j in i.lower() for j in touchscreen_names)]

disable_touchpads = False

touchpad_names = ['touchpad', 'trackpoint']
touchpads = [i for i in devices if any(j in i.lower() for j in touchpad_names)]

scale = float(read('in_accel_scale'))

g = 7.0  # (m^2 / s) sensibility, gravity trigger

STATES = [
    {'rot': 'normal', 'coord': '1 0 0 0 1 0 0 0 1', 'touchpad': 'enable',
     'check': lambda x, y: y <= -g},
    {'rot': 'inverted', 'coord': '-1 0 1 0 -1 1 0 0 1', 'touchpad': 'disable',
     'check': lambda x, y: y >= g},
    {'rot': 'left', 'coord': '0 -1 1 1 0 0 0 0 1', 'touchpad': 'disable',
     'check': lambda x, y: x >= g},
    {'rot': 'right', 'coord': '0 1 0 -1 0 1 0 0 1', 'touchpad': 'disable',
     'check': lambda x, y: x <= -g},
]


def rotate(state):
    s = STATES[state]
    check_call(['xrandr', '-o', s['rot']])
    for dev in touchscreens if disable_touchpads else (touchscreens + touchpads):
        check_call([
            'xinput', 'set-prop', dev,
            'Coordinate Transformation Matrix',
        ] + s['coord'].split())
    if disable_touchpads:
        for dev in touchpads:
            check_call(['xinput', s['touchpad'], dev])


def read_accel(fp):
    fp.seek(0)
    return float(fp.read()) * scale


if __name__ == '__main__':

    accel_x = bdopen('in_accel_x_raw')
    accel_y = bdopen('in_accel_y_raw')

    current_state = None

    while True:
        if is_in_tablet_mode():
            x = read_accel(accel_x)
            y = read_accel(accel_y)
            for i in range(4):
                if i == current_state:
                    continue
                if STATES[i]['check'](x, y):
                    current_state = i
                    rotate(i)
                    break
        elif current_state != 0:
            rotate(0)
        sleep(1)
