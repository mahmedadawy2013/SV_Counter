class transaction #(parameter WIDTH = 4 ) ;

// This is the base transaction object Container that will be used 
// in the environment to initiate new transactions and // capture transactions at DUT interface       

rand  bit                    rst               ;
rand  bit                    load              ;
rand  bit                    up                ;
rand  bit                    down              ;
randc bit [WIDTH-1:0]        in                ;
      bit                    high              ;
      bit                    low               ;
      bit [WIDTH-1:0]        count             ;

// This function allows us to print contents of the data packet
// so that it is easier to track in a logfile 

      function void display_transaction(input string name = "TRANSACTION" ); 

        $display ("*************** This is the %0P **********************",name)  ;  
        $display (" load       = %0d    rst         =   %0d  ", load      , rst      ) ; 
        $display (" up         = %0d    in          =   %0d  ", up        , in       ) ; 
        $display (" down       = %0d    count       =   %0d  ", down      , count    ) ; 
        $display (" high       = %0d    low         =   %0d  ", high      , low      ) ; 
        $display ("**********************************************************")   ;
      
	endfunction     
endclass
