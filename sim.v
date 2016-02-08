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

  always begin
    #5 clk <= ~clk;
  end

  wire [31:0] alu_a;
  wire [31:0] alu_b;
  wire  [1:0] alu_cmd;

  wire [31:0] alu_result;
  wire        alu_res_valid;
  wire        alu_ready;

  alu my_alu
  (
    .clk(clk),
    .reset(reset),

    .i_a(alu_a),
    .i_b(alu_b),
    .i_cmd(alu_cmd),

    .o_result(alu_result),
    .o_valid(alu_res_valid),
    .o_ready(alu_ready)
  );

  alu_test my_test
  (
    .i_alu_ready(alu_ready),
    .i_alu_res_valid(alu_res_valid),
    .i_alu_result(alu_result),

    .o_alu_a(alu_a),
    .o_alu_b(alu_b),
    .o_alu_op(alu_cmd)
  );

endmodule
