interface cpu_if (input logic clk, input logic rst );

    timeunit        1ns;
    timeprecision   100ps;

    cache_def::cpu_req_type        cpu_req;
    cache_def::cpu_result_type     cpu_res;

    bit [31:0] cpu_req_addr;  assign cpu_req.addr  = cpu_req_addr ;
    bit [31:0] cpu_req_data;  assign cpu_req.data  = cpu_req_data ;
    bit        cpu_req_rw;    assign cpu_req.rw    = cpu_req_rw   ;
    bit        cpu_req_valid; assign cpu_req.valid = cpu_req_valid;
    bit [31:0] cpu_res_data;  assign cpu_res_data  = cpu_res.data;
    bit        cpu_res_ready; assign cpu_res_ready = cpu_res.ready;

    clocking master_cb@(posedge clk);
        default input #1step output #1;
        output cpu_req_addr;
        output cpu_req_data;
        output cpu_req_rw;
        output cpu_req_valid;
        input  cpu_res_data;
        input  cpu_res_ready;
    endclocking

    clocking monitor_cb@(posedge clk);
        default input #1step;
        input cpu_req_addr;
        input cpu_req_data;
        input cpu_req_rw;
        input cpu_req_valid;
        input cpu_res_data;
        input cpu_res_ready;
    endclocking

    task get_monitor_cpu_pkt (
        output cache_def::cpu_req_type    req,
        output cache_def::cpu_result_type res
    );
        req.addr  = monitor_cb.cpu_req_addr;
        req.data  = monitor_cb.cpu_req_data;
        req.rw    = monitor_cb.cpu_req_rw;
        req.valid = monitor_cb.cpu_req_valid;
        res.data  = monitor_cb.cpu_res_data;
        res.ready = monitor_cb.cpu_res_ready;
    endtask

    task set_master_cpu_req(cache_def::cpu_req_type req);
        master_cb.cpu_req_addr  <= req.addr;
        master_cb.cpu_req_data  <= req.data;
        master_cb.cpu_req_rw    <= req.rw;
        master_cb.cpu_req_valid <= req.valid;
    endtask

    task get_master_cpu_res(output cache_def::cpu_result_type res);
        res.data  = master_cb.cpu_res_data;
        res.ready = master_cb.cpu_res_ready;
    endtask

    function void display();
        $display(   "\n---------- PACKET ---------- "         );
        // $display(   "cpu_req:\t 0x%p",          cpu_req      );
        // $display(   "index:\t %0d ",        addr_index       );
        // $display(   "offset:\t 0x%0h ",       write_pos      );
        // $display(   "data:\t 0x%0h ",         cpu_data       );
        // $display(   "rw:\t 0b%0h ",           cpu_rw         );
        // $display(   "valid:\t 0b%0h ",        cpu_valid      );
        $display(   "------------ END ------------ \n"        );
    endfunction : display

endinterface : cpu_if
