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
        rst <= 1'b0;
        @(negedge clk)
            #1 rst <= 1'b1;
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
