unit BytesStream;

interface
// TBytesStream was added in D2009, so define it manually for D2007

uses
  SysUtils, Classes, RTLConsts
  ;


type
  TBytesStream = class(TMemoryStream)
  private
    FBytes: TBytes;
    FSize: Longint;
  protected
    function Realloc(var NewCapacity: Longint): Pointer; override;
  public
    constructor Create(const ABytes: TBytes); overload;
    property Bytes: TBytes read FBytes;
  end;


implementation


constructor TBytesStream.Create(const ABytes: TBytes);
begin
  inherited Create;
  FBytes := ABytes;
  FSize := Length(FBytes);
  SetPointer(Pointer(FBytes), Length(FBytes));
  Capacity := FSize;
end;

const
  MemoryDelta = $2000; // Must be a power of 2


function TBytesStream.Realloc(var NewCapacity: Integer): Pointer;
begin
  if (NewCapacity > 0) and (NewCapacity <> FSize) then
    NewCapacity := (NewCapacity + (MemoryDelta - 1)) and not (MemoryDelta - 1);
  Result := Pointer(FBytes);
  if NewCapacity <> Capacity then
  begin
    SetLength(FBytes, NewCapacity);
    Result := Pointer(FBytes);
    if NewCapacity = 0 then
      Exit;
    if Result = nil then raise EStreamError.CreateRes(@SMemoryStreamError);
  end;
end;


end.
