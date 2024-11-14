module register_file (
    input  clk,rst,
    input  [4:0] A1,
    input  [4:0] A2,
    input  [4:0] Writeadd,
    input  RegWrite,
    input  [31:0] WriteData,
    output  [31:0] ReadData1,
    output  [31:0] ReadData2
);
 integer i;
    reg [31:0] register_array [31:0];


     always @(posedge clk or negedge rst) begin
        if (!rst) begin
            for (i = 0; i <= 31; i = i + 1) 
                register_array[i] = 32'b0;
end    
    else if (RegWrite) begin
            register_array[Writeadd] <= WriteData;
        end
    end

    assign ReadData1 = register_array[A1];
    assign ReadData2 = register_array[A2];

endmodule
