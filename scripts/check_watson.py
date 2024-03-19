#!/bin/env python

import os
import json
from datetime import datetime
from plyer import notification

# Send a notification when the user has been working on this project for this
# amount of minutes
PROJECT_TIMEOUT_MINUTES = 60

# Don't resend a notification that has been sent less than this amount of
# minutes ago
NOTIFICATION_TIMEOUT_MINUTES = 15

# Where the log is saved
NOTIFICATION_LOG_FILE = "/home/robbe/.check_watson_notification_log"

def get_current_project():
    with open("/home/robbe/.config/watson/state") as f:
        current = json.load(f)
    if current == {}:
        return None
    return current

def is_working_hours():
    return (
        (datetime.now().weekday() in range(0, 5)) and (
            datetime.now().hour in range(9, 13) or
            datetime.now().hour in range(13, 18)
        )
    )

def get_last_message():
    if not os.path.exists(NOTIFICATION_LOG_FILE):
        return None, 0

    with open(NOTIFICATION_LOG_FILE, "r") as f:
        lines = list(f)
        if len(lines) == 0:
            return None, 0

        last_message = lines[-1]
        last_message_split = last_message.split(": ", 1)
        if len(last_message_split) != 2:
            return None, 0

        return last_message_split[1].strip(), float(last_message_split[0])

def notify(value):
    message, timestamp = get_last_message()
    last_notification_ago = datetime.now().timestamp() - timestamp

    if message == value and last_notification_ago < NOTIFICATION_TIMEOUT_MINUTES * 60:
        return

    with open(NOTIFICATION_LOG_FILE, "a") as f:
        f.write(f"{datetime.now().timestamp()}: {value}\n")

    notification.notify(
        title='Watson Time Check',
        message=value,
        app_name='watson_check.py',
        timeout=10,
        app_icon="/home/robbe/Pictures/Watson.png"
    )

def main():
    curr_project = get_current_project()
    if is_working_hours():
        if curr_project is None:
            notify("Are you sure you are not working on anything?")
        else:
            time_spent = datetime.now().timestamp() - int(curr_project["start"])
            if time_spent > PROJECT_TIMEOUT_MINUTES * 60:
                notify(f"Are you still working on {curr_project['project']}?")
    else:
        if curr_project is not None:
            notify(f"Are you still working on {curr_project['project']}?")

if __name__ == "__main__":
    main()
