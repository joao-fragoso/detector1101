module detector(
    input clk, //sinal de relogio
    input rst_n, // reset ativo baixo
    input x,
    output z
);

reg  [2:0] estado_atual;
wire [2:0] prox_estado;

function [2:0] calc_prox_estado;
    input [2:0] estado;
    input entrada;

    calc_prox_estado = estado;

    case(estado)
    3'd1 :
        if (entrada == 1'b1) begin
            calc_prox_estado = 3'd2;
        end else begin
            calc_prox_estado = 3'd0;
        end
    3'd2 :
        if (entrada == 1'b0) begin
            calc_prox_estado = 3'd3;
        end
    3'd3 :
        if (entrada == 1'b1) begin
            calc_prox_estado = 3'd4;
        end else begin
            calc_prox_estado = 3'd0;
        end
    3'd4 :
        calc_prox_estado = 3'd0;
    default : // estado S0
        if (entrada == 1'b1) begin
            calc_prox_estado = 3'd1;
        end
    endcase
endfunction

assign prox_estado = calc_prox_estado(.entrada(x), .estado(estado_atual));
assign z = (estado_atual == 3'd4) ? 1'b1 : 1'b0;

always @(posedge clk) begin
    if (rst_n == 1'b0) begin
        estado_atual = 3'b0;
    end else begin
        estado_atual = prox_estado;
    end
end

endmodule
