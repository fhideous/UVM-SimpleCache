
class cpu_if_monitor extends uvm_monitor;

    uvm_analysis_port#(cpu_item)    item_collected_port_cpu;
    
    `uvm_component_utils(cpu_if_monitor)
  
    virtual interface cpu_if    vif;
    cpu_item                    pkt;

    // Count packets collected
    int                         num_pkt_col;

    function new (string name, uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), {"cpu_monitor constructor ", get_full_name()}, UVM_LOW)
    endfunction : new

    function void build_phase( uvm_phase phase );
        super.build_phase(phase);
        item_collected_port_cpu = new("item_collected_port_cpu", this);
        if ( !cpu_vif_config::get(this, get_full_name(), "cpu_vif", vif) )
            `uvm_fatal("NOVIF", {"virtual interface must be set for: ", get_full_name(), ".cpu_vif"});
    endfunction : build_phase

    extern task reset_phase( uvm_phase phase );
    extern task run_phase( uvm_phase phase );

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_LOW)
    endfunction : start_of_simulation_phase

    function void report_phase(uvm_phase phase);
        `uvm_info(get_type_name(), $sformatf("Report: cpu_if_monitor collected %0d packets", num_pkt_col), UVM_LOW)
    endfunction : report_phase

endclass : cpu_if_monitor

//==============================================
//Implementation
//==============================================

task cpu_if_monitor::reset_phase( uvm_phase phase );
    // @(posedge vif.rst);
    // @(negedge vif.rst);
    `uvm_info(get_type_name(), "Detected Reset Done", UVM_LOW)
endtask

task cpu_if_monitor::run_phase( uvm_phase phase );
    forever begin 
        pkt = cpu_item::type_id::create("cpu_item", this);
        $display("Wait for monito_cb");
        @(vif.monitor_cb);
        $display("monito_cb was raised");
        vif.get_monitor_cpu_pkt(pkt.cpu_req, pkt.cpu_res);
        item_collected_port_cpu.write(pkt);
        `uvm_info(get_type_name(), $sformatf("Packet Collected :\n%s", pkt.sprint()), UVM_LOW)
        num_pkt_col++;
    end
endtask : run_phase 
