module tb_contador_de_periodos;
  logic clk, rst;
  logic start;
  logic sinal_in;
  logic [31:0] periodo_ms;
  logic ready, done;
  
  localparam N = 8;
  logic [31:0] testvectors [N-1:0];
  logic [31:0] expected_out;

  contador_de_periodos #(1000) dut(
    .clk(clk),
    .rst(rst),
    .start(start),
    .sinal_in(sinal_in),
    .done(done),
    .ready(ready),
    .periodo_ms(periodo_ms)
  );

  localparam CLOCK_PERIOD = 500;
  
  always #CLOCK_PERIOD clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_contador_de_periodos);

    clk = 1; 
    rst = 1; 
    start = 0; 
    sinal_in = 0;
    @(posedge clk);
    rst = 0; 
    @(posedge clk);

    $readmemb("testvectors.txt", testvectors, 0, N-1);
    for (int i = 0; i < N; i = i + 1) begin
      start = 1; 
      @(posedge clk);
    
      sinal_in = 0; 
      @(posedge clk);
      sinal_in = 1; 
      @(posedge clk);
       
      repeat((i+1) * 1000) @(posedge clk);
     
      sinal_in = 0; 
      @(posedge clk);
      sinal_in = 1; 
      @(posedge clk);
      
      wait(done);
      
      expected_out = testvectors[i];

      
      assert(periodo_ms === expected_out)
        else $error(
          "Teste %0d falhou. periodo_ms=%0d, esperado=%0d",
          i+1, periodo_ms, expected_out
        );

      @(posedge clk); 
    end

    $finish; 
  end
endmodule