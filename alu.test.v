`include "alu.v"

module alu_test#(parameter TESTS=32)(
  input i_alu_ready,
  input i_alu_res_valid,
  input [31:0] i_alu_result,

  output [31:0] o_alu_a,
  output [31:0] o_alu_b,
  output  [1:0] o_alu_op
);

reg [32+32-1:0] tests [0:TESTS-1];

integer i;

initial begin
  for(i = 0; i < TESTS; i = i + 1) begin
    tests[i] = {{$random},{$random}};
  end
end

reg [31:0] t = 5'h0;

reg [31:0] a,b,res;
reg [1:0] op = `OP_NOP;

assign o_alu_a  = a;
assign o_alu_b  = b;
assign o_alu_op = op;


always @(posedge i_alu_res_valid && i_alu_ready) begin
  if (i_alu_result != res)
    $display("Result wrong!");
end

always @(posedge i_alu_ready) begin
   a <= tests[t][63:32];
   b <= tests[t][31:0];
   op <= `OP_ADD;
   res <= tests[t][63:32] + tests[t][31:0];
   if (t + 1 < TESTS)
     t = t + 1;
   else
     t = 0;
end

endmodule
`include "sim.v"
