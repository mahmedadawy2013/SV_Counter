class environment ; 

string name              ;
generator  g             ;
driver     d             ;
monitor    m             ;
scoreboard s             ;
subscriber su            ;
virtual intf env_intf    ;   

  function new (string name = " ENVIRONMENT ") ;
    this.name          = name   ; 
  endfunction

  task run_environment();
  
        g  = new ()  ;
        d  = new ()  ;
        m  = new ()  ;
        s  = new ()  ;  
        su = new ()   ; 
        g.gen_mail     = d.driv_mail     ; 
        g.gen_handover = d.driv_handover ;
        s.scor_mail    = m.mon_mail_s    ;
        su.subs_mail   = m.mon_mail_su   ;
        d.driv_intf    = env_intf        ;
        m.mon_intf     = env_intf        ;

        fork 
            su.run_subscriber() ;  
            s.run_scoreboard()  ;
            m.run_monitor()     ; 
            d.run_driver()      ;   
            g.run_generator()   ;
        join_any 
        @(negedge env_intf.clk)
        su.display_coverage_percentage() ; 
        s.display_test_cases_report()    ;
        $finish() ;  
      
  endtask 

endclass 