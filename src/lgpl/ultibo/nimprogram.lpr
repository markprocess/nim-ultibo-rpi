program NimProgram;
{$mode delphi}

uses 
{$ifdef BUILD_QEMUVPB} QEMUVersatilePB, VersatilePb, {$endif}
{$ifdef BUILD_RPI    } BCM2708,BCM2835,              {$endif}
{$ifdef BUILD_RPI2   } BCM2709,BCM2836,              {$endif}
{$ifdef BUILD_RPI3   } BCM2710,BCM2837,              {$endif}
GlobalConfig,GlobalConst,GlobalTypes,Platform,Threads,SysUtils,Classes,Console,Logging,Ultibo,Services,
Mouse,
FileSystem,MMC,FATFS,
HTTP,WebStatus,
DWCOTG,SMSC95XX,LAN78XX;

function get_tick_count:Integer; cdecl;
public name 'get_tick_count';
 begin
  Result:=GetTickCount;
 end;

 procedure activity_led_enable; cdecl;
public name 'activity_led_enable';
 begin
  ActivityLedEnable;
 end;

 procedure activity_led_on; cdecl;
public name 'activity_led_on';
 begin
  ActivityLedOn;
 end;

 procedure activity_led_off; cdecl;
public name 'activity_led_off';
 begin
  ActivityLedOff;
 end;

 var 
  NimMainThreadHandle:TThreadHandle = INVALID_HANDLE_VALUE;
  Console1,Console2,Console3:TWindowHandle;

 procedure Log(Message:String);
 begin
  LoggingOutput(Message);
 end;

 function TimeToString(Time:TDateTime):String;
 begin
  Result:=IntToStr(Trunc(Time)) + ' days ' + TimeToStr(Time);
 end;

 procedure NimMain; cdecl; external 'libnimmain' name 'nimMain';
 function NimMainThread(Parameter:Pointer):PtrInt;
 begin
  Result:=0;
  NimMain;
  ThreadHalt(0);
 end;

 procedure StartLogging;
 begin
  LOGGING_INCLUDE_COUNTER:=False;
  LOGGING_INCLUDE_TICKCOUNT:=True;
  CONSOLE_REGISTER_LOGGING:=True;
  CONSOLE_LOGGING_POSITION:=CONSOLE_POSITION_TOPRIGHT;
  LoggingConsoleDeviceAdd(ConsoleDeviceGetDefault);
  LoggingDeviceSetDefault(LoggingDeviceFindByType(LOGGING_TYPE_CONSOLE));
 end;

 begin
  if BoardGetType <> BOARD_TYPE_QEMUVPB then
   begin
    while not DirectoryExists('C:\') do
     sleep(100);
    if FileExists('default-config.txt') then
     CopyFile('default-config.txt','config.txt',False);
   end;

  StartLogging;
  Log('');
  Log('NimProgram started');

  Console1 := ConsoleWindowCreate(ConsoleDeviceGetDefault,CONSOLE_POSITION_TOPLEFT,True);
  Console2 := ConsoleWindowCreate(ConsoleDeviceGetDefault,CONSOLE_POSITION_BOTTOMLEFT,False);
  Console3 := ConsoleWindowCreate(ConsoleDeviceGetDefault,CONSOLE_POSITION_BOTTOMRIGHT,False);
  ConsoleWindowSetBackcolor(Console1,COLOR_BLACK);
  ConsoleWindowSetForecolor(Console1,COLOR_YELLOW);
  ConsoleWindowSetBackcolor(Console2,COLOR_CYAN);
  ConsoleWindowSetForecolor(Console3,COLOR_GREEN);
  ConsoleWindowClear(Console1);
  ConsoleWindowClear(Console2);
  ConsoleWindowClear(Console3);

  BeginThread(@NimMainThread,Nil,NimMainThreadHandle,THREAD_STACK_DEFAULT_SIZE);

  while True do
   begin
    Sleep(900);
    ConsoleWindowSetXY(Console1,1,1);
    ConsoleWindowWriteLn(Console1,'');
    ConsoleWindowWriteLn(Console1,Format('Up %s',[TimeToString(SystemFileTimeToDateTime(UpTime))]));
   end;
 end.
