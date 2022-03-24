class cpu_sequence extends uvm_sequence #(cpu_item);
  
    `uvm_object_utils(cpu_sequence)

    function new(string name="cpu_sequence");
        super.new(name);
    endfunction

    task pre_body();
        `uvm_info(get_type_name(), "pre_body", UVM_LOW)
        if (starting_phase != null) begin
            // starting_phase.raise_objection(this, get_type_name());
            `uvm_info(get_type_name(), "raise objection", UVM_LOW)
        end
    endtask : pre_body

    virtual task body();
        `uvm_info(get_type_name(), "body", UVM_LOW)
        repeat(1) begin
            cpu_item pkt;
            pkt = cpu_item::type_id::create(.name("pkt"), .contxt(get_full_name()));
            // pkt = new("pkt");
            start_item(pkt);
            assert(pkt.randomize());
            `uvm_info(get_type_name(), "Display item: ", UVM_LOW)
            pkt.display();
            finish_item(pkt);
        end      
    endtask : body

    task post_body();
        `uvm_info(get_type_name(), "cpu_sequence post_body", UVM_LOW)
        if (starting_phase != null) begin
            // starting_phase.drop_objection (this, get_type_name());
            `uvm_info(get_type_name(), "drop objection", UVM_LOW)
        end

    endtask : post_body

endclass : cpu_sequence

// ------------------------------
// CACHE : 3 packets
// ------------------------------

// class cache_3_packets extends cpu_sequence;

//     `uvm_object_utils(cache_3_packets)

//     function new(string name="cache_3_packets");
//         super.new(name);
//     endfunction

//     virtual task body();
//         `uvm_info(get_type_name(), "Executing cache_3_packets sequence", UVM_LOW)
//         repeat(3) begin
//             req = cpu_item::type_id::create("req");      //create the req (seq item)
//             wait_for_grant();                            //wait for grant
//             assert(req.randomize());                     //randomize the req                   
//             send_request(req);                           //send req to driver
//             wait_for_item_done();                        //wait for item done from driver
//             get_response(rsp);
//             rsp.print();
//         end      
//   endtask

// endclass : cache_3_packets