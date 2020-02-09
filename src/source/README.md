
[[TOC]]

# Graphics

https://developer.garmin.com/downloads/connect-iq/monkey-c/doc/Toybox/Graphics.html
https://developer.garmin.com/downloads/connect-iq/monkey-c/doc/Toybox/Graphics/Dc.html

## Fonts

FONT_XTINY: Extra tiny Connect IQ font
FONT_TINY: Tiny Connect IQ font
FONT_SMALL: Small Connect IQ font
FONT_MEDIUM: Medium Connect IQ font
FONT_LARGE: Large Connect IQ font
FONT_NUMBER_MILD: Normal size number only Connect IQ font
FONT_NUMBER_MEDIUM: Medium size number only Connect IQ font
FONT_NUMBER_HOT: Large size number only Connect IQ font
FONT_NUMBER_THAI_HOT: Huge size number only Connect IQ font
FONT_SYSTEM_XTINY: Extra tiny system font
FONT_SYSTEM_TINY: Tiny system font
FONT_SYSTEM_SMALL: Small system font
FONT_SYSTEM_MEDIUM: Medium system font
FONT_SYSTEM_LARGE: Large system font
FONT_SYSTEM_NUMBER_MILD: Normal size number only system font
FONT_SYSTEM_NUMBER_MEDIUM: Medium size number only system font
FONT_SYSTEM_NUMBER_HOT: Large size number only system font
FONT_SYSTEM_NUMBER_THAI_HOT: Huge size number only system font

## Colors

COLOR_WHITE = 0xFFFFFF
COLOR_LT_GRAY = 0xAAAAAA
COLOR_DK_GRAY = 0x555555
COLOR_BLACK = 0x000000
COLOR_RED = 0xFF0000
COLOR_DK_RED = 0xAA0000
COLOR_ORANGE = 0xFF5500
COLOR_YELLOW = 0xFFAA00
COLOR_GREEN = 0x00FF00
COLOR_DK_GREEN = 0x00AA00
COLOR_BLUE = 0x00AAFF
COLOR_DK_BLUE = 0x0000FF
COLOR_PURPLE = 0xAA00FF
COLOR_PINK = 0xFF00FF
COLOR_TRANSPARENT = -1

## Justification

TEXT_JUSTIFY_RIGHT: Right justify the text at the x/y coordinates
TEXT_JUSTIFY_CENTER: Center justify the text at the x/y coordinates
TEXT_JUSTIFY_LEFT: Left justify the text at the x/y coordinates
TEXT_JUSTIFY_VCENTER: Center the text vertically

# System

https://developer.garmin.com/downloads/connect-iq/monkey-c/doc/Toybox/System.html
https://developer.garmin.com/downloads/connect-iq/monkey-c/doc/Toybox/System/DeviceSettings.html

System.getDeviceSettings().is24Hour
System.getDeviceSettings().phoneConnected
System.getDeviceSettings().doNotDisturb

System.getClockTime().hour.format("%02d");
System.getSystemStats().battery
System.getDeviceSettings().notificationCount

# Time

Time.Gregorian.info(Time.now(), Time.FORMAT_LONG).day_of_week.substring(0,2)

# ActivityMonitor

ActivityMonitor.getInfo().steps
ActivityMonitor.getInfo().calories
ActivityMonitor.getInfo().distance

# WatchUi

WatchUi.requestUpdate(): Request a call to the onUpdate() method for the current View.

# Activity

Activity.getActivityInfo().altitude
