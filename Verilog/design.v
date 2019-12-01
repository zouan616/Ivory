// Code your design here
module fsm(clock, reset, req_0, req_1, gnt_0, gnt_1);
  
  input clock;
  input reset;
  input req_0;
  input req_1;
  output gnt_0;
  output gnt_1;
  
  reg gnt_0;
  reg gnt_1;

  
  parameter SIZE=3;
  parameter IDLE = 3'b001, GNT0 = 3'b010, GNT1 = 3'b100;
  
  reg [SIZE-1:0] current_state;
  reg [SIZE-1:0] next_state;
  
  assign next_state = fsm_function(current_state, req_0, req_1);
  
  
  function [SIZE-1:0] fsm_function;
  input [SIZE-1:0] current_state;
  input req_0;
  input req_1;
    case(current_state)
      IDLE: if(req_0==1'b1)
        begin
        fsm_function = GNT0;
        end
      else if(req_1==1'b1)
        begin
        fsm_function = GNT1;
        end
      else
        begin
        fsm_function = IDLE;
        end
      // GNT0
      GNT0: if(req_0==1'b1)
        begin
        fsm_function = GNT0;
        end
      else if(req_0==1'b0)
        begin
        fsm_function = IDLE;
        end
      else
        begin
        fsm_function = IDLE;
        end
      // GNT1
      GNT1: if(req_1==1'b0)
        begin
        fsm_function = IDLE;
        end
      else if(req_1==1'b1)
        begin
        fsm_function = GNT1;
        end
      else
        begin
        fsm_function = IDLE;
        end
      //default
      default: fsm_function = IDLE;
    endcase
  endfunction
  
// Sequential Logic
  always @ (posedge clock)
  begin
    if(reset == 1'b1)begin
    current_state <= IDLE;
    end
    else begin
    current_state <= next_state;
    end
  end
  
// Output Logic  
  always @ (posedge clock)
    begin
      case(current_state)
        IDLE: begin
        gnt_0 <= 1'b0;
        gnt_1 <= 1'b0;
        end
        GNT0: begin
        gnt_0 <= 1'b1;
        gnt_1 <= 1'b0;
        end
        GNT1: begin
        gnt_0 <= 1'b0;
        gnt_1 <= 1'b1;
        end
        default: begin
        gnt_0 <= 1'b0;
        gnt_1 <= 1'b0;
        end
      endcase
    end
  
endmodule