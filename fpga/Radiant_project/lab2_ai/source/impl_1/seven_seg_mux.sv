module seven_seg_mux (
    input  logic       clk,
    input  logic [3:0] in0,
    input  logic [3:0] in1,
    output logic [6:0] seg0,
    output logic [6:0] seg1
);

    logic select;
    logic [3:0] digit;
    logic [6:0] decoded_seg;

    // Toggle between the two displays
    always_ff @(posedge clk) begin
        select <= ~select;
    end

    // Select which input goes into the single decoder
    always_comb begin
        if (select)
            digit = in1;
        else
            digit = in0;
    end

    // Single common-anode seven-segment decoder
    // Format: abcdefg
    always_comb begin
        case (digit)
            4'h0: decoded_seg = 7'b0000001;
            4'h1: decoded_seg = 7'b1001111;
            4'h2: decoded_seg = 7'b0010010;
            4'h3: decoded_seg = 7'b0000110;
            4'h4: decoded_seg = 7'b1001100;
            4'h5: decoded_seg = 7'b0100100;
            4'h6: decoded_seg = 7'b0100000;
            4'h7: decoded_seg = 7'b0001111;
            4'h8: decoded_seg = 7'b0000000;
            4'h9: decoded_seg = 7'b0000100;
            4'hA: decoded_seg = 7'b0001000;
            4'hB: decoded_seg = 7'b1100000;
            4'hC: decoded_seg = 7'b0110001;
            4'hD: decoded_seg = 7'b1000010;
            4'hE: decoded_seg = 7'b0110000;
            4'hF: decoded_seg = 7'b0111000;
            default: decoded_seg = 7'b1111111;
        endcase
    end

    // Route the single decoder output to the selected display
    // 1111111 = all segments off for common anode
    always_comb begin
        if (select) begin
            seg0 = 7'b1111111;
            seg1 = decoded_seg;
        end
        else begin
            seg0 = decoded_seg;
            seg1 = 7'b1111111;
        end
    end

endmodule