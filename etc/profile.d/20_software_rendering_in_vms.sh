#!/bin/sh

## Copyright (C) 2020 - 2026 ENCRYPTED SUPPORT LLC <adrelanos@whonix.org>
## See the file COPYING for copying conditions.

## style-ok: no-strict - sourced-only login-shell fragment.

## Force the softwarecontext QML renderer when GL is software-rendered
## (avoids GL crashes: Monero, signal-desktop; hurts shotcut, kdenlive).
## https://www.kicksecure.com/wiki/Tuning#Renderer
##
## helper-scripts detect-software-rendering prints
## software/accelerated/unknown. Set QMLSCENE_DEVICE only if unset (user choice
## wins) and only on 'software'; accelerated/unknown -> leave unset (err toward
## acceleration available).

if ! has detect-software-rendering >/dev/null 2>/dev/null; then
  true "${0}: INFO: detect-software-rendering does not exist."
  return 0
  exit 0
fi

if [ -z "${QMLSCENE_DEVICE}" ]; then
  true "${0}: INFO: QMLSCENE_DEVICE already set to: ${QMLSCENE_DEVICE}"
  return 0
  exit 0
fi

if [ ! "$(detect-software-rendering 2>/dev/null)" = "software" ]; then
  true "${0}: INFO: detect-software-rendering did not detect software rendering, ok, continuing..."
  return 0
  exit 0
fi

export QMLSCENE_DEVICE=softwarecontext
