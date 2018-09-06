program UltiboProgram;
{$mode delphi}

uses 
{$ifdef BUILD_QEMUVPB} VersatilePB,QEMUVersatilePB2,        {$endif}
{$ifdef BUILD_RPI    } BCM2708,BCM2835,                     {$endif}
{$ifdef BUILD_RPI2   } BCM2709,BCM2836,                     {$endif}
{$ifdef BUILD_RPI3   } BCM2710,BCM2837,                     {$endif}
GlobalConfig,GlobalConst,GlobalTypes,Platform,Threads,SysUtils,Classes,Ultibo,
FileSystem,MMC,FATFS,
Serial,bcmfw;

var 
 BluetoothUartDeviceDescription:String;
 HciSequenceNumber:Integer = 0;
 UART0:PSerialDevice = Nil;
 LastDeviceStatus:LongWord;
 BcmFirmwareIndex:Integer;
 BtAddr:Array[0 .. 5] of Byte;

procedure NimMain; cdecl; external 'libnimmain' name 'nimMain';

procedure ultiboProgramSystemRestart(N: LongWord) cdecl;
public name 'ultiboProgramSystemRestart';
 begin
  SystemRestart(N);
 end;

 procedure ultiboProgramSerialConsoleWriteChar(C:Char) cdecl;
public name 'ultiboProgramSerialConsoleWriteChar';
 begin
  {$ifdef BUILD_QEMUVPB}
  PLongWord(VERSATILEPB_UART0_REGS_BASE)^ := Ord(C);
  {$endif}
 end;

 function ultiboProgramPollHci05(Buffer:PByte):Boolean; cdecl;
public name 'ultiboProgramPollHci05';
 var 
  Status:LongWord;
  Count:LongWord;
  B:Byte;
 begin
  Status:=SerialDeviceRead(UART0,@B,1,SERIAL_READ_NON_BLOCK,Count);
  Buffer^:=B;
  Result:=(Status = ERROR_SUCCESS) and (Count = 1);
 end;

 function ultiboProgramGetFirmwareThrottled:Integer; cdecl;
public name 'ultiboProgramGetFirmwareThrottled';
 begin
  Result:=FirmwareGetThrottled;
 end;

 function ultiboProgramGetTickCount:Integer; cdecl;
public name 'ultiboProgramGetTickCount';
 begin
  Result:=GetTickCount;
 end;

 procedure ultiboProgramThreadYield; cdecl;
public name 'ultiboProgramThreadYield';
 begin
  ThreadYield;
 end;

 procedure ultiboProgramActivityLedEnable; cdecl;
public name 'ultiboProgramActivityLedEnable';
 begin
  ActivityLedEnable;
 end;

 procedure ultiboProgramActivityLedOn; cdecl;
public name 'ultiboProgramActivityLedOn';
 begin
  ActivityLedOn;
 end;

 procedure ultiboProgramActivityLedOff; cdecl;
public name 'ultiboProgramActivityLedOff';
 begin
  ActivityLedOff;
 end;

 const 
  ScanUnitsPerSecond          = 1600;
  ScanInterval                = 1.000;
  ScanWindow                  = 0.250;

  HCI_COMMAND_PKT             = $01;
  HCI_EVENT_PKT               = $04;
  OGF_HOST_CONTROL            = $03;
  OGF_INFORMATIONAL           = $04;
  OGF_LE_CONTROL              = $08;
  OGF_VENDOR                  = $3f;
  LL_SCAN_PASSIVE             = $00;
  LL_SCAN_ACTIVE              = $01;
 procedure SerialMessage(S:String);
 var 
  I:Integer;
 begin
  for I:=Low(S) to High(S) do
   ultiboProgramSerialConsoleWriteChar(S[I]);
  ultiboProgramSerialConsoleWriteChar(Char(10));
 end;

 procedure Log(S:String);
 begin
  //LoggingOutput(S);
  SerialMessage(S);
 end;

 function FindUart(Dev:PSerialDevice;Data:Pointer):LongWord;
 begin
  Result:=0;
  Log(Dev.Device.DeviceDescription);
 end;

 function IsBlueToothAvailable:Boolean;
 begin
  Result:=True;
  Log(Format('%s',[BoardTypeToString(BoardGetType)]));
  case BoardGetType of 
   BOARD_TYPE_QEMUVPB:
                      begin
                       BluetoothUartDeviceDescription:='ARM PrimeCell PL011 UART (UART1)';
                       BcmFirmwareIndex:=1;
                      end;
   BOARD_TYPE_RPI3B:
                    begin
                     BluetoothUartDeviceDescription:='BCM2837 PL011 UART';
                     BcmFirmwareIndex:=0;
                    end;
   BOARD_TYPE_RPI3B_PLUS:
                         begin
                          BluetoothUartDeviceDescription:='BCM2837 PL011 UART';
                          BcmFirmwareIndex:=1;
                         end;
   BOARD_TYPE_RPI_ZERO_W:
                         begin
                          BluetoothUartDeviceDescription:='BCM2835 PL011 UART';
                          BcmFirmwareIndex:=0;
                         end;
   else
    begin
     Log('');
     Log('');
     Log('Bluetooth is not available on this board');
     Result:=False;
    end;
  end;
 end;

 function OpenUART0:boolean;
 var 
  res:LongWord;
 begin
  Result:=False;
  //  Log('open hc05 uart ...');
  UART0:=SerialDeviceFindByDescription(BluetoothUartDeviceDescription);
  if UART0 = nil then
   begin
    Log(Format('Cannot find %s',[BluetoothUartDeviceDescription]));
    exit;
   end;
  if BoardGetType = BOARD_TYPE_RPI_ZERO_W then
   res:=SerialDeviceOpen(UART0,115200,SERIAL_DATA_8BIT,SERIAL_STOP_1BIT,SERIAL_PARITY_NONE,SERIAL_FLOW_RTS_CTS,0,0)
  else
   res:=SerialDeviceOpen(UART0,115200,SERIAL_DATA_8BIT,SERIAL_STOP_1BIT,SERIAL_PARITY_NONE,SERIAL_FLOW_NONE,0,0);
  if res = ERROR_SUCCESS then
   begin
    Result:=True;
    //    Log('open hc05 uart done');
    LastDeviceStatus:=0;

    if BoardGetType <> BOARD_TYPE_QEMUVPB then
     begin
      GPIOFunctionSelect(GPIO_PIN_14,GPIO_FUNCTION_IN);
      GPIOFunctionSelect(GPIO_PIN_15,GPIO_FUNCTION_IN);

      GPIOFunctionSelect(GPIO_PIN_32,GPIO_FUNCTION_ALT3);     // TXD0
      GPIOFunctionSelect(GPIO_PIN_33,GPIO_FUNCTION_ALT3);     // RXD0
      GPIOPullSelect(GPIO_PIN_32,GPIO_PULL_NONE);             //Added
      GPIOPullSelect(GPIO_PIN_33,GPIO_PULL_UP);               //Added

      if BoardGetType = BOARD_TYPE_RPI_ZERO_W then
       begin
        GPIOFunctionSelect(GPIO_PIN_30,GPIO_FUNCTION_ALT3);     // RTS
        GPIOFunctionSelect(GPIO_PIN_31,GPIO_FUNCTION_ALT3);     // CTS
        GPIOPullSelect(GPIO_PIN_30,GPIO_PULL_UP);
        GPIOPullSelect(GPIO_PIN_31,GPIO_PULL_NONE);
       end;
     end;

    Sleep(50);
   end
  else
   Log(Format('open hc05 uart error %d',[res]));
 end;

 procedure CloseUART0;
 begin
  SerialDeviceClose(UART0);
  UART0:=Nil;
 end;

 procedure Fail(Message:String);
 begin
  raise Exception.Create(Message);
 end;

 function ReadByte:Byte;
 var 
  c:LongWord;
  b:Byte;
  res:Integer;
  EntryTime:LongWord;
  SerialStatus:LongWord;
 begin
  Result:=0;
  EntryTime:=ClockGetCount;
  while LongWord(ClockGetCount - EntryTime) < 5*1000*1000 do
   begin
    c:=0;
    res:=SerialDeviceRead(UART0,@b,1,SERIAL_READ_NON_BLOCK,c);
    if (res = ERROR_SUCCESS) and (c = 1) then
     begin
      Result:=b;
      res:=SerialDeviceRead(UART0,@b,1,SERIAL_READ_PEEK_BUFFER,c);
      SerialStatus:=SerialDeviceStatus(UART0);
      SerialStatus:=SerialStatus and not (SERIAL_STATUS_RX_EMPTY or SERIAL_STATUS_TX_EMPTY);
      if SerialStatus <> LastDeviceStatus then
       begin
        LastDeviceStatus:=SerialStatus;
        Log(Format('SerialDeviceStatus changed %08.8x',[SerialStatus]));
       end;
      exit;
     end
    else
     ThreadYield;
   end;
  Fail('timeout waiting for serial read byte');
 end;

 procedure HciCommand(OpCode:Word; Params:array of byte); overload;
 var 
  i:integer;
  Cmd:Array of Byte;
  Event:Array of Byte;
  res,count:LongWord;
  PacketType,EventCode,PacketLength,CanAcceptPackets,Status:Byte;
  Acknowledged:Boolean;
 begin
  Inc(HciSequenceNumber);
  //if OpCode <> $fc4c then
  // Log(Format('hci %d op %04.4x',[HciSequenceNumber,OpCode]));
  SetLength(Cmd,length(Params) + 4);
  Cmd[0]:=HCI_COMMAND_PKT;
  Cmd[1]:=lo(OpCode);
  Cmd[2]:=hi(OpCode);
  Cmd[3]:=length(Params);
  for i:=0 to length(Params) - 1 do
   Cmd[4 + i]:=Params[i];
  count:=0;
  res:=SerialDeviceWrite(UART0,@Cmd[0],length(Cmd),SERIAL_WRITE_NONE,count);
  if res = ERROR_SUCCESS then
   begin
    Acknowledged:=False;
    while not Acknowledged do
     begin
      PacketType:=ReadByte;
      if PacketType <> HCI_EVENT_PKT then
       Fail(Format('event type not hci event: %d',[PacketType]));
      EventCode:=ReadByte;
      PacketLength:=ReadByte;
      SetLength(Event, PacketLength);
      for I:=0 to PacketLength - 1 do
       Event[I]:=ReadByte;
      if EventCode = $0E then
       begin
        //      if PacketLength <> 4 then
        //       Fail(Format('packet length not 4: %d',[PacketLength]));
        CanAcceptPackets:=Event[0];
        OpCode:=(Event[2] shl 8) or Event[1];
        Status:=Event[3];
        if (Status = 0) and (OpCode = $1009) and (PacketLength = 10) then
         begin
          for I:=0 to 5 do
           BtAddr[I]:=Event[4 + I];
         end;
        if CanAcceptPackets <> 1 then
         Fail(Format('can accept packets not 1: %d',[CanAcceptPackets]));
        Acknowledged:=True;
       end
      else if EventCode = $0F then
            begin
             if PacketLength <> 4 then
              Fail(Format('packet length not 4: %d',[PacketLength]));
             CanAcceptPackets:=Event[1];
             Status:=Event[0];
             if CanAcceptPackets <> 1 then
              Fail(Format('can accept packets not 1: %d',[CanAcceptPackets]));
             Acknowledged:=True;
            end
      else
       begin
        //Log(Format('HciCommand discarding event %d length %d',[EventCode,PacketLength]));
        //Log(Format('hci %d op %04.4x',[HciSequenceNumber,OpCode]));
        // Fail(Format('event code not command completed nor status: %02.2x',[EventCode]));
       end;
     end;
    if Status <> 0 then
     Fail(Format('status not 0: %d',[Status]));
   end
  else
   Log('Error writing to BT.');
 end;

 procedure HciCommand(OGF:byte; OCF:Word; Params:array of byte); overload;
 begin
  HciCommand((OGF shl 10) or OCF,Params);
 end;

 procedure ResetChip;
 begin
  HciCommand(OGF_HOST_CONTROL,$03,[]);
 end;

 procedure ReadAddress;
 var 
  I:Integer;
  S:String;
 begin
  HciCommand(OGF_INFORMATIONAL,$09,[]);
  S:='';
  for I:=Low(BtAddr) to High(BtAddr) do
   S:=S + Format('%02.2x',[BtAddr[I]]) + ':';
  Log(Format('bluetooth address %s',[S]));
 end;

 procedure BCMLoadFirmware;
 var 
  Params:array of byte;
  len:integer;
  Op:Word;
  Index:Integer;
  I:Integer;
  P:Pointer;
 function GetByte:Byte;
 begin
  Result:=PByte(P)^;
  Inc(P);
  Inc(Index);
 end;
 begin
  Log('Firmware load ...');
  HciCommand(OGF_VENDOR,$2e,[]);
  Index:=0;
  P:=BcmFirmwarePointer;
  while Index < BcmFirmwareLength do
   begin
    Op:=GetByte;
    Op:=Op or (GetByte shl 8);
    Len:=GetByte;
    SetLength(Params,Len);
    for I:= 0 to Len - 1 do
     Params[I]:=GetByte;
    HciCommand(Op,Params);
   end;
  CloseUart0;
  Log('Firmware load done');
 end;

 procedure SetLEEventMask(Mask:QWord);
 var 
  Params:array of byte;
  MaskHi,MaskLo:DWord;
 begin
  MaskHi:=(Mask shr 32) and $FFFFFFFF;
  MaskLo:=Mask and $FFFFFFFF;
  SetLength(Params,8);
  Params[0]:=MaskLo and $ff;   // lsb
  Params[1]:=(MaskLo shr 8) and $ff;
  Params[2]:=(MaskLo shr 16) and $ff;
  Params[3]:=(MaskLo shr 24) and $ff;
  Params[4]:=MaskHi and $ff;   // lsb
  Params[5]:=(MaskHi shr 8) and $ff;
  Params[6]:=(MaskHi shr 16) and $ff;
  Params[7]:=(MaskHi shr 24) and $ff;
  HciCommand(OGF_LE_CONTROL,$01,Params);
 end;

 procedure OpenHc05;
 begin
  if IsBlueToothAvailable then
   begin
    OpenUart0;
   end;
 end;

 procedure SetLEScanParameters(Type_:byte;Interval,Window:Word;OwnAddressType,FilterPolicy:byte);
 begin
  HciCommand(OGF_LE_CONTROL,$0b,[Type_,lo(Interval),hi(Interval),lo(Window),hi(Window),OwnAddressType,FilterPolicy]);
 end;

 procedure SetLEScanEnable(State,Duplicates:boolean);
 var 
  Params:Array of Byte;
 begin
  SetLength(Params,2);
  if State then
   Params[0]:=$01
  else
   Params[0]:=$00;
  if Duplicates then
   Params[1]:=$01
  else
   Params[1]:=$00;
  HciCommand(OGF_LE_CONTROL,$0c,Params);
 end;

 procedure StartPassiveScanning;
 begin
  SetLEScanParameters(LL_SCAN_PASSIVE,Round(ScanInterval*ScanUnitsPerSecond),Round(ScanWindow*ScanUnitsPerSecond),$00,$00);
  SetLEScanEnable(True,False);
 end;

 procedure StartActiveScanning;
 begin
  SetLEScanParameters(LL_SCAN_ACTIVE,Round(ScanInterval*ScanUnitsPerSecond),Round(ScanWindow*ScanUnitsPerSecond),$00,$00);
  SetLEScanEnable(True,False);
 end;

 procedure StopScanning;
 begin
  SetLEScanEnable(False,False);
 end;

 procedure SyncRx;
 var 
  Res:LongWord;
  C:LongWord;
  B:Byte;
  TimeStamp:LongWord;
 begin
  //  Log('SyncRx ...');
  TimeStamp:=ClockGetCount;
  while LongWord(ClockGetCount - TimeStamp) < Round(2*ScanWindow*1000*1000) do
   begin
    Res:=SerialDeviceRead(UART0,@B,1,SERIAL_READ_NON_BLOCK,C);
    if (Res = ERROR_SUCCESS) and (C = 1) then
     TimeStamp:=ClockGetCount
    else
     Sleep(10);
   end;
  //  Log('SyncRx done');
 end;

 procedure InitHc05;
 begin
  if IsBlueToothAvailable then
   begin
    Log('prepare ...');
    PrepareBcmFirmware(BcmFirmwareIndex);
    Log('prepare done');
    SyncRx;
    ResetChip;
    try
     BCMLoadFirmware;
     Log('bluetooth hc05 init complete');
    except
     on E:Exception do
          begin
           Log(Format('load exception %s',[E.Message]));
          end;
   end;
 end;
end;

var 
 I:Integer;
 RequireHciInit:Boolean;

begin
 Log(Format('UltiboProgram begin at %d ticks',[GetTickCount]));
 if BoardGetType <> BOARD_TYPE_QEMUVPB then
  begin
   while not DirectoryExists('C:\') do
    sleep(100);
   if FileExists('default-config.txt') then
    CopyFile('default-config.txt','config.txt',False);
  end;

 //SerialDeviceEnumerate(FindUart,Nil);
 for I:=Low(BtAddr) to High(BtAddr) do
  BtAddr[I]:=0;
 OpenHc05;
 if SysUtils.GetEnvironmentVariable('BT_RELOAD_FW') = '1' then
  begin
   InitHc05;
   OpenHc05;
  end
 else
  begin
   SyncRx;
   //SetLEEventMask($00);
   ReadAddress;
   RequireHciInit:=True;
   for I:=Low(BtAddr) to High(BtAddr) do
    RequireHciInit:=RequireHciInit and (BtAddr[I] = $AA);
   if RequireHciInit then
    begin
     InitHc05;
     OpenHc05;
    end
   else
    StopScanning;
  end;
 SetLEEventMask($ff);
 StartActiveScanning;
 NimMain;
 ThreadHalt(0);
end.
