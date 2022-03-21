
class mem_driver extends uvm_driver #(mem_item);
    `uvm_component_utils(mem_driver)
  
    virtual interface   mem_if vif;

    function new (string name, uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), {"mem_driver constructor ", get_full_name()}, UVM_LOW)
    endfunction : new

    extern task get_and_drive();
    // extern task reset_signals();

    extern task run_phase(uvm_phase phase);

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_LOW)
    endfunction : start_of_simulation_phase

    function void build_phase(uvm_phase phase);
        if ( !mem_vif_config::get(this, get_full_name(), "mem_vif", vif) )
            `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".mem_vif"})
    endfunction: build_phase

endclass : mem_driver

//==============================================
//Implementation
//==============================================

task mem_driver::run_phase(uvm_phase phase);
    // @(posedge vif.rst);
    // @(negedge vif.rst);
    `uvm_info(get_type_name(), "Reset dropped", UVM_MEDIUM)
    forever begin
        seq_item_port.get_next_item(req);
        get_and_drive();
        seq_item_port.item_done();
    end
endtask : run_phase

task mem_driver::get_and_drive();
    `uvm_info(get_type_name(), $sformatf("Sending Packet :\n%s", req.sprint()), UVM_LOW)
     
     vif.mem_data   <= req.mem_data;
     vif.mem_req    <= req.mem_req;
endtask : get_and_drive

