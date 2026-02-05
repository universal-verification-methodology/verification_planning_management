`timescale 1ns/1ps

// Simple non-UVM testbench for stream_fifo.
// Exercises basic push/pop, backpressure, overflow, and underflow behavior.
//
module tb_stream_fifo;
  localparam int DATA_WIDTH = 8;
  localparam int DEPTH      = 4;

  // DUT signals
  logic clk;
  logic rst_n;

  logic                  s_valid;
  logic [DATA_WIDTH-1:0] s_data;
  logic                  s_ready;

  logic                  m_valid;
  logic [DATA_WIDTH-1:0] m_data;
  logic                  m_ready;

  logic [$clog2(DEPTH+1)-1:0] level;
  logic                       overflow;
  logic                       underflow;

  // Instantiate DUT
  stream_fifo #(
    .DATA_WIDTH (DATA_WIDTH),
    .DEPTH      (DEPTH)
  ) dut (
    .clk       (clk),
    .rst_n     (rst_n),
    .s_valid   (s_valid),
    .s_data    (s_data),
    .s_ready   (s_ready),
    .m_valid   (m_valid),
    .m_data    (m_data),
    .m_ready   (m_ready),
    .level     (level),
    .overflow  (overflow),
    .underflow (underflow)
  );

  // Clock generation
  initial begin
    clk = 0;
    forever #5 clk = ~clk; // 100 MHz
  end

  // Simple reset
  initial begin
    rst_n = 0;
    s_valid = 0;
    s_data  = '0;
    m_ready = 0;
    #25;
    rst_n = 1;
  end

  // Task to push one word
  task automatic push_byte(input logic [DATA_WIDTH-1:0] value);
    begin
      @(posedge clk);
      s_data  <= value;
      s_valid <= 1'b1;
      do begin
        @(posedge clk);
      end while (!s_ready);
      // Data accepted this cycle
      s_valid <= 1'b0;
    end
  endtask

  // Task to pop one word and check expected value
  task automatic pop_and_check(input logic [DATA_WIDTH-1:0] exp);
    begin
      // Wait until data valid
      @(posedge clk);
      while (!m_valid) begin
        @(posedge clk);
      end
      m_ready <= 1'b1;
      @(posedge clk);
      m_ready <= 1'b0;
      if (m_data !== exp) begin
        $error("Data mismatch: expected %0h, got %0h at time %0t", exp, m_data, $time);
        $fatal(1);
      end else begin
        $display("[%0t] PASS: Read %0h", $time, m_data);
      }
    end
  endtask

  // Main stimulus
  initial begin
    // Wait for reset deassertion
    @(negedge rst_n);
    @(posedge rst_n);
    @(posedge clk);

    $display("=== Starting basic push/pop test ===");

    // Simple push/pop sequence
    push_byte(8'h11);
    push_byte(8'h22);
    push_byte(8'h33);

    // Allow some cycles before popping
    repeat (2) @(posedge clk);
    pop_and_check(8'h11);
    pop_and_check(8'h22);
    pop_and_check(8'h33);

    // Check underflow behavior
    $display("=== Testing underflow ===");
    m_ready <= 1'b1;
    @(posedge clk);
    m_ready <= 1'b0;
    if (!underflow) begin
      $error("Expected underflow flag to be set on read from empty FIFO");
      $fatal(1);
    end else begin
      $display("[%0t] PASS: underflow flag set", $time);
    end

    // Clear flags via reset for simplicity
    $display("=== Applying reset to clear flags ===");
    @(posedge clk);
    rst_n <= 0;
    @(posedge clk);
    rst_n <= 1;
    @(posedge clk);

    // Test overflow behavior with backpressure
    $display("=== Testing overflow with backpressure ===");
    // Hold m_ready low to prevent draining
    m_ready <= 1'b0;
    // Push DEPTH entries (should fill FIFO)
    for (int i = 0; i < DEPTH; i++) begin
      push_byte(8'(i));
    end
    // FIFO is now full; s_ready should be 0
    if (s_ready !== 1'b0) begin
      $error("Expected s_ready=0 when FIFO is full");
      $fatal(1);
    end

    // Attempt one more push to cause overflow
    @(posedge clk);
    s_data  <= 8'hAA;
    s_valid <= 1'b1;
    @(posedge clk);
    s_valid <= 1'b0;

    if (!overflow) begin
      $error("Expected overflow flag to be set on push when full");
      $fatal(1);
    end else begin
      $display("[%0t] PASS: overflow flag set", $time);
    end

    // Now drain the FIFO
    m_ready <= 1'b1;
    repeat (DEPTH+2) @(posedge clk);

    $display("=== All tests completed ===");
    $finish;
  end

endmodule

