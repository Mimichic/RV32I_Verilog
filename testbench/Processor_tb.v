

module stimulus ();
    
    reg clock;
    reg reset;
   

    // Instantiating the processor!!!
    PROCESSOR test_processor(clock,reset);

  
    initial begin
        reset = 1;
        #5 reset = 0;
    end

    initial begin
        clock = 0;
        forever #5 clock = ~clock;
    end

    initial
    #80 $finish;
    
endmodule