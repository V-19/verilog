/* Generated by Yosys 0.9 (git sha1 1979e0b) */

(* src = "cont1.v:1" *)
module cont1(Q, RCO, clk, enb, modo, D);
  (* src = "cont1.v:23" *)
  wire [3:0] _00_;
  (* src = "cont1.v:23" *)
  wire _01_;
  (* src = "cont1.v:23" *)
  wire _02_;
  (* src = "cont1.v:23" *)
  wire _03_;
  (* src = "cont1.v:23" *)
  wire _04_;
  (* src = "cont1.v:28" *)
  (* unused_bits = "4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31" *)
  wire [31:0] _05_;
  (* src = "cont1.v:50" *)
  wire _06_;
  (* src = "cont1.v:50" *)
  wire _07_;
  (* src = "cont1.v:56" *)
  wire _08_;
  (* src = "cont1.v:56" *)
  wire _09_;
  (* src = "cont1.v:65" *)
  wire _10_;
  (* src = "cont1.v:65" *)
  wire _11_;
  (* src = "cont1.v:65" *)
  wire _12_;
  (* src = "cont1.v:50" *)
  wire _13_;
  (* src = "cont1.v:56" *)
  wire _14_;
  (* src = "cont1.v:65" *)
  wire _15_;
  (* src = "cont1.v:65" *)
  wire _16_;
  (* src = "cont1.v:65" *)
  wire _17_;
  wire [3:0] _18_;
  wire _19_;
  (* src = "cont1.v:29" *)
  (* unused_bits = "4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31" *)
  wire [31:0] _20_;
  (* src = "cont1.v:30" *)
  (* unused_bits = "4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31" *)
  wire [31:0] _21_;
  (* src = "cont1.v:13" *)
  input [3:0] D;
  (* src = "cont1.v:16" *)
  output [3:0] Q;
  reg [3:0] Q;
  (* src = "cont1.v:17" *)
  output RCO;
  reg RCO;
  (* src = "cont1.v:12" *)
  input clk;
  (* src = "cont1.v:12" *)
  input enb;
  (* src = "cont1.v:14" *)
  input [1:0] modo;
  assign _05_ = Q + (* src = "cont1.v:28" *) 32'd1;
  assign _06_ = Q == (* src = "cont1.v:50" *) 4'hf;
  assign _08_ = ! (* src = "cont1.v:65" *) Q;
  assign _10_ = Q == (* src = "cont1.v:65" *) 4'h1;
  assign _11_ = Q == (* src = "cont1.v:65" *) 4'h2;
  assign _13_ = _06_ && (* src = "cont1.v:50" *) _07_;
  assign _14_ = _08_ && (* src = "cont1.v:56" *) _09_;
  assign _15_ = _17_ && (* src = "cont1.v:65" *) _12_;
  assign _16_ = _08_ || (* src = "cont1.v:65" *) _10_;
  assign _17_ = _16_ || (* src = "cont1.v:65" *) _11_;
  always @(posedge clk)
      Q <= _00_;
  always @(posedge clk)
      RCO <= _01_;
  assign _02_ = _13_ ? (* full_case = 32'd1 *) (* src = "cont1.v:50" *) 1'h1 : _03_;
  assign _01_ = enb ? (* full_case = 32'd1 *) (* src = "cont1.v:24" *) _02_ : RCO;
  function [3:0] _36_;
    input [3:0] a;
    input [15:0] b;
    input [3:0] s;
    (* full_case = 32'd1 *)
    (* src = "cont1.v:31|cont1.v:27" *)
    (* parallel_case *)
    casez (s)
      4'b???1:
        _36_ = b[3:0];
      4'b??1?:
        _36_ = b[7:4];
      4'b?1??:
        _36_ = b[11:8];
      4'b1???:
        _36_ = b[15:12];
      default:
        _36_ = a;
    endcase
  endfunction
  assign _18_ = _36_(4'hx, { _05_[3:0], _20_[3:0], _21_[3:0], D }, { _07_, _09_, _12_, _19_ });
  assign _19_ = modo == (* full_case = 32'd1 *) (* src = "cont1.v:31|cont1.v:27" *) 2'h3;
  assign _12_ = modo == (* full_case = 32'd1 *) (* src = "cont1.v:30|cont1.v:27" *) 2'h2;
  assign _09_ = modo == (* full_case = 32'd1 *) (* src = "cont1.v:29|cont1.v:27" *) 2'h1;
  assign _07_ = ! (* full_case = 32'd1 *) (* src = "cont1.v:28|cont1.v:27" *) modo;
  assign _00_ = enb ? (* full_case = 32'd1 *) (* src = "cont1.v:24" *) _18_ : Q;
  assign _04_ = _15_ ? (* full_case = 32'd1 *) (* src = "cont1.v:65" *) 1'h1 : 1'h0;
  assign _03_ = _14_ ? (* full_case = 32'd1 *) (* src = "cont1.v:56" *) 1'h1 : _04_;
  assign _20_ = Q - (* src = "cont1.v:29" *) 32'd1;
  assign _21_ = Q - (* src = "cont1.v:30" *) 32'd3;
endmodule

(* src = "cont2.v:1" *)
module cont2(Q, RCO, clk, enb, modo, D);
  (* src = "cont2.v:27" *)
  wire [3:0] _00_;
  (* src = "cont2.v:27" *)
  wire _01_;
  (* src = "cont2.v:27" *)
  wire _02_;
  (* src = "cont2.v:27" *)
  wire _03_;
  (* src = "cont2.v:27" *)
  wire _04_;
  (* src = "cont2.v:32" *)
  (* unused_bits = "4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31" *)
  wire [31:0] _05_;
  wire _06_;
  (* src = "cont2.v:54" *)
  wire _07_;
  (* src = "cont2.v:54" *)
  wire _08_;
  (* src = "cont2.v:60" *)
  wire _09_;
  (* src = "cont2.v:60" *)
  wire _10_;
  (* src = "cont2.v:69" *)
  wire _11_;
  (* src = "cont2.v:69" *)
  wire _12_;
  (* src = "cont2.v:69" *)
  wire _13_;
  (* src = "cont2.v:54" *)
  wire _14_;
  (* src = "cont2.v:60" *)
  wire _15_;
  (* src = "cont2.v:69" *)
  wire _16_;
  (* src = "cont2.v:69" *)
  wire _17_;
  (* src = "cont2.v:69" *)
  wire _18_;
  wire [3:0] _19_;
  wire _20_;
  (* src = "cont2.v:33" *)
  (* unused_bits = "4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31" *)
  wire [31:0] _21_;
  (* src = "cont2.v:13" *)
  input [3:0] D;
  (* src = "cont2.v:16" *)
  output [3:0] Q;
  reg [3:0] Q;
  (* init = 1'h0 *)
  (* src = "cont2.v:17" *)
  output RCO;
  reg RCO = 1'h0;
  (* src = "cont2.v:12" *)
  input clk;
  (* src = "cont2.v:12" *)
  input enb;
  (* src = "cont2.v:14" *)
  input [1:0] modo;
  assign _05_ = Q + (* src = "cont2.v:32" *) 32'd1;
  assign _06_ = | { _10_, _13_ };
  assign _07_ = Q == (* src = "cont2.v:54" *) 4'hf;
  assign _09_ = ! (* src = "cont2.v:69" *) Q;
  assign _11_ = Q == (* src = "cont2.v:69" *) 4'h1;
  assign _12_ = Q == (* src = "cont2.v:69" *) 4'h2;
  assign _14_ = _07_ && (* src = "cont2.v:54" *) _08_;
  assign _15_ = _09_ && (* src = "cont2.v:60" *) _10_;
  assign _16_ = _18_ && (* src = "cont2.v:69" *) _13_;
  assign _17_ = _09_ || (* src = "cont2.v:69" *) _11_;
  assign _18_ = _17_ || (* src = "cont2.v:69" *) _12_;
  always @(posedge clk)
      Q <= _00_;
  always @(posedge clk)
      RCO <= _01_;
  assign _04_ = _16_ ? (* full_case = 32'd1 *) (* src = "cont2.v:69" *) 1'h1 : 1'h0;
  assign _03_ = _15_ ? (* full_case = 32'd1 *) (* src = "cont2.v:60" *) 1'h1 : _04_;
  assign _02_ = _14_ ? (* full_case = 32'd1 *) (* src = "cont2.v:54" *) 1'h1 : _03_;
  assign _01_ = enb ? (* full_case = 32'd1 *) (* src = "cont2.v:28" *) _02_ : RCO;
  function [3:0] _39_;
    input [3:0] a;
    input [11:0] b;
    input [2:0] s;
    (* full_case = 32'd1 *)
    (* src = "cont2.v:35|cont2.v:31" *)
    (* parallel_case *)
    casez (s)
      3'b??1:
        _39_ = b[3:0];
      3'b?1?:
        _39_ = b[7:4];
      3'b1??:
        _39_ = b[11:8];
      default:
        _39_ = a;
    endcase
  endfunction
  assign _19_ = _39_(4'hx, { _05_[3:0], _21_[3:0], D }, { _08_, _06_, _20_ });
  assign _20_ = modo == (* full_case = 32'd1 *) (* src = "cont2.v:35|cont2.v:31" *) 2'h3;
  assign _13_ = modo == (* full_case = 32'd1 *) (* src = "cont2.v:34|cont2.v:31" *) 2'h2;
  assign _10_ = modo == (* full_case = 32'd1 *) (* src = "cont2.v:33|cont2.v:31" *) 2'h1;
  assign _08_ = ! (* full_case = 32'd1 *) (* src = "cont2.v:32|cont2.v:31" *) modo;
  assign _00_ = enb ? (* full_case = 32'd1 *) (* src = "cont2.v:28" *) _19_ : Q;
  assign _21_ = Q - (* src = "cont2.v:34" *) 32'd1;
endmodule

(* top =  1  *)
(* src = "contador16bits.v:4" *)
module contador16bits(clk, enb, D, modo, Q, RCO);
  (* src = "contador16bits.v:9" *)
  input [15:0] D;
  (* src = "contador16bits.v:11" *)
  output [15:0] Q;
  (* src = "contador16bits.v:12" *)
  output [3:0] RCO;
  (* src = "contador16bits.v:18" *)
  wire a1;
  (* src = "contador16bits.v:19" *)
  wire a2;
  (* src = "contador16bits.v:20" *)
  wire a3;
  (* src = "contador16bits.v:7" *)
  input clk;
  (* src = "contador16bits.v:8" *)
  input enb;
  (* src = "contador16bits.v:10" *)
  input [1:0] modo;
  (* src = "contador16bits.v:21" *)
  wire modo1;
  (* src = "contador16bits.v:16" *)
  wire [15:0] q;
  (* src = "contador16bits.v:17" *)
  wire [3:0] rco1;
  assign modo1 = modo == (* src = "contador16bits.v:26" *) 2'h3;
  assign a1 = modo1 ? (* src = "contador16bits.v:27" *) clk : rco1[0];
  assign a2 = modo1 ? (* src = "contador16bits.v:28" *) clk : rco1[1];
  assign a3 = modo1 ? (* src = "contador16bits.v:29" *) clk : rco1[2];
  (* module_not_derived = 32'd1 *)
  (* src = "contador16bits.v:31" *)
  cont1 U0 (
    .D(D[3:0]),
    .Q(q[3:0]),
    .RCO(rco1[0]),
    .clk(clk),
    .enb(enb),
    .modo(modo)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "contador16bits.v:42" *)
  cont2 U1 (
    .D(D[7:4]),
    .Q(q[7:4]),
    .RCO(rco1[1]),
    .clk(a1),
    .enb(enb),
    .modo(modo)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "contador16bits.v:53" *)
  cont2 U2 (
    .D(D[11:8]),
    .Q(q[11:8]),
    .RCO(rco1[2]),
    .clk(a2),
    .enb(enb),
    .modo(modo)
  );
  (* module_not_derived = 32'd1 *)
  (* src = "contador16bits.v:64" *)
  cont2 U3 (
    .D(D[15:12]),
    .Q(q[15:12]),
    .RCO(rco1[3]),
    .clk(a3),
    .enb(enb),
    .modo(modo)
  );
  assign Q = q;
  assign RCO = rco1;
endmodule
