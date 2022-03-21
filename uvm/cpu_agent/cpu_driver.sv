
class cpu_driver extends uvm_driver #(cpu_item);
    `uvm_component_utils(cpu_driver)
  
    virtual interface   cpu_if vif;

    function new (string name, uvm_component parent);
        super.new(name, parent);
        `uvm_info(get_type_name(), {"cpu_driver constructor ", get_full_name()}, UVM_LOW)
    endfunction : new

    extern task get_and_drive();
    // extern task reset_signals();

    extern task run_phase(uvm_phase phase);

    function void start_of_simulation_phase(uvm_phase phase);
        `uvm_info(get_type_name(), {"start of simulation for ", get_full_name()}, UVM_LOW)
    endfunction : start_of_simulation_phase

    function void build_phase(uvm_phase phase);
        if ( !cpu_vif_config::get(this, get_full_name(), "cpu_vif", vif) )
            `uvm_fatal("NO_VIF",{"virtual interface must be set for: ",get_full_name(),".cpu_vif"})
    endfunction: build_phase

endclass : cpu_driver

//==============================================
//Implementation
//==============================================

task cpu_driver::run_phase(uvm_phase phase);
    `uvm_info(get_type_name(), " Wait for reset", UVM_LOW)
    // @(posedge vif.rst);
    // @(negedge vif.rst);
    `uvm_info(get_type_name(), " Reset dropped", UVM_LOW)
    forever begin
        seq_item_port.get_next_item(req);
        get_and_drive();
        seq_item_port.item_done();
    end
endtask : run_phase

task cpu_driver::get_and_drive();
    `uvm_info(get_type_name(), $sformatf("Sending Packet :\n%s", req.sprint()), UVM_LOW)
    `uvm_info(get_type_name(), "=============================================================================", UVM_LOW) 
    `uvm_info(get_type_name(), "\t\tSet data to v interface\t\t", UVM_LOW) 
    `uvm_info(get_type_name(), "=============================================================================\t", UVM_LOW)

    vif.set_master_cpu_req(req.cpu_req);

    $display("Data from request: %p", req.cpu_req);
    $display("Data from interface:%p", vif.cpu_req);

endtask : get_and_drive

