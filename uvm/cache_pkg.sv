
package cache_pkg;

    import uvm_pkg::*;
    import cache_def::*;
    
    typedef uvm_config_db#(virtual cpu_if) cpu_vif_config;
    typedef uvm_config_db#(virtual mem_if) mem_vif_config;

    `include "uvm_macros.svh"

    `include "cpu_item.sv"
    `include "cpu_sequence.sv"
    `include "cpu_sequencer.sv"
    `include "cpu_if_monitor.sv"
    `include "cpu_driver.sv"
    `include "cpu_agent.sv"

    `include "mem_item.sv"
    `include "mem_sequencer.sv"
    `include "mem_sequence.sv"
    `include "mem_if_monitor.sv"
    `include "mem_driver.sv"
    `include "mem_agent.sv"

    `include "cache_env.sv"
    `include "cache_scoreboard.sv"
    `include "cache_base_test.sv"

endpackage