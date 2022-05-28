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
begin
  if Signature(e) <> 'CELL' then
    Exit;

  // operate on the last override
  wo := WinningOverride(e);

  if GetFileName(wo) = GetFileName(e) then
    Exit;

  try
    r := e;
    
    RemoveElement(r, 'VISI');
    if ElementExists(wo, 'VISI') then begin
      Add(r, 'VISI', True);
      ElementAssign(ElementByPath(r, 'VISI'), LowInteger, ElementByPath(wo, 'VISI'), False);
    end;

    RemoveElement(r, 'RVIS');
    if ElementExists(wo, 'RVIS') then begin
      Add(r, 'RVIS', True);
      wbCopyElementToRecord(ElementByPath(wo, 'RVIS'), r, False, True);
    end;

    RemoveElement(r, 'XPRI');
    if ElementExists(wo, 'XPRI') then begin
      Add(r, 'XPRI', True);
      wbCopyElementToRecord(ElementByPath(wo, 'XPRI'), r, False, True);
    end;

  except
    on Ex: Exception do begin
      AddMessage('Failed to merge precombines: ' + FullPath(e));
      AddMessage('    reason: ' + Ex.Message);
    end;
  end;

end;


function Finalize: integer;
begin

end;

end.
