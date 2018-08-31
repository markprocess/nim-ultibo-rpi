program UltiboProgram;
{$mode delphi}

uses 
{$ifdef BUILD_QEMUVPB} QEMUVersatilePB, VersatilePb, {$endif}
{$ifdef BUILD_RPI    } BCM2708,BCM2835,              {$endif}
{$ifdef BUILD_RPI2   } BCM2709,BCM2836,              {$endif}
{$ifdef BUILD_RPI3   } BCM2710,BCM2837,              {$endif}
GlobalConfig,GlobalConst,GlobalTypes,Platform,Threads,SysUtils,Classes,Ultibo,
FileSystem,MMC,FATFS;

procedure NimMain; cdecl; external 'libnimmain' name 'nimMain';

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

 begin
  if BoardGetType <> BOARD_TYPE_QEMUVPB then
   begin
    while not DirectoryExists('C:\') do
     sleep(100);
    if FileExists('default-config.txt') then
     CopyFile('default-config.txt','config.txt',False);
   end;

  NimMain;
  ThreadHalt(0);

 end.
