#proc panic(s: string) =
#  discard
#proc rawoutput(s: string) =
#  discard

proc printf(frmt: cstring) {.varargs, importc, header: "<stdio.h>", cdecl.}
proc exit(code: int) {.importc, header: "<stdlib.h>", cdecl.}

proc nimToCStringConv(s: NimString): cstring {.compilerProc, inline.} =
  if s == nil or s.len == 0: result = cstring""
  else: result = cstring(addr s.data)

{.push stack_trace: off, profiler:off.}

proc rawoutput(s: string) =
  printf("%s\n", s)

proc panic(s: string) {.noreturn.} =
  rawoutput(s)
  exit(1)

# Alternatively we also could implement these 2 here:
#
# proc sysFatal(exceptn: typeDesc, message: string) {.noReturn.}
# proc sysFatal(exceptn: typeDesc, message, arg: string) {.noReturn.}

{.pop.}
