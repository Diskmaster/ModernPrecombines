{
  Supports Fallout 4 only.
}
unit fixRoundingErrors;
  
	function Initialize: integer;
	begin
	end;

	function Process(rec: IInterface): Integer;
	var
	  r,refs,ref, baseRef,masRec: IInterface;
	  overrideRecord, overrideRecordFile: IInterface;
	  m: IInterface;
	  curRecFile: IInterface;
	  el,cont: IInterface;
	  j,i,k,id,z: integer;
	  zValrec,zValmas,zValdel: extended;
	  overrideRecordName,curRecName,baseRefSig: string;	  
	begin
		if (Signature(rec) <> 'REFR') then Exit;		
		curRecName := getfilename(rec);				
		findElements(rec);
		// Result := 1;
	end;


	function findElements(rec:IInterface):boolean;
	var el,recElm,recElms:IInterface;
	els,xyz:tStringList;
	  i,j: integer;
	  path: string;
	begin
		for i := 0 to Pred(ElementCount(rec)) do begin
			recElm := ElementByIndex(rec, i);
			path := name(recElm) + '\';
			//addmessage('	path: ' + path);
			if(elementExists(rec,path + 'Position/Rotation')) then path := path + 'Position/Rotation\';
			if elementExists(rec,path + 'Position')
			or elementExists(rec,path + 'Rotation') then begin
				els := TStringList.Create;
				els.CommaText := 'Position,Rotation';
				xyz := TStringList.Create;
				xyz.CommaText := 'Z,X,Y';
				for i:=0 to 1 do begin					
					for j:= 0 to 2 do begin
						checkFloatError(rec, path + els[i] + '\' + xyz[j]);
					end;
				end;
			end;
		end;				
	end;	

	function checkFloatError(rec, path:string):boolean;
	var
	  el,masRec: IInterface;
	  elVal,maVal,del: extended;
	Begin
		//addmessage('		path: ' + path);	
		el := elementByPath(rec,path);
		elVal := strToFloat(GetElementEditValues(rec,path));
		maVal := strToFloat(GetElementEditValues(masterOrSelf(rec),path));
		del := elVal-maVal;
		//addmessage('	testing ' + path + ' from: ' + FloatToStr(elVal) + ' To: ' + FloatToStr(maVal) + ' with delta: ' + FloatToStr(del));
		if not (del = 0) then if (del > -0.0002) and (del < 0.0002) then begin
			addmessage('Cell: ' + name(rec));	
			addmessage('	Changing ' + path(el) + ' from: ' + FloatToStr(elVal) + ' To: ' + FloatToStr(maVal));
			setNativeValue(el, maVal);
		end;
	end;
end.
