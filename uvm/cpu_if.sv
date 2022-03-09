interface cpu_if (input logic clk, input logic rst );

    timeunit        1ns;
    timeprecision   100ps;

    cache_def::cpu_req_type        cpu_req;
    cache_def::cpu_result_type     cpu_res;

endinterface : cpu_if