`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "subscriber.sv"
`include "environment.sv" 
module tb();  

    intf intf1()  ; 
    environment e ; 
    initial begin 
        e = new()            ; 
        e.env_intf = intf1   ; 
        e.run_environment()  ; 
    end 

    initial begin 
        intf1.clk = 1 ; 
    end  

    always  begin
       #5 intf1.clk = ~ intf1.clk ; 
    end

counter COUNTER (
.clk   (intf1.clk  ) ,
.rst   (intf1.rst  ) ,
.load  (intf1.load ) ,
.up    (intf1.up   ) ,
.down  (intf1.down ) ,
.in    (intf1.in   ) ,
.high  (intf1.high ) ,
.low   (intf1.low  ) ,
.count (intf1.count) 
); 


endmodule
