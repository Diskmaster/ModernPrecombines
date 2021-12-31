{
  Supports Fallout 4 only.
}
unit fixRoundingErrors;
uses 'lib\mteFunctions';

	function Initialize: integer;
	begin
	end;

	function Process(rec: IInterface): Integer;
	begin
		if (Signature(rec) <> 'REFR') then Exit;				
		findElements(rec,rec);
		// Result := 1;
	end;


	function findElements(el,rec:IInterface):boolean;
	var currElm,currElms:IInterface;
	els,xyz:tStringList;
	  i,j: integer;
	  path,poop: string;
	begin
		for i := 0 to Pred(ElementCount(el)) do begin
			currElm := ElementByIndex(el, i);
			if (DefType(currElm) = dtStruct) then findElements(currElm,rec);			
			//addmessage('el: ' + name(el) + elementPath(el));	
			if (defType(currElm) = dtFloat) then begin
				//addmessage('Cell: ' + shortname(rec) + ': ' + name(currElm));	
				checkFloatError(rec, elementPath(currElm));		
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
		elVal := GetNativeValue(el);
		maVal := GetNativeValue(elementByPath(masterOrSelf(rec),path));
		del := elVal-maVal;
		//addmessage('	testing ' + path + ' from: ' + FloatToStr(elVal) + ' To: ' + FloatToStr(maVal) + ' with delta: ' + FloatToStr(del));
		if not (del = 0) then if (del > -0.0002) and (del < 0.0002) then begin
			addmessage(path(el));
			setNativeValue(el, maVal);
		end;
	end;
end.


{	  {if DefType(recElm) = dtRecord then
					poop := 'dtRecord'
				  else if DefType(recElm) = dtSubRecord then
					poop := 'dtSubRecord'
				  else if DefType(recElm) = dtSubRecordArray then
					poop := 'dtSubRecordArray'
				  else if DefType(recElm) = dtSubRecordStruct then
					poop := 'dtSubRecordStruct'
				  else if DefType(recElm) = dtSubRecordUnion then
					poop := 'dtSubRecordUnion'
				  else if DefType(recElm) = dtString then
					poop := 'dtString'
				  else if DefType(recElm) = dtLString then
					poop := 'dtLString'
				  else if DefType(recElm) = dtLenString then
					poop := 'dtLenString'
				  else if DefType(recElm) = dtByteArray then
					poop := 'dtByteArray'
				  else if DefType(recElm) = dtInteger then
					poop := 'dtInteger'
				  else if DefType(recElm) = dtIntegerFormater then
					poop := 'dtIntegerFormatter'
				  else if DefType(recElm) = dtFloat then
					poop := 'dtFloat'
				  else if DefType(recElm) = dtArray then
					poop := 'dtArray'
				  else if DefType(recElm) = dtStruct then
					poop := 'dtStruct'
				  else if DefType(recElm) = dtUnion then
					poop := 'dtUnion'
				  else if DefType(recElm) = dtEmpty then
					poop := 'dtEmpty';
				addmessage(signature(recElm) + ': ' + poop);
				if DefType(recElm) = dtStruct then findElements(recElm);
				els := TStringList.Create;
				els.CommaText := 'Position,Rotation,Bounds';
				for i:=0 to 1 do begin
					if elementExists(rec,path + els[i]) then begin
						el := elementByPath(rec,path + els[i]);
						for j:= 0 to 2 do begin
							checkFloatError(rec, path + els[i] + '\' + el);
						end;
				
					end;
				end}
