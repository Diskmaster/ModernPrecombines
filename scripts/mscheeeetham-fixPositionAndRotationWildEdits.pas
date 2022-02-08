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
		//addmessage('el: ' + name(rec));		
		findElements(rec,rec);
	end;
	
	function findElements(currentRec,contRec:IInterface):boolean;
	var 
		currElm: IInterface;
		path: string;
		i: integer;
	begin
		for i := 0 to Pred(ElementCount(currentRec)) do begin
			currElm := ElementByIndex(currentRec, i);
			if (DefType(currElm) = dtStruct) then findElements(currElm,contRec)		
			 else if (defType(currElm) = dtFloat) then checkFloatError(contRec, elementPath(currElm));		
		end;				
	end;	
		
	function checkFloatError(rec, path:string):boolean;
	var
		el,masEl: IInterface;
		elVal,masVal,del: extended;
	Begin
		el := elementByPath(rec,path);
		masEl := elementByPath(masterOrSelf(rec),path);
		if assigned(masEl) 
		 and assigned(el) 
		 and (defType(masEl) = dtFloat) then begin
			elVal := GetNativeValue(el);
			masVal := GetNativeValue(masEl);
			del := elVal-masVal;
			//addmessage('	testing ' + path + ' from: ' + FloatToStr(elVal) + ' To: ' + FloatToStr(masVal) + ' with delta: ' + FloatToStr(del));
			if (del <> 0) and (del > -0.0002) and (del < 0.0002) then setNativeValue(el, masVal);
		end;
	end;
end.