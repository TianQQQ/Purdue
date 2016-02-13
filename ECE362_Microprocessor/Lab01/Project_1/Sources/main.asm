; Generic assembly source file for testing code segments

        org     $900    
        ldaa    #$17
        ADDA    #$D3  
        DAA           
        LDAB    #$84  
        PSHB      		
        ADDA    0,sp    
        DAA            
        LDAA    #$19     
        SUBA    1,sp+       
        DAA
        STOP