module tb_vending;
    reg clk, rst;
    reg [1:0] coin;
    wire dispense;
    wire [1:0] change;
    vending_machine uut(clk,rst,coin,dispense,change);
    initial begin clk=0; forever #5 clk=~clk; end
    initial begin
        $dumpfile("vend.vcd"); $dumpvars(0,tb_vending);
        rst=1; coin=0; #12 rst=0;
        coin=2'b01; #10; //5
        coin=2'b10; #10; //10 -> total 15 -> dispense
        coin=0; #10;
        coin=2'b10; #10; //10
        coin=2'b10; #10; //10 -> total 20 -> dispense+change
        coin=0; #10;
        #20 $finish;
    end
    initial $monitor("T=%0t coin=%b dispense=%b change=%b state=%d",$time,coin,dispense,change,uut.state);
endmodule
