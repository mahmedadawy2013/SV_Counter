class monitor ; 

string name            ;
transaction  t_mon     ;
mailbox mon_mail_s     ;
mailbox mon_mail_su    ;
virtual intf mon_intf  ;   

  function new (string name = " Monitor ") ;
    this.name          = name   ;
    this.mon_mail_s    = new()  ; 
    this.mon_mail_su   = new()  ; 
  endfunction

  task run_monitor();

    //$display("Monitor Starting To Recieve Data From the DUT ") ;
    @(posedge mon_intf.clk)
    forever  begin 
      
      //$display("Monitor Is Waiting For Packet ......")   ;    
      t_mon = new ()                                     ; 
      @(posedge mon_intf.clk)
      #1 
      t_mon.rst           = mon_intf.rst     ;    
      t_mon.load          = mon_intf.load    ; 
      t_mon.up            = mon_intf.up      ;  
      t_mon.down          = mon_intf.down    ; 
      t_mon.in            = mon_intf.in      ;
      t_mon.high          = mon_intf.high    ;
      t_mon.low           = mon_intf.low     ; 
      t_mon.count         = mon_intf.count   ; 
      mon_mail_s.put(t_mon)                              ;
      mon_mail_su.put(t_mon)                             ;
      //t_mon.display_transaction("Monitor")               ;          
      //$display("Monitor has Recieveed the data from the DUT at time : %0P",$realtime()) ;

    end 
      
  endtask 

endclass 