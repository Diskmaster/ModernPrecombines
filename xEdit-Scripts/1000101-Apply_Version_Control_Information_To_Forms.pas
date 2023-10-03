{
    Apply Version Control Information To Forms
    v1.0.4 - Fixes accidental setting of the plugin File Header VCS info and corrects all TES4 records processed
    v1.0.3 - Enabled an unfiltered (empty) "ValidForms" string
    v1.0.2 - Fixed issue with User and Last User being [de]coded backwards
    v1.0.1 - Fixed issue with what xEdit calls "Index" (hint, there's not such thing)
    v1.0.0 - First release
}
unit ApplyVCInfo;




    const
        // Form types to update by their record signatures, use an empty string for no filtering
        //ValidForms                                      = 'STAT;REFR';
        ValidForms                                      = '';
        
        // Just straight copy the VCS1 and VCS2 fields from the master record or,
        // if the record is the master and VCS1 is 0, create the initial VCS1 and
        // VCS2 fields otherwise, do nothing.
        // If bCopyMasterRecord is false, then use the rules below to update VCS1
        //bCopyMasterRecord                               = true;
        bCopyMasterRecord                               = false;
        
        // VCS1 Info:
        //  Year            ... of last commit
        //  Month           ... of last commit
        //  Day             ... of last commit
        //  Last User       User ID* of the last commit
        //  Current User    Current User ID* that has checked out the Form
        
        // User ID* to set in the VCS1 Info
        iUser                                           = 1;
        
        // *    Valid value from your specific CreationKitPrefs.ini [WhoCanMerge] section.
        //      Team projects don't need to know all the different users, they just need 
        //      unique value from their teams dev group for their machine's login credentials
        //      and CK commits.
        
        // Use the current machine date instead of constants set below
        bUseCurrentDate                                 = true;
        //bUseCurrentDate                                 = false;
        
        // If forcing the date, force the master date instead of the constants set below
        bUseMasterDate                                  = true;
        //bUseMasterDate                                  = false;
        
        iForceDay                                       = 1;
        iForceMonth                                     = 1;
        iForceYear                                      = 2001;




    // Build an updated VCS1 from the source and the controls above.
    function BuildUpdatedVCS1( VCS1: Cardinal ): Cardinal;
        var
            d, m, y, l: integer;
        
        begin
            if( bCopyMasterRecord )then begin
                Result := VCS1;
                exit;
            end;
            
            if( bUseCurrentDate )then
                DeCodeDate( Date, y, m, d )
            else if( bUseMasterDate )then begin
                d := GetDayFromVCS1( VCS1 );
                m := GetMonthFromVCS1( VCS1 );
                y := GetYearFromVCS1( VCS1 );
            end else begin
                d := iForceDay;
                m := iForceMonth;
                y := iForceYear;
            end;
            
            if( VCS1 = 0 )then
                l := 0
            else
                l := GetUserFromVCS1( VCS1 );
            
            Result := BuildVCS1( d, m, y, iUser, l );
        end;




    // Build the packed VCS1 32-bit uint from the individual components
    function BuildVCS1( d, m, y, u, l: integer ): Cardinal;
        begin
            Result
            := ( d and $1F )
            or ( ( m and $0F ) shl 5 )
            or ( ( ( y - 2000 ) and $7F ) shl 9 )
            or ( ( u and $FF ) shl 24 )
            or ( ( l and $FF ) shl 16 );
        end;




    // Unpack the date components block from the 32-bit uint VCS1
    function GetDateFromVCS1( VCS1: cardinal ): integer;
        begin
            Result := VCS1 and $FFFF;
        end;




    // Unpack the day component from the 32-bit uint VCS1
    function GetDayFromVCS1( VCS1: cardinal ): integer;
        begin
            Result := VCS1 and $1F;
        end;




    // Unpack the month component from the 32-bit uint VCS1
    function GetMonthFromVCS1( VCS1: cardinal ): integer;
        begin
            Result := ( VCS1 shr 5 ) and $0F;
        end;




    // Unpack the normalized year component from the 32-bit uint VCS1
    function GetYearFromVCS1( VCS1: cardinal ): integer;
        begin
            Result := 2000 + ( ( VCS1 shr 9 ) and $7F );
        end;




    // Unpack the user component from the 32-bit uint VCS1
    function GetUserFromVCS1( VCS1: cardinal ): integer;
        begin
            Result := ( VCS1 shr 24 ) and $FF;
        end;




    // Unpack the last user component from the 32-bit uint VCS1
    function GetLastUserFromVCS1( VCS1: cardinal ): integer;
        begin
            Result := ( VCS1 shr 16 ) and $FF;
        end;




    // Return a human readable string from the 32-bit uint VCS1
    function VCS1InfoString( VCS1: cardinal ): string;
        begin
            Result := Format( '%.4d-%.2d-%.2d User: %d Last User: %d',
                [
                    GetYearFromVCS1( VCS1 ),
                    GetMonthFromVCS1( VCS1 ),
                    GetDayFromVCS1( VCS1 ),
                    GetUserFromVCS1( VCS1 ),
                    GetLastUserFromVCS1( VCS1 )
                ] );
        end;




    //==================================================================================
    function Process( e: IInterface ): integer;
        var
            c, n: string;
            m: IInterface;
            VCSOne: Cardinal;
            VCSTwo: Cardinal;
            VCSNew: Cardinal;
            VCSToo: Cardinal;
            
        begin
            c := Signature( e );
            if( c = 'TES4' )then begin
                SetFormVCS1( e, 0 );
                SetFormVCS2( e, 0 );
                exit;
            end;
            if( Length( ValidForms ) > 0 )then
                if( Pos( c, ValidForms ) < 1 )then
                    exit;
            
            c := #9 + 'Master:';
            n := #9 + 'Target:';
            
            m := MasterOrSelf( e );
            
            VCSOne := GetFormVCS1( m );
            VCSNew := BuildUpdatedVCS1( VCSOne );
            
            c := c + ' VCS1: [' + VCS1InfoString( VCSOne ) + ']';
            n := n + ' VCS1: [' + VCS1InfoString( VCSNew ) + ']';
            
            if( VCSOne = 0 )then
                VCSTwo := 0
            else
                VCSTwo := GetFormVCS2( m );
            VCSToo := VCSTwo;
            
            c := c + ' VCS2: [' + IntToHex( VCSTwo, 4 ) + ']';
            n := n + ' VCS2: [' + IntToHex( VCSToo, 4 ) + ']';
            
            SetFormVCS1( e, VCSNew );
            SetFormVCS2( e, VCSToo );
            
            AddMessage( 'Updated: [' + Signature( e ) + ': ' + IntToHex( FormID( e ), 8 ) + '] ' + EditorID( e ) );
            AddMessage( c );
            AddMessage( n );
        end;




end.
