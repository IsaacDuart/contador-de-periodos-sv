module contador_de_periodos #(parameter CICLOS_POR_MS = 1000)(
    input logic clk, rst,
    input logic sinal_in,
    input logic start,
    output logic done, ready,
    output logic [31:0] periodo_ms
);
    typedef enum logic [1:0] {
        ESTACIONADO,
        CONTANDO,
      	FEITO
    } estado_t;
 
    estado_t estado_atual, proximo_estado;
    logic anterior_reg, anterior_next;
    logic [31:0] contador_ciclos_reg, contador_ciclos_next;
    logic [31:0] contador_ms_reg, contador_ms_next;
    logic [31:0] periodo_ms_reg, periodo_ms_next;
 

    always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
    
        estado_atual <= ESTACIONADO;
        contador_ciclos_reg <= 0;
        contador_ms_reg <= 0;
        periodo_ms_reg <= 0;
        anterior_reg <= 0;
    end else begin
        estado_atual <= proximo_estado;
        contador_ciclos_reg <= contador_ciclos_next;
        contador_ms_reg <= contador_ms_next;
        periodo_ms_reg <= periodo_ms_next;
        anterior_reg <= anterior_next;
       
    end
end

 
    always_comb begin
     
        proximo_estado = estado_atual;
        contador_ciclos_next = contador_ciclos_reg;
        contador_ms_next = contador_ms_reg;
        periodo_ms_next = periodo_ms_reg;
        anterior_next = sinal_in;
        
        done = 0;
        ready = 0;
 
        case (estado_atual)
            ESTACIONADO: begin
                ready = 1'b1;
                if (start == 1'b1 && sinal_in == 1'b1 && anterior_reg == 1'b0) begin
                    proximo_estado = CONTANDO;
                    contador_ciclos_next = 0;
                    contador_ms_next = 0;
                end
            end
            CONTANDO: begin
                if (contador_ciclos_reg < CICLOS_POR_MS - 1) begin
                    contador_ciclos_next = contador_ciclos_reg + 1;
                end else begin
                    contador_ciclos_next = 0;
                    contador_ms_next = contador_ms_reg + 1;
                end
                if (sinal_in == 1'b1 && anterior_reg == 1'b0) begin
                    proximo_estado = FEITO;
                
                    
                end
            end
          FEITO: begin
                  	periodo_ms_next = contador_ms_reg;
          			done = 1'b1;
                    proximo_estado = ESTACIONADO;
          end
        endcase
    end

    assign periodo_ms = periodo_ms_reg;

endmodule