class cpu_sequence extends uvm_sequence #(cpu_item);
  
    `uvm_object_utils(cpu_sequence)

    function new(string name="cpu_sequence");
        super.new(name);
    endfunction

    task pre_body();
        uvm_phase phase;
        `ifdef UVM_VERSION_1_2
            phase = get_starting_phase();
        `else
            phase = starting_phase;
        `endif
        if (phase != null) begin
            phase.raise_objection(this, get_type_name());
            `uvm_info(get_type_name(), "raise objection", UVM_MEDIUM)
        end
    endtask : pre_body

    task post_body();
        uvm_phase phase;
        `ifdef UVM_VERSION_1_2
            phase = get_starting_phase();
        `else
            phase = starting_phase;
        `endif
        if (phase != null) begin
            phase.drop_objection(this, get_type_name());
            `uvm_info(get_type_name(), "drop objection", UVM_MEDIUM)
        end
    endtask : post_body

endclass : cpu_sequence

// ------------------------------
// CACHE : 3 packets
// ------------------------------

class cache_3_packets extends cpu_sequence;

  `uvm_object_utils(cache_3_packets)

    function new(string name="cache_3_packets");
        super.new(name);
    endfunction

  virtual task body();
    `uvm_info(get_type_name(), "Executing cache_3_packets sequence", UVM_LOW)
    repeat(3) begin
        req = cpu_item::type_id::create("req");      //create the req (seq item)
        wait_for_grant();                            //wait for grant
        assert(req.randomize());                     //randomize the req                   
        send_request(req);                           //send req to driver
        wait_for_item_done();                        //wait for item done from driver
        get_response(rsp);
        rsp.print();
    end      
  endtask

endclass : cache_3_packets