class subscriber ; 

string name            ;
int covered            ;
int total              ; 
transaction  t_sub     ;
mailbox subs_mail      ;

  function new (string name = " SUBSCRIBER ") ;
    this.name          = name   ; 
    this.subs_mail     = new()  ;
    this.groub1        = new()  ; 
  endfunction

  covergroup groub1 ; 
    UP_C :coverpoint t_sub.up {
      bins tr_up = ( [0:1] => 1 )  ;
    }
    DOWN_C :coverpoint t_sub.down {
      bins tr_dw = ( [0:1] => 1 )  ;
    }
    COUNT :coverpoint t_sub.count {
      bins Overflow_U =  (15  => 0)    ;
      bins Overflow_D =  (0  => 15 )   ;  
    }

    CROSS_OVERFLOW : cross  UP_C  , COUNT , DOWN_C {
      bins UC = binsof(UP_C.tr_up)   &&  binsof(COUNT.Overflow_U )         ; 
      bins DC = binsof(DOWN_C.tr_dw) &&  binsof(COUNT.Overflow_D)          ; 
      ignore_bins IG  = binsof( UP_C.tr_up   ) && binsof(COUNT.Overflow_D) ; 
      ignore_bins IG2 = binsof( DOWN_C.tr_dw ) && binsof(COUNT.Overflow_U) ;
      ignore_bins IG3 = binsof( DOWN_C.tr_dw ) && binsof(UP_C.tr_up )      ;

    }
    HIGH : coverpoint t_sub.high {
      bins HI = {1} iff (t_sub.count == 15) ; 
    }
    LOW : coverpoint t_sub.low {
      bins LO = {1} iff (t_sub.count == 0)  ; 
    }
    UP   : coverpoint t_sub.up   ;
    DOWN : coverpoint t_sub.down ;
    LOAD : coverpoint t_sub.load ;

    CROSS_PRIORITY : cross UP, DOWN, LOAD {
      
    }
   
  endgroup  

  task run_subscriber();
    //$display("subscriber Starting To Recieve Data From the monitor ") ;
    forever  begin 

      t_sub = new ()                                    ; 
      subs_mail.get(t_sub)                              ;
      groub1.sample()                                   ; 
      //t_sub.display_transaction(" SUBSCRIBER")          ;
     // $display("subscriber has recieved the data from the monitor at time : %0P",$realtime()) ;
 

    end 

  endtask 

  task display_coverage_percentage() ; 
    $display("The Coverage is :%0P ",groub1.get_coverage(covered,total));
    $display("The covered  is :%0P ",covered);
    $display("The total    is :%0P ",total);
  endtask

endclass 