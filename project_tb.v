module lfsrtst;
reg clock;
reg reset;
reg [3:0] start;
reg load;
wire [12:0] rnd ;
wire q;
reg [12:0] any;

lfsr L(q, clock, reset, start, load, rnd);

initial
//let reflash the register by setting all value to zero for 5 second 
begin
clock = 0;
load = 0;
start = 0;
reset = 0;
#5 reset = 1;
#5 reset = 0;
end

//now lets innitialise the lsfr
initial begin
#100 start = 4'b1001;
load = 1;
#100 load = 0;
end

always
#50 clock = !clock;

always
#4600 $display(any);

always begin
    #351 any[0]=q;
    #350 any[1]=q;
    #350 any[2]=q;
    #350 any[3]=q;
    #350 any[4]=q;
    #350 any[5]=q;
    #350 any[6]=q;
    #350 any[7]=q;
    #350 any[8]=q;
    #350 any[9]=q;
    #350 any[10]=q;
    #350 any[11]=q;
    #350 any[12]=q;
end

initial begin
    #100000 $finish;
end

initial begin
    $dumpfile("Randoms.vcd");
    $dumpvars;
  end

endmodule