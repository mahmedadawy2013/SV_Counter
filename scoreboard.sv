class scoreboard ; 

string name            ;
transaction  t_score   ;
mailbox scor_mail      ;
int passed_test_cases  ;
int failed_test_cases  ;

  function new (string name = " SCOREBOARD ") ;
    this.name          = name   ; 
    this.scor_mail     = new()  ;
  endfunction

  task run_scoreboard();
    static int golden_counter ; 
    static int golden_high    ; 
    static int golden_low     ; 
    //$display("Scoreboard Starting To Recieve Data From the monitor ") ;
    forever  begin 

      t_score = new ()                                   ; 
      scor_mail.get(t_score)                             ;
      t_score.display_transaction("SCOREBOARD")          ;
      //$display("Scoreboard has recieved the data from the monitor at time : %0P",$realtime()) ;
      /**************************************  Reset Test Case ********************************************/
      if (t_score.rst == 0) begin 
        golden_counter = 0 ; 
        golden_high    = (golden_counter == 15) ? 1 : 0 ; 
        golden_low     = (golden_counter == 0 ) ? 1 : 0 ; 
        if ( t_score.count == golden_counter && t_score.low == golden_low && t_score.high == golden_high  )
          begin 
           $display("Reset Test Case Passed At time : %0P",$realtime()) ; 
           passed_test_cases++  ; 
          end
          else  begin
            $display("Reset Test Case Failed At time : %0P",$realtime()) ; 
            failed_test_cases++ ; 
          end
      end  
      /*****************************************************************************************************/
      /**************************************  Load Test Case ********************************************/
      else if (t_score.load == 1) begin 
          golden_counter = t_score.in ; 
          golden_high    = (golden_counter == 15) ? 1 : 0 ; 
          golden_low     = (golden_counter == 0 ) ? 1 : 0 ; 
        if ( t_score.count == golden_counter && t_score.low == golden_low && t_score.high == golden_high  )
          begin 
           $display("Load Test Case Passed At time : %0P",$realtime()) ; 
           passed_test_cases++  ; 
          end
          else  begin
            $display("Load Test Case Failed At time : %0P",$realtime()) ; 
            failed_test_cases++ ; 
          end
      end  
      /***************************************************************************************************/
      /**************************************  DOWN Test Case ********************************************/
      else if (t_score.down == 1) begin 
        if (golden_counter == 0 ) begin
          golden_counter = 15 ; 
          golden_high    = (golden_counter == 15) ? 1 : 0 ; 
          golden_low     = (golden_counter == 0 ) ? 1 : 0 ; 
        end else begin 
          golden_counter--   ; 
          golden_high    = (golden_counter == 15) ? 1 : 0 ; 
          golden_low     = (golden_counter == 0 ) ? 1 : 0 ; 
        end 
        if ( t_score.count == golden_counter && t_score.low == golden_low && t_score.high == golden_high  )
          begin 
           $display("DOWN Test Case Passed At time : %0P",$realtime()) ; 
           passed_test_cases++  ; 
          end
          else  begin
            $display("DOWN Test Case Failed At time : %0P",$realtime()) ; 
            failed_test_cases++ ; 
          end
      end  
      /*************************************************************************************************/
      /**************************************  UP Test Case ********************************************/
      else if (t_score.up == 1) begin 
        if (golden_counter == 15 ) begin
          golden_counter = 0 ; 
          golden_high    = (golden_counter == 15) ? 1 : 0 ; 
          golden_low     = (golden_counter == 0 ) ? 1 : 0 ; 
        end else begin 
          golden_counter++   ; 
          golden_high    = (golden_counter == 15) ? 1 : 0 ; 
          golden_low     = (golden_counter == 0 ) ? 1 : 0 ; 
        end 
        if ( t_score.count == golden_counter && t_score.low == golden_low && t_score.high == golden_high  )
          begin 
           $display("UP Test Case Passed At time : %0P",$realtime()) ; 
           passed_test_cases++  ; 
          end
          else  begin
            $display("UP Test Case Failed At time : %0P",$realtime()) ; 
            failed_test_cases++ ; 
          end
      end
      /****************************************************************************************************/
      /**************************************  idle Test Case ********************************************/
      else begin 
          if ( t_score.count == golden_counter && t_score.low == golden_low && t_score.high == golden_high  )
          begin 
           $display("Idle Test Case Passed At time : %0P",$realtime()) ; 
           passed_test_cases++  ; 
          end
          else  begin
            $display("Idle Test Case Failed At time : %0P",$realtime()) ; 
            failed_test_cases++ ; 
          end
      end   
      /*****************************************************************************************************/


    end 
      
  endtask 

  task display_test_cases_report () ;

    $display("The Number of Passed test cases is :%0P " , passed_test_cases ) ; 
    $display("The Number of Failed test cases is :%0P " , failed_test_cases ) ; 
  
  endtask 

endclass 