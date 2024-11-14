module PC (
    input clk,          // Clock signal
    input reset,        // Reset signal
    input [31:0] next, // Next instruction address
    output reg [31:0] adress // Current instruction address
);

always @(posedge clk or posedge reset) begin
    if (reset)
        adress <= 32'b0; // Reset adress to 0
    else
        adress <= next; // Update adress to next instruction address
end

endmodule

