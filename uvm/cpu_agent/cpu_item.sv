class cpu_item extends uvm_sequence_item;

  `uvm_object_utils(cpu_item)

    rand bit  [17:0]    addr_tag;
    rand bit  [9:0]     addr_index;
    rand bit  [4:0]     write_pos;    
    bit       [31:0]    cpu_req_addr = { addr_tag, addr_index, write_pos };

    rand bit  [31:0]    cpu_data;
    rand bit            cpu_rw;
    rand bit            cpu_valid;

    cpu_req_type        cpu_req = '{ cpu_req_addr, cpu_data, cpu_rw, cpu_valid };
    cpu_result_type     cpu_res;

    rand int            packet_delay;

    function new (string name = "cpu_item");
      super.new(name);
    endfunction : new

    constraint packet_constr  { packet_delay >= 0; packet_delay < 20;   }
    constraint default_packet { cpu_valid == 0;                         }

    // extern virtual function void cpu_req_unpack(const ref cpu_req_type cpu_req);
    extern virtual function void display();

    function void post_randomize();
    endfunction : post_randomize

endclass: cpu_item

//==============================================
//Implementation
//==============================================

function void cpu_item::display();
    $display(   "\n---------- PACKET ---------- "       );
    $display(   "tag:\t %h ",          addr_tag         );
    $display(   "index:\t %d ",        addr_index       );
    $display(   "offset:\t %h ",       write_pos        );
    $display(   "data:\t %h ",         cpu_data         );
    $display(   "rw:\t %h ",           cpu_rw           );
    $display(   "valid:\t %h ",        cpu_valid        );
    $display(   "------------ END ------------ \n"      );
endfunction : display