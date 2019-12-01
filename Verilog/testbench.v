// Code your testbench here
// or browse Examples
`timescale 1ns/10ps

module test();
  
  
  wire gnt_0, gnt_1;
  reg clock, reset, req_0, req_1;
  
  fsm FSM(.clock(clock), .reset(reset), .req_0(req_0), .req_1(req_1), .gnt_0(gnt_0), .gnt_1(gnt_1));
  
  initial begin
    
  // Dump waves
  $dumpfile("dump.vcd");
  $dumpvars(1);  
    
    
  clock = 1'b0;
  reset = 1'b1;
  req_0 = 1'b0;
  req_1 = 1'b0;
    
   
  #10 reset = 1'b0;
  
  #10 reset = 1'b0;  
  
  #50 req_1 = 1'b1;
    
  #100 $stop;  
    
  end
  
  always begin
    
    #5 clock = ~clock;
    
  end
  
endmodule