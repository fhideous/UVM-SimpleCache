
class cache_base_test extends uvm_test;

    `uvm_component_utils(cache_base_test)

            cache_env       env;
            cpu_sequence    cpu_seq;
    virtual cpu_if          cpu_vif;
    virtual mem_if          mem_vif;
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction : new

    virtual function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info(get_type_name(), "Build Phase of the testbench is being exexuted", UVM_HIGH)
        if (!cpu_vif_config::get(null, "", "cpu_vif", cpu_vif)) begin
            `uvm_fatal(get_full_name(), "Cannot get mem_if")
        end
        if (!mem_vif_config::get(null, "", "mem_vif", mem_vif)) begin
            `uvm_fatal(get_full_name(), "Cannot get mem_if")
        end
        env = cache_env::type_id::create("env", this);
        cpu_seq = cpu_sequence::type_id::create("cpu_seq", this);
    endfunction : build_phase

    virtual task run_phase(uvm_phase phase);
        cpu_seq.start(env.env_cpu_agent.sequencer);
    endtask

endclass : cache_base_test