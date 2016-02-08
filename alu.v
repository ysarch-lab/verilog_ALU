`ifndef ALU_V
`define ALU_V

`define OP_NOP   2'h0
`define OP_ADD   2'h1
`define OP_SUB   2'h2

module alu(
  input clk,
  input reset,
  
  input [31:0] i_a,
  input [31:0] i_b,
  input  [1:0] i_cmd,

  output [31:0] o_result,
  output        o_valid,

  output        o_ready
);

reg [31:0] reg_result;
reg        reg_valid = 1'b0;

`define ST_RESET  2'h0
`define ST_READY  2'h1
`define ST_BUSY   2'h2

reg [1:0] reg_status = `ST_RESET;

always @(posedge clk && reset) begin
  reg_status <= `ST_READY;
end

assign o_ready = ((reg_status == `ST_READY) && !reset);
assign o_valid = (reg_valid && (reg_status == `ST_READY));
assign o_result = o_valid ? reg_result : 32'hx;

always @(posedge clk && !reset) begin

  case (reg_status)
  `ST_READY: begin
    reg_status <= `ST_BUSY;
    if (i_cmd == `OP_ADD) begin
      reg_result = i_a + i_b;
    end
  end
  `ST_BUSY: begin
    reg_valid <= 1'b1;
    reg_status <= `ST_READY;
  end
  default: begin
    $display("should not happen");
    $finish;
  end
  endcase

end

endmodule

`endif
