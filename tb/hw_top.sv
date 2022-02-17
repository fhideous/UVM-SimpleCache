
import cache_def::*;
module hw_top;

  logic                 reset;
  logic                 clk;
  cpu_req_type          cpu_req;
  mem_data_type         mem_data;
  mem_req_type          mem_req;
  cpu_result_type       cpu_res;

  // CLKGEN module generates clock
  always #5 clk <= ~clk;

  dm_cache_fsm dut(
    .reset_i  ( reset    ),
    .clk_i    ( clk       ),

    .cpu_req  ( cpu_req   ),
    .mem_data ( mem_data  ),
    .mem_req  ( mem_req   ),
    .cpu_res  ( cpu_res   ) 
  );

  dm_memory mem(
    .clk_i      ( clk       ),
    .mem_req_i  ( mem_req   ),
    .mem_data_o ( mem_data  )

  );
  
  logic [0:31] result [0:200];
  
  bit [0:31] rand_num;
  initial begin
    reset  <= 1'b1;
    clk    <= 1'b0;
    repeat(5)
      @(posedge clk);
    reset <= 1'b0;
    cpu_req.rw      <= 1'b0;

    std::randomize(rand_num);
    cpu_req.addr    <= { 2'b11, { 16{ 1'b0 } }, 1'b1, { 9{ 1'b0 } }, 4'b0000 };
    cpu_req.data    <= 32'b0 + 32'b1;
    cpu_req.rw      <= 1'b1;
    @(posedge clk);
    cpu_req.valid   <= 1'b1;
    @(posedge clk);
    while(~cpu_res.ready)
        @(posedge clk);
    cpu_req.valid   <= 1'b0;
    cpu_req.rw      <= 1'b0;

    std::randomize(rand_num);
    cpu_req.addr    <= { 2'b01, { 16{ 1'b0 } }, 1'b1, { 9{ 1'b0 } }, 4'b0000 };
    cpu_req.data    <= 32'b0 + 32'b01;
    cpu_req.rw      <= 1'b1;
    @(posedge clk);
    cpu_req.valid   <= 1'b1;
    @(posedge clk);
    while(~cpu_res.ready)
        @(posedge clk);
    cpu_req.valid   <= 1'b0;
    cpu_req.rw      <= 1'b0;
    
    #100; $stop;
  end

endmodule
