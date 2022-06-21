{
  Supports Fallout 4 only.
}
unit FO4DisablePreVis;

var
  plugin: IInterface;

function Process(e: IInterface): Integer;
var
  r: IInterface;
  wo: IInterface;
  m: IInterface;
begin
  if (Signature(e) <> 'CELL') then
    Exit;

  try
    {
	SetElementNativeValues(e, 'Record Header\Record Flags', GetElementNativeValues(e, 'Record Header\Record Flags') and $FFFFFF7F);
	}
    RemoveElement(e, 'VISI');
    RemoveElement(e, 'PCMB');
    RemoveElement(e, 'XPRI');
    RemoveElement(e, 'XCRI');
  except
    on Ex: Exception do begin
      AddMessage('Failed to remove: ' + FullPath(e));
      AddMessage('    reason: ' + Ex.Message);
    end;
  end;

end;

function Finalize: integer;
begin

end;

end.
