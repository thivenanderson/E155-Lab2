module seven_seg_time_mux (
    input  logic [3:0] s1, s2,
    input  logic       reset,
    output logic [6:0] seg1, seg2
);

    logic int_osc;
    logic select;
    logic [3:0] mux_in;
    logic [6:0] decoded_seg;

    logic [14:0] counter;

    // Internal 24 MHz oscillator
    HSOSC #(.CLKHF_DIV(2'b01))
        hf_osc (
            .CLKHFPU(1'b1),
            .CLKHFEN(1'b1),
            .CLKHF(int_osc)
        );

    // Slow down oscillator for display multiplexing
    always_ff @(posedge int_osc) begin
        if (!reset) begin
            counter <= 0;
            select  <= 0;
        end
        else begin
            if (counter == 15'd11999) begin
                counter <= 0;
                select  <= ~select;
            end
            else begin
                counter <= counter + 1;
            end
        end
    end

    // Select which 4-bit input goes into the single decoder
    always_comb begin
        if (select)
            mux_in = s2;
        else
            mux_in = s1;
    end

    // Use ONE instance of your existing seven-segment decoder
    lab1_ta_hex_seg_decoder decoder (
        .s   (mux_in),
        .seg (decoded_seg)
    );

    // Route decoder output to the selected display
    // Common-anode: 7'b1111111 turns all segments off
    always_comb begin
        if (select) begin
            seg1 = 7'b1111111;
            seg2 = decoded_seg;
        end
        else begin
            seg1 = decoded_seg;
            seg2 = 7'b1111111;
        end
    end

endmodule