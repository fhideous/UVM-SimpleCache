interface mem_if (input logic clk, input logic rst );

    timeunit        1ns;
    timeprecision   100ps;

    cache_def::mem_data_type       mem_data;
    cache_def::mem_req_type        mem_req;

endinterface : mem_if
