class driver ; 

string name            ;
transaction  t_driv    ;
mailbox driv_mail      ;
event   driv_handover  ;
virtual intf driv_intf ;   

  function new (string name = " DRIVER ") ;
    this.name          = name   ; 
    this.driv_mail     = new()  ;
  endfunction

  task run_driver();

    //$display("Driver Starting To Recieve Data From the Generator ") ;
    forever  begin 
      
      //$display("Driver Is Waiting For Packet ......")  ;    
      t_driv = new ()                                  ; 
      driv_mail.get(t_driv)                            ;
      @(negedge driv_intf.clk)
      t_driv.display_transaction("DRIVER")             ;
      
      
      $display("Drive has insert the data into the DUT at time : %0P",$realtime()) ;
      driv_intf.rst    = t_driv.rst        ; 
      driv_intf.load   = t_driv.load       ;
      driv_intf.up     = t_driv.up         ;  
      driv_intf.down   = t_driv.down       ; 
      driv_intf.in     = t_driv.in         ;
      ->driv_handover                      ;
 

    end 
      
  endtask 

endclass 