
#proc ultiboProgramSystemRestart {.importc.}
proc ultiboProgramThreadYield {.importc.}
proc ultiboProgramPollHci05(c: ptr byte): bool {.importc.}
proc ultiboProgramSerialConsoleWriteChar(c: char) {.importc.}
#proc ultiboProgramSerialConsoleReadChar(c: var char):bool {.importc.}
#proc ultiboProgramGetFirmwareThrottled: cint {.importc.}
proc ultiboProgramGetTickCount: cint {.importc.}
proc ultiboProgramActivityLedEnable {.importc.}
proc ultiboProgramActivityLedOn {.importc.}
proc ultiboProgramActivityLedOff {.importc.}

proc write(c: char) =
  ultiboProgramSerialConsoleWriteChar c

proc write(s: string) =
  for c in s:
    write c

proc home =
  write("\x1b[H")

proc eraseEndOfLine =
  write("\x1b[K")

proc eraseDown =
  write("\x1b[J")

proc color(x: string) =
  write("\x1b[4")
  write(x)
  write("m")

proc writeln(s: string) =
  write(s)
  eraseEndOfLine()
  write "\x0a"

proc write(x: int) =
  if x < 10:
    write(char(int('0') + x))
  else:
    write(x div 10)
    write(x mod 10)
var
  bleBuffer: byte

proc nimMain {.exportc.} =
  var ledBlinkCounter = 0
  var bleByteCounter = 0
  const period = 1000
  home()
  eraseDown()
  ultiboProgramActivityLedEnable()
  while true:
    while not(ultiboProgramGetTickCount() mod period < period div 10):
      ultiboProgramThreadYield()
    ultiboProgramActivityLedOn()
    while ultiboProgramGetTickCount() mod period < period div 10:
      ultiboProgramThreadYield()
    ultiboProgramActivityLedOff()
    inc ledBlinkCounter
    while ultiboProgramPollHci05(addr bleBuffer):
      inc bleByteCounter
    home()
    if ledBlinkCounter mod 2 == 0:
      color "1"
    else:
      color "2"
    write "ledBlinkCounter "
    write ledBlinkCounter
    write " bleByteCounter "
    write bleByteCounter
    writeln ""
    eraseDown()
