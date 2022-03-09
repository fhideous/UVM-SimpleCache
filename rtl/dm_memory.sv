
import cache_def::*;

module dm_memory(
    input   logic           clk_i,
    input   mem_req_type    mem_req_i, // cache to memory
    output  mem_data_type   mem_data_o // memory to cache
);

logic [127:0] memory[int];
logic [31:0]  address;

assign address = mem_req_i.addr >> 4;

always_ff @( posedge clk_i ) begin
    mem_data_o.ready = 1'b0;
    if (mem_req_i.valid) begin
        mem_data_o.ready = 1'b1;
        if(mem_req_i.rw)
            memory[address] = mem_req_i.data;
        else
            mem_data_o.data = memory[address];
    end
end
endmodule