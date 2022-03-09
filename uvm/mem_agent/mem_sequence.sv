class mem_model extends uvm_object;

    `uvm_object_utils(mem_model)

    logic [127:0] mem [1023:0];

    function new(string name="mem_model");
        super.new(name);
    endfunction : new

    function bit [127:0] read(
        input bit [31:0] addr
    );
        `uvm_info( get_type_name(), $sformatf("End of read method"), UVM_LOW)
    endfunction : read

    virtual function void init();
        // mem = new();
        assert(randomize(mem));
        $display("memory init:  = %p", mem);
    endfunction : init 

endclass : mem_model

class mem_sequence extends uvm_sequence #(mem_item);
    `uvm_object_utils(mem_sequence)

    `uvm_declare_p_sequencer( mem_sequencer )
    
    mem_model mem;
   
    function new(string name="mem_sequence");
        super.new(name);
        mem = new("mem_model");
        mem.init();
    endfunction

    virtual task body();
        forever begin
            req = mem_item::type_id::create("mem_cache_req");
            rsp = mem_item::type_id::create("mem_cache_rsp");
            p_sequencer.mem_fifo.get(req);
            start_item(rsp);
            rsp.mem_data.data = mem.read(req.mem_req.addr);
            finish_item(rsp);
        end
    endtask : body

endclass : mem_sequence