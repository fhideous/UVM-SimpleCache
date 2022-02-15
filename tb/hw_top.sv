
import cache_def::*;
module hw_top;

  // Clock and reset signals
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

  initial begin
    reset  <= 1'b1;
    clk    <= 1'b0;
    repeat(5)
      @(posedge clk);
    reset <= 1'b0;
    $display("Reset sets by %d, time: %0t", reset, $realtime);
    @(posedge clk);
    
    $display("Reset sets by %d, time: %0t", reset, $time);
   
    // Write data
    for (int i=0; i < 6; i++) begin
        cpu_req.addr    <= 32'b0110 + 16 * i;
        cpu_req.data    <= 32'b1101 + 16 * i;
        cpu_req.rw      <= 1'b1;
        @(posedge clk);
        cpu_req.valid   <= 1'b1;
        @(posedge clk);
        cpu_req.valid   <= 1'b0;
        //need to set mem_data.ready to set data in 
    end 
    // Read data

    while(~cpu_res.ready)
        @(posedge clk);
    // $dilplay("-------------------");
    // $display("Out is: %10d", cpu_res.data);
    // $display("time: %0t", $time);
    // $dilplay("-------------------");
    #5000; $stop;

  end

endmodule
