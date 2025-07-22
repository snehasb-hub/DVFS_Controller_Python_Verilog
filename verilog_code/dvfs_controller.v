module dvfs_controller (
    input clk,
    input reset,
    input [7:0] cpu_usage,
    output reg [1:0] freq_sel,
    output reg [1:0] volt_sel
);

    parameter LOW_LOAD    = 2'b00;
    parameter MEDIUM_LOAD = 2'b01;
    parameter HIGH_LOAD   = 2'b10;

    reg [1:0] current_state, next_state;

    // State transition
    always @(*) begin
        case (current_state)
            LOW_LOAD:
                next_state = (cpu_usage >= 30) ? MEDIUM_LOAD : LOW_LOAD;
            MEDIUM_LOAD:
                next_state = (cpu_usage < 30) ? LOW_LOAD :
                             (cpu_usage >= 70) ? HIGH_LOAD : MEDIUM_LOAD;
            HIGH_LOAD:
                next_state = (cpu_usage < 70) ? MEDIUM_LOAD : HIGH_LOAD;
            default:
                next_state = LOW_LOAD;
        endcase
    end

    // State register
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= LOW_LOAD;
        else
            current_state <= next_state;
    end

    // Moore Output logic
    always @(*) begin
        case (current_state)
            LOW_LOAD: begin
                freq_sel = 2'b00;  // 0.5 GHz
                volt_sel = 2'b00;  // 0.9 V
            end
            MEDIUM_LOAD: begin
                freq_sel = 2'b01;  // 1.0 GHz
                volt_sel = 2'b01;  // 1.1 V
            end
            HIGH_LOAD: begin
                freq_sel = 2'b10;  // 1.5 GHz
                volt_sel = 2'b10;  // 1.3 V
            end
            default: begin
                freq_sel = 2'b00;
                volt_sel = 2'b00;
            end
        endcase
    end
endmodule
