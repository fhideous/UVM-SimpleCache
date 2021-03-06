`timescale 1ns/1ps

module cache_tb_top;

    import uvm_pkg::*;
    import cache_pkg::*;

    logic   clk;
    logic   rst;

    cpu_if cpu_if_inst ( .clk(clk), .rst(rst)  );
    mem_if mem_if_inst ( .clk(clk), .rst(rst)  );

    initial begin
      cpu_vif_config::set(null, "*", "cpu_vif", cpu_if_inst);
      mem_vif_config::set(null, "*", "mem_vif", mem_if_inst);
      run_test();
    end

    dm_cache_fsm dut
    ( 
        .clk_i      (  clk                  ),
        .reset_i    (  rst                  ),
        .cpu_req    (  cpu_if_inst.cpu_req  ),
        .mem_data   (  mem_if_inst.mem_data ),
        .mem_req    (  mem_if_inst.mem_req  ),
        .cpu_res    (  cpu_if_inst.cpu_res  )
    );

    initial begin
        $timeformat(-9, 0, " ns", 5);
        rst <= 1'b0;
        #100;
        rst <= 1'b1;
        #100;
        @(negedge clk)
            #1 rst <= 1'b0;
        @(negedge clk)
            #1 rst <= 1'b0;
    end

    initial begin
        clk = 1'b0;
        forever begin
            #10 clk = ~clk;
       end
    end


endmodule
