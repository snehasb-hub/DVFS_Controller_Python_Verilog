`timescale 1ns / 1ps

module tb_dvfs;

    reg clk = 0;
    reg reset;
    reg [7:0] cpu_usage;
    wire [1:0] freq_sel;
    wire [1:0] volt_sel;

    // Instantiate the DVFS controller
    dvfs_controller uut (
        .clk(clk),
        .reset(reset),
        .cpu_usage(cpu_usage),
        .freq_sel(freq_sel),
        .volt_sel(volt_sel)
    );

    // Clock generation
    always #5 clk = ~clk;

    initial begin
        $display("Starting DVFS Simulation...");
        reset = 1;
        cpu_usage = 0;
        #10;
        reset = 0;

        // Test various CPU usage levels
        cpu_usage = 10; #20;
        cpu_usage = 35; #20;
        cpu_usage = 75; #20;
        cpu_usage = 65; #20;
        cpu_usage = 25; #20;
        cpu_usage = 90; #20;
        cpu_usage = 15; #20;

        $stop;
    end
endmodule
