`timescale 1ns/1ns

module im_tb;

parameter CLK_PERIOD = 10; // ns

// inputs
reg clk;
reg rst;

initial begin
    $dumpfile("test.vcd");
    $dumpvars(0,im_tb);

    $display("im testing.\n");
    taylor.pc = 0;
    clk = 0;

    // ADDI
    taylor.rom[0] = 32'h20100005;
    // ADDI
    taylor.rom[1] = 32'h20100006;
    // ADD
    taylor.rom[2] = 32'h012A4820;
    // SUB
    taylor.rom[3] = 32'h012A4822;
    // SUB
    taylor.rom[4] = 32'h012A4822;
    // BEQ
    taylor.rom[5] = 32'h112A002A;
    // BEQ
    taylor.rom[6] = 32'h112A002B;
    // LOAD WORD
    taylor.rom[7] = 32'h8C0A0000;
    // ORI
    taylor.rom[8] = 32'h34E700FF;    
end

// clk generator
always #((CLK_PERIOD)/2) clk <= ~clk; // 10ns

// Monitor to display current instruction
integer counter = 0;

always @(posedge clk) begin
    if (counter < 9) begin
        //$display("[%0d], PC: %0d, Instruction: %8h", $time, taylor.pc, taylor.inst);
        counter <= counter + 1;
    end
    else begin
        $display("taylor fetching stopped after 14th boyfriend.");
        $finish;
    end
end

taylor taylor(
    .clk(clk),
    .rst(rst)
);

endmodule