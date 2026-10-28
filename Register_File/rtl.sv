module regfile(
    input  logic        clk,
    input  logic        we3,
    input  logic [4:0]  a1,
    input  logic [4:0]  a2,
    input  logic [4:0]  a3,
    input  logic [31:0] wd3,
    output logic [31:0] rd1,
    output logic [31:0] rd2
);

    logic [31:0] rf [31:0];

    // three-ported register file
    // write port 3 on rising edge of clock (x0 cannot be written)
    always_ff @(posedge clk) begin
        if (we3 && (a3 != 5'd0)) begin
            rf[a3] <= wd3;
        end
    end

    // read ports 1 & 2 combinationally (x0 is hardwired to 0)
    assign rd1 = (a1 != 5'd0) ? rf[a1] : 32'd0;
    assign rd2 = (a2 != 5'd0) ? rf[a2] : 32'd0;

endmodule
