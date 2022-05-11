interface mem_if (input logic clk, input logic rst );

    timeunit        1ns;
    timeprecision   100ps;

    cache_def::mem_data_type       mem_data;
    cache_def::mem_req_type        mem_req;

    cache_def::cache_data_type mem_data_data;  assign mem_data_data    = mem_data.data;
               bit             mem_data_ready; assign mem_data_ready   = mem_data.ready;
               bit     [31:0]  mem_req_addr;   assign mem_req.addr     = mem_req_addr;
               bit     [127:0] mem_req_data;   assign mem_req.data     = mem_req_data;
               bit             mem_req_rw;     assign mem_req.rw       = mem_req_rw;
               bit             mem_req_valid;  assign mem_req.valid    = mem_req_valid;

    clocking master_cb@(posedge clk);
        default input #1step output #1;
        input   mem_data_data;
        input   mem_data_ready;
        output  mem_req_addr;
        output  mem_req_data;
        output  mem_req_rw;
        output  mem_req_valid;
    endclocking

   clocking monitor_cb@(posedge clk);
        default input #1step;
        input   mem_data_data;
        input   mem_data_ready;
        input   mem_req_addr;
        input   mem_req_data;
        input   mem_req_rw;
        input   mem_req_valid;
    endclocking

    task get_monitor_mem_pkt (
        output cache_def::mem_data_type data,
        output cache_def::mem_req_type  req
    );
        req.data  = monitor_cb.mem_req_data;
        req.addr  = monitor_cb.mem_req_addr;
        req.rw    = monitor_cb.mem_req_rw;
        req.valid = monitor_cb.mem_req_valid;
        data.data = monitor_cb.mem_data_data;
        data.ready= monitor_cb.mem_data_ready;
    endtask

    task set_master_mem_req(cache_def::mem_req_type req);
        master_cb.mem_req_addr  <= req.addr;
        master_cb.mem_req_data  <= req.data;
        master_cb.mem_req_rw    <= req.rw;
        master_cb.mem_req_valid <= req.valid;        
    endtask

    task get_master_mem_res(output cache_def::mem_data_type res);
        res.data  = master_cb.mem_data_data;
        res.ready = master_cb.mem_data_ready;
    endtask


endinterface : mem_if
