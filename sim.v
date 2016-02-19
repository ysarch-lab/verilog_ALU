`ifndef ALU_V
`define ALU_V
// Simulation module
module sim;

  reg reset = 1'b1;

  // VCD Dump
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars;
    #10 reset <= 1'b0;
    #1000 $finish;
  end

  reg clk = 1'b0;

  // 10 time units per cycle
  always #5 clk <= ~clk;

  // ALU test module
  test my_test
  (
    .clk(clk),
    .reset(reset)
  );

endmodule
`endif
