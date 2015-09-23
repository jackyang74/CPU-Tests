module mips_alu_test_top();

    //constants here
    parameter OP_ADD        =4'b0000;
    parameter OP_SUB        =4'b0001;
    parameter OP_LEAD_ZERO  =4'b0010;
    parameter OP_LEAD_ONE   =4'b0011;
    parameter OP_AND        =4'b0100;
    parameter OP_SLT        =4'b0101;
    parameter OP_OR         =4'b0110;
    parameter OP_SLTU       =4'b0111;
    parameter OP_ORNOT      =4'b1000;
    parameter OP_XOR        =4'b1001;
    parameter OP_SEB        =4'b1010;
    parameter OP_SEH        =4'b1011;
    parameter OP_ADD_OVER   =4'b1110;
    parameter OP_SUB_OVER   =4'b1111;
    
    parameter CLOCK_TIME = 10;
    
    
    
    //instantiate print
    print_task log();
    
    //your module instance here
    reg [31:0] A_in,B_in;
    reg [3:0] ALU_op;
    wire Zero,Less,Overflow_out;
    wire [31:0] ALU_out;
    
    MIPS_ALU(
        .ALU_op(ALU_op),
        .A_in(A_in),
        .B_in(B_in),
        .Zero(Zero),
        .Less(Less),
        Overflow_out(Overflow_out),
        ALU_out(ALU_out)
    );
    
    //test logic
    initial
    begin
        log.info("Simulation begin\n");
        
        //ADD
        ALU_op = OP_ADD;
        A_in = {$random};       
        B_in = {$random};
        #1 check_value(ALU_out, A_in+B_in);
        check_value(Overflow_out, 0);
        
        //SUB
        ALU_op = OP_SUB;
        A_in = {$random};
        B_in = {$random};
        #1 check_value(ALU_out, A_in-B_in);
        check_value(Overflow_out, 0);
        
        //LEAD_ZERO
        ALU_op = OP_LEAD_ZERO;
        A_in = {{20{1'b0}},{12{1'b1}}};
        #1 check_value(ALU_out, 20);
        A_in = 0;
        #1 check_value(ALU_out, 32);
        A_in = {32{1'b1}};
        #1 check_value(ALU_out, 0);
        
        //LEAD_ONE
        ALU_op = OP_LEAD_ONE;
        A_in = {{20{1'b1}},{12{1'b0}}};
        #1 check_value(ALU_out, 32 - 10);
        A_in = 0;
        #1 check_value(ALU_out, 0);
        A_in = 2**32 - 1;
        #1 check_value(ALU_out, 32);
        
        //AND
        ALU_op = OP_AND;
        A_in = {$random};       
        B_in = {$random};
        #1 check_value(ALU_out, A_in & B_in);
        
        //SLT
        ALU_op = OP_SLT;
        
    end
    
    
    
    
    
    task check_value;
        input[512:0] value;
        input[512:0] expected;
        begin
            if(value != expectated)
                $write("The value %x is not compatible with expected value %x", value, expectated);
        end
    endtask
    
endmodule


module print_task();
    task info;
        input[512:0] msg;
        begin
            $write("INFO at %t: %s", $time, msg);
        end
    endtask
    
    task error;
        input[512:0] msg;
        begin
            $write("ERROR at %t: %s", $time, msg);
        end
    endtask
    
    task fatal;
        input[512:0] msg;
        begin
            $write("FATAL at %t: %s", $time, msg);
            $write("Simulation false!!\n");
            $stop;
        end
    endtask 
endmodule