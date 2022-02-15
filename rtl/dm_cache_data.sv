 timeunit 1ns; timeprecision 1ps;
/*cache: data memory, single port, 1024 blocks*/
import cache_def::*;
module dm_cache_data(
    input bit               clk_i,
    input cache_req_type 	data_req,//data request/command, e.g. RW, valid
    input cache_data_type 	data_write, //write port (128-bit line)
    output cache_data_type 	data_read
); //read port

 cache_data_type data_mem [0:1023];

 initial begin
     for (int i=0; i<1024; i++)
         data_mem[i] = '0;
 end
 
 assign data_read = data_mem[data_req.index];
 
 always_ff @(posedge clk_i) begin
     if (data_req.we)
         data_mem[data_req.index] <= data_write;
     end
endmodule
