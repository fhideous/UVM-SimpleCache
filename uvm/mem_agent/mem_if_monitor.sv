
class mem_if_monitor extends uvm_monitor;

    uvm_analysis_port#(mem_item)    item_collected_port_mem;
    
    `uvm_component_utils(mem_if_monitor)
  
    virtual interface mem_if    vif;
    mem_item                    pkt;
    // Count packets collected
    int                         num_pkt_col;

    function new (string name, uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), {"mem_monitor constructor ", get_full_name()}, UVM_LOW)
    endfunction : new

    function void build_phase( uvm_phase phase );
        if ( !mem_vif_config::get(this, get_full_name(), "mem_vif", vif) )
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".mem_vif"});
        item_collected_port_mem = new("item_collected_port_mem", this);

    endfunction : build_phase

    extern task reset_phase( uvm_phase phase );
    extern task run_phase( uvm_phase phase );

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_LOW)
    endfunction : start_of_simulation_phase

    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Report: mem_if_monitor collected %0d packets", num_pkt_col), UVM_LOW)
    endfunction : report_phase

endclass : mem_if_monitor

//==============================================
//Implementation
//==============================================

task mem_if_monitor::reset_phase( uvm_phase phase );
    // @(posedge vif.rst);
    // @(negedge vif.rst);
    `uvm_info(get_type_name(), "Detected Reset Done", UVM_LOW)
endtask

task mem_if_monitor::run_phase( uvm_phase phase );
    forever begin
        pkt = mem_item::type_id::create("pkt", this);
        @(vif.monitor_cb);
        item_collected_port_mem.write(pkt);
        `uvm_info(get_type_name(), $sformatf("Packet Collected :\n%s", pkt.sprint()), UVM_LOW)
        num_pkt_col++;
    end
endtask : run_phase 