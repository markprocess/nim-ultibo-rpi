
proc get_tick_count: cint {.importc.}
proc activity_led_enable {.importc.}
proc activity_led_on {.importc.}
proc activity_led_off {.importc.}

proc nimMain {.exportc.} =
  var state = 0
  var now = 0
  activity_led_enable()
  while true:
    now = get_tick_count()
    let newState = if now mod 1000 < 100: 1 else: 0
    if state != newState:
      state = newState
      if state == 1:
        activity_led_on()
      else:
        activity_led_off()
