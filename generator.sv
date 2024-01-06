class generator;

string name          ;
transaction  t_gen   ;
int iteration_number ;
mailbox gen_mail     ;
event   gen_handover ;  

    function new (string name = " GENERATOR ") ;
        this.name         = name   ; 
        this.gen_mail     = new () ;
    endfunction

    task run_generator () ;
        t_gen = new () ; 
        iteration_number = 20 ; 
        for (int i=0; i<iteration_number; ++i) begin
            
            if (i == 0 ) begin
                t_gen.rst        = 1'b0                 ; 
                t_gen.load       = 1'b0                 ; 
                t_gen.up         = 1'b0                 ; 
                t_gen.down       = 1'b0                 ; 
                t_gen.in         = 4'b0                 ;
                //t_gen.display_transaction("GENERATOR")  ;
                gen_mail.put(t_gen)                     ;
                @(gen_handover)                         ;
            end
            else if (i == 1 ) begin 
                
                t_gen.randomize() with {t_gen.rst inside { 1'b1 } ;
                                        t_gen.load == 1           ;                    
                                        t_gen.in   == 15          ; 
                                        t_gen.down == 0           ; 
                                        t_gen.up   == 0           ;  }      ;
                //$display("Iteration Number : %0P",i)                      ; 
                //t_gen.display_transaction("GENERATOR")                    ;
                gen_mail.put(t_gen)                                         ;
                @(gen_handover)                                             ;

            end 
            else if (i == 2 ) begin 
                
                t_gen.randomize() with {t_gen.rst inside { 1'b1 } ;
                                        t_gen.load == 0           ;
                                        t_gen.down == 0           ;                     
                                        t_gen.up   == 1           ;  }      ;
                $display("Iteration Number : %0P",i)                        ; 
                //t_gen.display_transaction("GENERATOR")                    ;
                gen_mail.put(t_gen)                                         ;
                @(gen_handover)                                             ;

            end 
            else if (i == 3 ) begin 
                
                t_gen.randomize() with {t_gen.rst inside { 1'b1 } ;
                                        t_gen.load == 1           ;                    
                                        t_gen.in   == 0           ; 
                                        t_gen.down == 0           ; 
                                        t_gen.up == 0             ;  }      ;
                $display("Iteration Number : %0P",i)                        ; 
                //t_gen.display_transaction("GENERATOR")                    ;
                gen_mail.put(t_gen)                                         ;
                @(gen_handover)                                             ;

            end 
            else if (i == 4 ) begin 
                
                t_gen.randomize() with {t_gen.rst inside { 1'b1 } ;
                                        t_gen.load == 0           ;
                                        t_gen.down == 1           ;                     
                                        t_gen.up == 0             ;  }      ;
                $display("Iteration Number : %0P",i)                        ; 
                //t_gen.display_transaction("GENERATOR")                    ;
                gen_mail.put(t_gen)                                         ;
                @(gen_handover)                                             ;

            end 
            else begin

                t_gen.randomize() with {t_gen.rst inside { 1'b1 } ;}        ;
                $display("Iteration Number : %0P",i)                        ; 
                //t_gen.display_transaction("GENERATOR")                    ;
                gen_mail.put(t_gen)                                         ;
                @(gen_handover)                                             ;

            end

        end


    endtask


endclass