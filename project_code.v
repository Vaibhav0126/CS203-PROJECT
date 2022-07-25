// module for flipflop 
// as flipflop is general concept so the code of the flipflop is taken from previous labs 
module flipflop(q, clock, reset, d);

input clock, reset,d;
output q;
reg q;

always @(posedge reset)
begin
    if (reset)
    #1 q = 0;
    else
    q = #1 d;
end

always @(posedge clock )
begin
    if (reset)
    #1 q = 0;
    else
    q = #1 d;
end

endmodule

//module for multiplexer 
//this is also a genereal concept 
module mux(q, c, a, b);

output q;
reg q;
input c, a, b;
wire notc;

always @(c)
    q = (c & a) | (notc & b);

always @(notc)
    q = (c & a) | (notc & b);

always @(a)
    q = (c & a) | (notc & b);

always @(b)
    q = (c & a) | (notc & b);

not (notc, c);

endmodule;

//lfsr (linear feedback shift register)
//we are using this register to generate each bit by tapping some bit of lfsr
module lfsr(q, clock, reset, start, load , rnd);
// q is used to store each bit of random number
//reset is used  to set the value in flipflop
//start is used to initialise the lfsr 
//load is used to set the value in mux
//rnd is used to store the random number
output q;
input clock;
input [3:0] start;
input load,reset;
output [12:0] rnd;
wire [3:0] temp_out, temp_in;
//temp_out and temp_in are used to keep track of input and output of lfsr reister
wire nextbit;
//tempory nextbit is store in this wire 

flipflop F[3:0] (temp_out, clock, reset, temp_in);
// we are using 4(2:1) mux 
// each for each load bit 
mux M1[3:0] (temp_in, load, start, {temp_out[2],temp_out[1],temp_out[0],nextbit});
// we are tapping 2 and 3 bit of lfsr to generate the next bit or random number 
xor G1(nextbit, temp_out[2], temp_out[3]);
//q is storing each next bit
assign q = nextbit;

endmodule