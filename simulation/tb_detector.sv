`timescale 1ns/10ps
module tb_detector ();

reg rst_n = 1'b0;
reg x = 1'b0;
reg clk = 1'b0;
wire z;

int contador = -1;

detector detector_instancia(
    .clk(clk),
    .x(x),
    .rst_n(rst_n),
    .z(z)
);

always
    #5 clk = ~clk;

always @(posedge clk) begin
    if (rst_n == 1'b0)
        contador = -1;
    else
        contador = contador + 1; 
end

task wait_and_invert_x(input int n);
    repeat(n) begin
        @(posedge clk) #0.01;
    end
    x = ~x;
endtask

initial begin
    repeat (3) begin
        @(posedge clk) #0.1;
    end
    rst_n = 1'b1;
    //0 x=0
    wait_and_invert_x(2);
    //2 x=1
    wait_and_invert_x(2);
    //4
    wait_and_invert_x(2);
    //6
    wait_and_invert_x(2);
    //8
    wait_and_invert_x(1);
    //9
    wait_and_invert_x(3);
    //12
    wait_and_invert_x(1);
    //13
    wait_and_invert_x(2);
    //15
    wait_and_invert_x(1);
    //16
    wait_and_invert_x(1);
    //17
    wait_and_invert_x(1);
    //18
    wait_and_invert_x(4);
    //22
    wait_and_invert_x(1);
    //23
    wait_and_invert_x(5);
    //28
    wait_and_invert_x(1);
    //29
    wait_and_invert_x(1);
    //30
    @(posedge clk) #0.1;
    @(posedge clk) #0.1;
    @(posedge clk) #0.1;
    $finish;  // parar a simulacao
end

endmodule