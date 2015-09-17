module mips_alu_test_top;
	
endmodule


module print_task;
	task info;
		input[512:1] msg;
		begin
			$write("INFO at %t: %s", $time, msg);
		end
	endtask
	
	task error;
		input[512:1] msg;
		begin
			$write("ERROR at %t: %s", $time, msg);
		end
	endtask
	
	task fatal;
		input[512:1] msg;
		begin
			$write("FATAL at %t: %s", $time, msg);
			$write("Simulation false!!\n");
			$stop;
		end
	endtask	
endmodule