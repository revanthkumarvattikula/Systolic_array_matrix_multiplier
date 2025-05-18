module pe_DA_modified_tb();
  reg clk;
  reg reset;
  reg [3:0] in_a;
  reg [3:0] in_b;
  wire [3:0] out_a;
  wire [3:0] out_b;
  wire [8:0] out_c;
  
  // Create signed versions for monitoring as separate wires
  wire signed [3:0] in_a_signed;
  wire signed [3:0] in_b_signed;
  wire signed [8:0] out_c_signed;
  
  // Continuous assignments for signed versions
  assign in_a_signed = in_a;
  assign in_b_signed = in_b;
  assign out_c_signed = out_c;
  
  pe_DA_modified (
    .clk(clk),
    .reset(reset),
    .in_a(in_a),
    .in_b(in_b),
    .out_a(out_a),
    .out_b(out_b),
    .out_c(out_c)
  );

  initial begin
    clk = 0;
    forever #5 clk = ~clk;
  end

  initial begin
    // Initialize waveform dumping
    $dumpfile("pe_DA_modified.vcd");
    $dumpvars(0, pe_DA_modified_tb);
    
    // Initialize inputs
    reset = 1;
    in_a = 0;
    in_b = 0;
    #10;  // Hold reset for 10ns (1 clock cycle)
    reset = 0;
    
    // Test Case 1: 3 * 2
    $display("Test Case 1: 3 * 2");
    in_a = 4'b0011;  // +3
    in_b = 4'b0010;  // +2
    #10;
    $display("Result: %d * %d = %d", in_a_signed, in_b_signed, out_c_signed);

    // Test Case 2: -3 * 2
    $display("\nTest Case 2: -3 * 2");
    in_a = 4'b1101;  // -3
    in_b = 4'b0010;  // +2
    #10;
    $display("Result: %d * %d = %d", in_a_signed, in_b_signed, out_c_signed);
    
    
     // Test Case 3: -5 * 4
    $display("\nTest Case 3: -5 * 4");
    in_a = 4'b1011;  // -5
    in_b = 4'b0100;  // +4
    #10;
    $display("Result: %d * %d = %d", in_a_signed, in_b_signed, out_c_signed);
    
    
     // Test Case 4: 4 * -5
    $display("\nTest Case 4: -3 * 2");
    in_a = 4'b0100;  // +4
    in_b = 4'b1011;  // -5
    #10;
    $display("Result: %d * %d = %d", in_a_signed, in_b_signed, out_c_signed);
    
     // Test Case 5: +7 * -7
    $display("\nTest Case 5: 7 * -7");
    in_a = 4'b0111;  // +7
    in_b = 4'b1001;  // -7
    #10;
    $display("Result: %d * %d = %d", in_a_signed, in_b_signed, out_c_signed);

    // [Rest of your test cases...]
    // Continue with the same pattern for other test cases

    // End simulation
    $display("\nAll tests completed");
    $finish;
  end

  // Monitor using the pre-declared signed wires
  initial begin
    $monitor("At time %t: in_a = %d, in_b = %d, out_c = %d", 
             $time, in_a_signed, in_b_signed, out_c_signed);
  end
endmodule
