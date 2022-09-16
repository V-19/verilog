/* Generated by Yosys 0.9 (git sha1 1979e0b) */

(* cells_not_processed =  1  *)
(* src = "tarea12.v:1" *)
module tarea12(Q, RCO, a, clk, enb, modo, D);
  (* src = "tarea12.v:25" *)
  wire [3:0] _00_;
  (* src = "tarea12.v:25" *)
  wire _01_;
  (* src = "tarea12.v:25" *)
  wire _02_;
  (* src = "tarea12.v:25" *)
  wire _03_;
  (* src = "tarea12.v:25" *)
  wire _04_;
  (* src = "tarea12.v:25" *)
  wire _05_;
  (* src = "tarea12.v:25" *)
  wire _06_;
  (* src = "tarea12.v:30" *)
  (* unused_bits = "4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31" *)
  wire [31:0] _07_;
  (* src = "tarea12.v:39" *)
  wire _08_;
  (* src = "tarea12.v:48" *)
  wire _09_;
  (* src = "tarea12.v:48" *)
  wire _10_;
  (* src = "tarea12.v:54" *)
  wire _11_;
  (* src = "tarea12.v:54" *)
  wire _12_;
  (* src = "tarea12.v:63" *)
  wire _13_;
  (* src = "tarea12.v:63" *)
  wire _14_;
  (* src = "tarea12.v:63" *)
  wire _15_;
  (* src = "tarea12.v:63" *)
  wire _16_;
  (* src = "tarea12.v:48" *)
  wire _17_;
  (* src = "tarea12.v:54" *)
  wire _18_;
  (* src = "tarea12.v:63" *)
  wire _19_;
  (* src = "tarea12.v:63" *)
  wire _20_;
  (* src = "tarea12.v:63" *)
  wire _21_;
  wire [3:0] _22_;
  (* src = "tarea12.v:31" *)
  (* unused_bits = "4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31" *)
  wire [31:0] _23_;
  (* src = "tarea12.v:32" *)
  (* unused_bits = "4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 28 29 30 31" *)
  wire [31:0] _24_;
  (* src = "tarea12.v:14" *)
  input [3:0] D;
  (* src = "tarea12.v:17" *)
  output [3:0] Q;
  reg [3:0] Q;
  (* src = "tarea12.v:18" *)
  output RCO;
  reg RCO;
  (* src = "tarea12.v:19" *)
  output a;
  reg a;
  (* src = "tarea12.v:13" *)
  input clk;
  (* src = "tarea12.v:13" *)
  input enb;
  (* src = "tarea12.v:15" *)
  input [1:0] modo;
  assign _07_ = Q + (* src = "tarea12.v:30" *) 32'd1;
  assign _09_ = Q == (* src = "tarea12.v:48" *) 4'he;
  assign _12_ = Q == (* src = "tarea12.v:54" *) 4'h1;
  assign _13_ = Q == (* src = "tarea12.v:63" *) 4'h3;
  assign _14_ = Q == (* src = "tarea12.v:63" *) 4'h5;
  assign _15_ = Q == (* src = "tarea12.v:63" *) 4'h4;
  assign _17_ = _09_ && (* src = "tarea12.v:48" *) _10_;
  assign _18_ = _12_ && (* src = "tarea12.v:54" *) _11_;
  assign _19_ = _21_ && (* src = "tarea12.v:63" *) _16_;
  assign _20_ = _13_ || (* src = "tarea12.v:63" *) _14_;
  assign _21_ = _20_ || (* src = "tarea12.v:63" *) _15_;
  always @(posedge clk)
      Q <= _00_;
  always @(posedge clk)
      a <= _02_;
  always @(posedge clk)
      RCO <= _01_;
  assign _06_ = _19_ ? (* full_case = 32'd1 *) (* src = "tarea12.v:63" *) 1'h1 : 1'h0;
  assign _05_ = _18_ ? (* full_case = 32'd1 *) (* src = "tarea12.v:54" *) 1'h1 : _06_;
  assign _03_ = _17_ ? (* full_case = 32'd1 *) (* src = "tarea12.v:48" *) 1'h1 : _05_;
  assign _04_ = _08_ ? (* full_case = 32'd1 *) (* src = "tarea12.v:39" *) clk : RCO;
  assign _01_ = enb ? (* full_case = 32'd1 *) (* src = "tarea12.v:26" *) _03_ : RCO;
  assign _02_ = enb ? (* full_case = 32'd1 *) (* src = "tarea12.v:26" *) _04_ : a;
  function [3:0] _45_;
    input [3:0] a;
    input [15:0] b;
    input [3:0] s;
    (* full_case = 32'd1 *)
    (* src = "tarea12.v:33|tarea12.v:29" *)
    (* parallel_case *)
    casez (s)
      4'b???1:
        _45_ = b[3:0];
      4'b??1?:
        _45_ = b[7:4];
      4'b?1??:
        _45_ = b[11:8];
      4'b1???:
        _45_ = b[15:12];
      default:
        _45_ = a;
    endcase
  endfunction
  assign _22_ = _45_(4'hx, { _07_[3:0], _23_[3:0], _24_[3:0], D }, { _10_, _11_, _16_, _08_ });
  assign _08_ = modo == (* full_case = 32'd1 *) (* src = "tarea12.v:33|tarea12.v:29" *) 2'h3;
  assign _16_ = modo == (* full_case = 32'd1 *) (* src = "tarea12.v:32|tarea12.v:29" *) 2'h2;
  assign _11_ = modo == (* full_case = 32'd1 *) (* src = "tarea12.v:31|tarea12.v:29" *) 2'h1;
  assign _10_ = ! (* full_case = 32'd1 *) (* src = "tarea12.v:30|tarea12.v:29" *) modo;
  assign _00_ = enb ? (* full_case = 32'd1 *) (* src = "tarea12.v:26" *) _22_ : Q;
  assign _23_ = Q - (* src = "tarea12.v:31" *) 32'd1;
  assign _24_ = Q - (* src = "tarea12.v:32" *) 32'd3;
endmodule
