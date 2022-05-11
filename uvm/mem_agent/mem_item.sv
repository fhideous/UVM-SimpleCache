class mem_item extends uvm_sequence_item;

  `uvm_object_utils(mem_item)
  
    mem_data_type        mem_data;
    mem_req_type         mem_req;

    rand bit            packet_delay;

    function new (string name = "mem_item");
      super.new(name);
        `uvm_info(get_type_name(), {"mem_item constructor ", get_full_name()}, UVM_LOW)
    endfunction : new

    constraint packet_constr { packet_delay >= 0; packet_delay < 20;   }

    // extern virtual function cpu_req_type cpu_req_pack();
    // extern virtual function void cpu_req_unpack(const ref cpu_req_type cpu_req);
    extern virtual function void display();

    function void post_randomize();
    endfunction : post_randomize

endclass: mem_item

//==============================================
//Implementation
//==============================================

function void mem_item::display();
    $display(   "\n---------- PACKET ---------- "       );
    // $display(   "tag:\t %h ",          addr_tag         );
    // $display(   "index:\t %d ",        addr_index       );
    // $display(   "offset:\t %h ",       write_posit      );
    // $display(   "data:\t %h ",         cpu_data         );
    // $display(   "rw:\t %h ",           cpu_rw           );
    // $display(   "valid:\t %h ",        cpu_valid        );
    $display(   "------------ END ------------ \n"      );
endfunction : display