`ifndef SEQ
`define SEQ

class my_transaction extends uvm_sequence_item;

    `uvm_object_utils(my_transaction)

    rand bit cmd;
    rand int addr;
    rand int data;

    constraint c_addr { addr >= 0; addr < 256; }
    constraint c_data { data >= 0; data < 256; }

    function new (string name = "");
        super.new(name);
    endfunction

endclass: my_transaction

class my_sequence extends uvm_sequence#(my_transaction);

    `uvm_object_utils(my_sequence)

    function new (string name = "");
        super.new(name);
    endfunction

    task body;
        repeat(8) begin
            req = my_transaction::type_id::create("req");               
                // Tạo đối tượng mới của lớp transaction
                // type_id::create: Tạo các đối tượng mới của lớp chỉ định (Ở đây là transaction)
            start_item(req);
                // Phương thức của class sequence: Bắt đầu một transaction
                // Khi gọi thì sequence sẽ tạo và gửi req đến các thành phần khác trong environment

            if (!req.randomize()) begin
                `uvm_error("MY_SEQUENCE", "Randomize failed.");
            end
            finish_item(req);
        end
    endtask: body

endclass: my_sequence
`endif 