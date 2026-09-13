// Author: Kuruva Sravani | ECE 3rd Year | Kurnool
// Project: 20 | Vending Machine Controller FSM
// Price: Rs 15 | Inputs: 5rs, 10rs | Outputs: dispense, change
// Tools: Verilog | EDA Playground | 20 Projects Portfolio

module vending_machine (
    input clk, rst,
    input [1:0] coin, // 01=5rs, 10=10rs
    output reg dispense,
    output reg [1:0] change // 01=5rs change
);
    parameter S0=3'b000, S5=3'b001, S10=3'b010, S15=3'b011, S20=3'b100;
    reg [2:0] state, next_state;

    always @(posedge clk or posedge rst) begin
        if(rst) state <= S0;
        else state <= next_state;
    end

    always @(*) begin
        case(state)
            S0: begin
                if(coin==2'b01) next_state=S5;
                else if(coin==2'b10) next_state=S10;
                else next_state=S0;
            end
            S5: begin
                if(coin==2'b01) next_state=S10;
                else if(coin==2'b10) next_state=S15;
                else next_state=S5;
            end
            S10: begin
                if(coin==2'b01) next_state=S15;
                else if(coin==2'b10) next_state=S20;
                else next_state=S10;
            end
            S15, S20: next_state=S0;
            default: next_state=S0;
        endcase
    end

    always @(*) begin
        dispense=0; change=0;
        if(state==S15) begin dispense=1; change=0; end
        else if(state==S20) begin dispense=1; change=2'b01; end
    end
endmodule
