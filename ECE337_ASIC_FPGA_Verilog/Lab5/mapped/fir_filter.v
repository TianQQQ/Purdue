/////////////////////////////////////////////////////////////
// Created by: Synopsys DC Expert(TM) in wire load mode
// Version   : K-2015.06-SP1
// Date      : Wed Feb 17 21:10:46 2016
/////////////////////////////////////////////////////////////


module sync_1 ( clk, n_reset, data_ready, out );
  input clk, n_reset, data_ready;
  output out;
  wire   tmp;

  DFFSR tmp_reg ( .D(data_ready), .CLK(clk), .R(n_reset), .S(1'b1), .Q(tmp) );
  DFFSR out_reg ( .D(tmp), .CLK(clk), .R(n_reset), .S(1'b1), .Q(out) );
endmodule


module sync_0 ( clk, n_reset, data_ready, out );
  input clk, n_reset, data_ready;
  output out;
  wire   tmp;

  DFFSR tmp_reg ( .D(data_ready), .CLK(clk), .R(n_reset), .S(1'b1), .Q(tmp) );
  DFFSR out_reg ( .D(tmp), .CLK(clk), .R(n_reset), .S(1'b1), .Q(out) );
endmodule


module controller ( clk, n_reset, dr, lc, overflow, cnt_up, clear, modwait, op, 
        src1, src2, dest, err );
  output [2:0] op;
  output [3:0] src1;
  output [3:0] src2;
  output [3:0] dest;
  input clk, n_reset, dr, lc, overflow;
  output cnt_up, clear, modwait, err;
  wire   mod, n7, n8, n9, n10, n12, n13, n14, n15, n16, n17, n18, n19, n20,
         n21, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34,
         n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48,
         n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62,
         n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76,
         n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90,
         n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103,
         n104, n105, n106, n107, n108, n109, n110, n111, n112, n113, n114,
         n115, n116, n117, n118, n119, n120, n121, n122, n123, n124, n125,
         n126, n127, n128, n130;
  wire   [4:0] currentState;
  wire   [4:0] nextState;
  assign src1[3] = 1'b0;

  DFFSR \currentState_reg[0]  ( .D(nextState[0]), .CLK(clk), .R(n_reset), .S(
        1'b1), .Q(currentState[0]) );
  DFFSR \currentState_reg[1]  ( .D(nextState[1]), .CLK(clk), .R(n_reset), .S(
        1'b1), .Q(currentState[1]) );
  DFFSR \currentState_reg[4]  ( .D(nextState[4]), .CLK(clk), .R(n_reset), .S(
        1'b1), .Q(currentState[4]) );
  DFFSR \currentState_reg[2]  ( .D(nextState[2]), .CLK(clk), .R(n_reset), .S(
        1'b1), .Q(currentState[2]) );
  DFFSR \currentState_reg[3]  ( .D(nextState[3]), .CLK(clk), .R(n_reset), .S(
        1'b1), .Q(currentState[3]) );
  DFFSR modwait_reg ( .D(mod), .CLK(clk), .R(n_reset), .S(1'b1), .Q(modwait)
         );
  NAND2X1 U50 ( .A(n10), .B(n130), .Y(op[1]) );
  INVX2 U9 ( .A(n28), .Y(n7) );
  INVX4 U10 ( .A(n104), .Y(n106) );
  AND2X1 U11 ( .A(n106), .B(n99), .Y(n22) );
  BUFX4 U12 ( .A(n53), .Y(n23) );
  BUFX4 U13 ( .A(n54), .Y(n36) );
  BUFX4 U14 ( .A(n37), .Y(n45) );
  INVX4 U15 ( .A(n105), .Y(n87) );
  NAND2X1 U16 ( .A(n66), .B(n110), .Y(n8) );
  NAND2X1 U17 ( .A(n65), .B(n9), .Y(nextState[2]) );
  INVX2 U18 ( .A(n8), .Y(n9) );
  INVX1 U19 ( .A(n109), .Y(n114) );
  INVX2 U20 ( .A(overflow), .Y(n28) );
  AND2X2 U21 ( .A(n127), .B(n92), .Y(n10) );
  AND2X2 U22 ( .A(dr), .B(n68), .Y(cnt_up) );
  AND2X2 U23 ( .A(n58), .B(n73), .Y(n12) );
  AND2X2 U24 ( .A(n61), .B(n44), .Y(n13) );
  NAND2X1 U25 ( .A(n41), .B(n106), .Y(n14) );
  INVX2 U26 ( .A(n60), .Y(n15) );
  NAND2X1 U27 ( .A(n28), .B(n13), .Y(n62) );
  NAND2X1 U28 ( .A(n31), .B(n87), .Y(n16) );
  INVX1 U29 ( .A(currentState[3]), .Y(n47) );
  INVX1 U30 ( .A(n24), .Y(n17) );
  INVX2 U31 ( .A(n20), .Y(n18) );
  AND2X1 U32 ( .A(n123), .B(n25), .Y(n39) );
  AND2X1 U33 ( .A(n123), .B(n122), .Y(n126) );
  AND2X2 U34 ( .A(n71), .B(lc), .Y(n19) );
  NOR2X1 U35 ( .A(n19), .B(n64), .Y(n65) );
  BUFX2 U36 ( .A(n45), .Y(n20) );
  NOR2X1 U37 ( .A(n22), .B(n103), .Y(n21) );
  INVX1 U38 ( .A(n21), .Y(n101) );
  NAND3X1 U39 ( .A(n36), .B(n45), .C(n23), .Y(n24) );
  AND2X2 U40 ( .A(n26), .B(n23), .Y(n43) );
  BUFX2 U41 ( .A(n117), .Y(n25) );
  BUFX2 U42 ( .A(currentState[4]), .Y(n26) );
  AND2X1 U43 ( .A(n123), .B(n122), .Y(n27) );
  INVX2 U44 ( .A(n49), .Y(n37) );
  OR2X2 U45 ( .A(n105), .B(n63), .Y(n29) );
  NAND2X1 U46 ( .A(n29), .B(n62), .Y(n64) );
  AND2X2 U47 ( .A(n98), .B(n99), .Y(n30) );
  INVX1 U48 ( .A(n30), .Y(n102) );
  AND2X2 U49 ( .A(n46), .B(n54), .Y(n31) );
  INVX1 U51 ( .A(n31), .Y(n60) );
  NAND2X1 U52 ( .A(n93), .B(n100), .Y(n32) );
  BUFX2 U53 ( .A(n14), .Y(n33) );
  INVX1 U54 ( .A(n53), .Y(n34) );
  INVX2 U55 ( .A(n52), .Y(n35) );
  AND2X2 U56 ( .A(n42), .B(n36), .Y(n38) );
  INVX1 U57 ( .A(n38), .Y(n59) );
  AND2X2 U58 ( .A(n27), .B(n117), .Y(n40) );
  AND2X2 U59 ( .A(n44), .B(n35), .Y(n41) );
  AND2X2 U60 ( .A(n34), .B(n37), .Y(n42) );
  INVX2 U61 ( .A(currentState[4]), .Y(n54) );
  BUFX2 U62 ( .A(currentState[3]), .Y(n44) );
  AND2X2 U63 ( .A(currentState[0]), .B(n49), .Y(n46) );
  INVX1 U64 ( .A(n46), .Y(n63) );
  INVX2 U65 ( .A(lc), .Y(n81) );
  INVX2 U66 ( .A(currentState[1]), .Y(n49) );
  INVX2 U67 ( .A(currentState[2]), .Y(n52) );
  NAND2X1 U68 ( .A(n52), .B(n47), .Y(n70) );
  INVX2 U69 ( .A(n70), .Y(n67) );
  NAND2X1 U70 ( .A(n15), .B(n67), .Y(n86) );
  INVX2 U71 ( .A(currentState[0]), .Y(n53) );
  NAND3X1 U72 ( .A(n49), .B(n53), .C(n54), .Y(n104) );
  NAND3X1 U73 ( .A(lc), .B(n106), .C(n67), .Y(n128) );
  OAI21X1 U74 ( .A(n81), .B(n86), .C(n128), .Y(n51) );
  NAND3X1 U75 ( .A(n67), .B(n26), .C(n42), .Y(n58) );
  NAND2X1 U76 ( .A(currentState[2]), .B(n47), .Y(n105) );
  NOR2X1 U77 ( .A(n36), .B(n63), .Y(n48) );
  OAI21X1 U78 ( .A(n87), .B(n67), .C(n48), .Y(n73) );
  NAND2X1 U79 ( .A(n67), .B(n43), .Y(n92) );
  NAND3X1 U80 ( .A(n43), .B(n87), .C(n18), .Y(n96) );
  NAND3X1 U81 ( .A(n12), .B(n92), .C(n96), .Y(n50) );
  OR2X1 U82 ( .A(n51), .B(n50), .Y(nextState[4]) );
  NAND2X1 U83 ( .A(n44), .B(n52), .Y(n69) );
  INVX2 U84 ( .A(n69), .Y(n99) );
  NAND2X1 U85 ( .A(n31), .B(n99), .Y(n123) );
  NAND2X1 U86 ( .A(n38), .B(n44), .Y(n117) );
  NAND2X1 U87 ( .A(n38), .B(n87), .Y(n109) );
  NAND3X1 U88 ( .A(n36), .B(n45), .C(n23), .Y(n55) );
  INVX2 U89 ( .A(n55), .Y(n98) );
  NAND2X1 U90 ( .A(n17), .B(n41), .Y(n110) );
  NAND2X1 U91 ( .A(n41), .B(n106), .Y(n100) );
  NAND2X1 U92 ( .A(n24), .B(n104), .Y(n57) );
  NAND2X1 U93 ( .A(n99), .B(n57), .Y(n121) );
  NAND3X1 U94 ( .A(n110), .B(n33), .C(n121), .Y(n124) );
  NOR2X1 U95 ( .A(n114), .B(n124), .Y(n56) );
  OAI21X1 U96 ( .A(n7), .B(n39), .C(n56), .Y(nextState[3]) );
  NAND2X1 U97 ( .A(n87), .B(n57), .Y(n91) );
  NAND2X1 U98 ( .A(n38), .B(n67), .Y(n119) );
  NAND3X1 U99 ( .A(n91), .B(n96), .C(n119), .Y(n112) );
  NAND2X1 U100 ( .A(n31), .B(n87), .Y(n93) );
  NAND2X1 U101 ( .A(n14), .B(n16), .Y(n103) );
  NOR2X1 U102 ( .A(n112), .B(n32), .Y(n66) );
  INVX2 U103 ( .A(n58), .Y(n71) );
  MUX2X1 U104 ( .B(n60), .A(n59), .S(n35), .Y(n61) );
  NAND2X1 U105 ( .A(n67), .B(n98), .Y(n127) );
  INVX2 U106 ( .A(n127), .Y(n68) );
  NOR2X1 U107 ( .A(cnt_up), .B(n101), .Y(n79) );
  NAND2X1 U108 ( .A(n98), .B(n87), .Y(n111) );
  OAI21X1 U109 ( .A(n104), .B(n70), .C(n86), .Y(n72) );
  AOI21X1 U110 ( .A(dr), .B(n72), .C(n71), .Y(n74) );
  MUX2X1 U111 ( .B(n74), .A(n73), .S(lc), .Y(n77) );
  INVX2 U112 ( .A(n92), .Y(n75) );
  NAND2X1 U113 ( .A(n75), .B(n20), .Y(n88) );
  OAI21X1 U114 ( .A(overflow), .B(n25), .C(n88), .Y(n76) );
  NOR2X1 U115 ( .A(n77), .B(n76), .Y(n78) );
  NAND3X1 U116 ( .A(n79), .B(n111), .C(n78), .Y(nextState[1]) );
  NAND2X1 U117 ( .A(n31), .B(n41), .Y(n122) );
  OAI21X1 U118 ( .A(dr), .B(n86), .C(n12), .Y(n82) );
  INVX2 U119 ( .A(n96), .Y(n80) );
  AOI21X1 U120 ( .A(n82), .B(n81), .C(n80), .Y(n83) );
  OAI21X1 U121 ( .A(n40), .B(n28), .C(n83), .Y(n85) );
  INVX2 U122 ( .A(n124), .Y(n97) );
  NAND3X1 U123 ( .A(n10), .B(n97), .C(n91), .Y(n84) );
  OR2X1 U124 ( .A(n85), .B(n84), .Y(nextState[0]) );
  INVX2 U125 ( .A(n86), .Y(err) );
  NAND3X1 U126 ( .A(n20), .B(n87), .C(n43), .Y(n95) );
  INVX2 U127 ( .A(n95), .Y(n115) );
  INVX2 U128 ( .A(n88), .Y(n89) );
  NOR2X1 U129 ( .A(n115), .B(n89), .Y(n90) );
  NAND3X1 U130 ( .A(n91), .B(n127), .C(n90), .Y(dest[0]) );
  NAND2X1 U131 ( .A(n16), .B(n92), .Y(n113) );
  INVX2 U132 ( .A(n113), .Y(n94) );
  NAND3X1 U133 ( .A(n94), .B(n97), .C(n111), .Y(dest[1]) );
  NAND2X1 U134 ( .A(n10), .B(n109), .Y(dest[2]) );
  NAND3X1 U135 ( .A(n97), .B(n96), .C(n95), .Y(dest[3]) );
  NAND2X1 U136 ( .A(n110), .B(n102), .Y(src2[0]) );
  NAND2X1 U137 ( .A(n121), .B(n40), .Y(src2[1]) );
  INVX2 U138 ( .A(n121), .Y(src2[2]) );
  NAND3X1 U139 ( .A(n40), .B(n33), .C(n110), .Y(src2[3]) );
  NAND2X1 U140 ( .A(n109), .B(n21), .Y(src1[0]) );
  NOR2X1 U141 ( .A(n32), .B(n30), .Y(n108) );
  NAND2X1 U142 ( .A(n106), .B(n87), .Y(n107) );
  NAND2X1 U143 ( .A(n108), .B(n107), .Y(src1[1]) );
  NAND3X1 U144 ( .A(n111), .B(n110), .C(n109), .Y(src1[2]) );
  NOR2X1 U145 ( .A(n113), .B(n112), .Y(n118) );
  NOR2X1 U146 ( .A(n115), .B(n114), .Y(n116) );
  NAND3X1 U147 ( .A(n118), .B(n25), .C(n116), .Y(op[0]) );
  INVX2 U148 ( .A(src2[3]), .Y(n120) );
  NAND3X1 U149 ( .A(n121), .B(n120), .C(n119), .Y(op[2]) );
  NOR2X1 U150 ( .A(op[0]), .B(n124), .Y(n125) );
  NAND3X1 U151 ( .A(n127), .B(n126), .C(n125), .Y(mod) );
  INVX2 U152 ( .A(n128), .Y(clear) );
  INVX2 U153 ( .A(dest[3]), .Y(n130) );
endmodule


module datapath_decode ( op, w_en, w_data_sel, alu_op );
  input [2:0] op;
  output [1:0] w_data_sel;
  output [1:0] alu_op;
  output w_en;
  wire   n4, n5, n1, n2, n3;

  NAND3X1 U6 ( .A(n2), .B(n3), .C(n1), .Y(w_en) );
  NOR2X1 U7 ( .A(n1), .B(w_data_sel[1]), .Y(w_data_sel[0]) );
  NAND2X1 U8 ( .A(op[1]), .B(n3), .Y(w_data_sel[1]) );
  OAI21X1 U9 ( .A(n3), .B(n4), .C(n5), .Y(alu_op[1]) );
  NAND3X1 U10 ( .A(op[0]), .B(n2), .C(op[2]), .Y(n5) );
  NAND2X1 U11 ( .A(op[1]), .B(n1), .Y(n4) );
  NOR2X1 U12 ( .A(op[0]), .B(n3), .Y(alu_op[0]) );
  INVX2 U3 ( .A(op[0]), .Y(n1) );
  INVX2 U4 ( .A(op[1]), .Y(n2) );
  INVX2 U5 ( .A(op[2]), .Y(n3) );
endmodule


module alu_DW01_add_2 ( A, B, CI, SUM, CO );
  input [17:0] A;
  input [17:0] B;
  output [17:0] SUM;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n16, n17,
         n18, n20, n22, n23, n24, n25, n26, n28, n30, n31, n32, n33, n34, n36,
         n38, n39, n40, n41, n42, n44, n46, n47, n48, n49, n50, n52, n54, n55,
         n56, n57, n58, n60, n62, n63, n64, n65, n66, n68, n70, n71, n72, n73,
         n75, n76, n78, n80, n82, n84, n86, n88, n90, n92, n93, n152, n153,
         n154, n155, n156, n157, n158, n159, n161, n162, n163, n164, n165,
         n166, n167, n168, n169;

  XNOR2X1 U5 ( .A(n23), .B(n1), .Y(SUM[14]) );
  AOI21X1 U6 ( .A(n168), .B(n23), .C(n20), .Y(n18) );
  NAND2X1 U9 ( .A(n22), .B(n168), .Y(n1) );
  NAND2X1 U12 ( .A(A[14]), .B(B[14]), .Y(n22) );
  XOR2X1 U13 ( .A(n26), .B(n2), .Y(SUM[13]) );
  OAI21X1 U14 ( .A(n26), .B(n24), .C(n25), .Y(n23) );
  NAND2X1 U15 ( .A(n25), .B(n78), .Y(n2) );
  NOR2X1 U17 ( .A(A[13]), .B(B[13]), .Y(n24) );
  NAND2X1 U18 ( .A(A[13]), .B(B[13]), .Y(n25) );
  XNOR2X1 U19 ( .A(n31), .B(n3), .Y(SUM[12]) );
  AOI21X1 U20 ( .A(n167), .B(n31), .C(n28), .Y(n26) );
  NAND2X1 U23 ( .A(n30), .B(n167), .Y(n3) );
  NAND2X1 U26 ( .A(A[12]), .B(B[12]), .Y(n30) );
  XOR2X1 U27 ( .A(n34), .B(n4), .Y(SUM[11]) );
  OAI21X1 U28 ( .A(n34), .B(n32), .C(n33), .Y(n31) );
  NAND2X1 U29 ( .A(n33), .B(n80), .Y(n4) );
  NOR2X1 U31 ( .A(A[11]), .B(B[11]), .Y(n32) );
  NAND2X1 U32 ( .A(A[11]), .B(B[11]), .Y(n33) );
  XNOR2X1 U33 ( .A(n39), .B(n5), .Y(SUM[10]) );
  AOI21X1 U34 ( .A(n166), .B(n39), .C(n36), .Y(n34) );
  NAND2X1 U37 ( .A(n38), .B(n166), .Y(n5) );
  NAND2X1 U40 ( .A(A[10]), .B(B[10]), .Y(n38) );
  XOR2X1 U41 ( .A(n42), .B(n6), .Y(SUM[9]) );
  OAI21X1 U42 ( .A(n42), .B(n40), .C(n41), .Y(n39) );
  NAND2X1 U43 ( .A(n41), .B(n82), .Y(n6) );
  NOR2X1 U45 ( .A(A[9]), .B(B[9]), .Y(n40) );
  NAND2X1 U46 ( .A(A[9]), .B(B[9]), .Y(n41) );
  XNOR2X1 U47 ( .A(n47), .B(n7), .Y(SUM[8]) );
  AOI21X1 U48 ( .A(n165), .B(n47), .C(n44), .Y(n42) );
  NAND2X1 U51 ( .A(n46), .B(n165), .Y(n7) );
  NAND2X1 U54 ( .A(A[8]), .B(B[8]), .Y(n46) );
  XOR2X1 U55 ( .A(n50), .B(n8), .Y(SUM[7]) );
  OAI21X1 U56 ( .A(n50), .B(n48), .C(n49), .Y(n47) );
  NAND2X1 U57 ( .A(n49), .B(n84), .Y(n8) );
  NOR2X1 U59 ( .A(A[7]), .B(B[7]), .Y(n48) );
  NAND2X1 U60 ( .A(A[7]), .B(B[7]), .Y(n49) );
  XNOR2X1 U61 ( .A(n55), .B(n9), .Y(SUM[6]) );
  AOI21X1 U62 ( .A(n164), .B(n55), .C(n52), .Y(n50) );
  NAND2X1 U65 ( .A(n54), .B(n164), .Y(n9) );
  NAND2X1 U68 ( .A(A[6]), .B(B[6]), .Y(n54) );
  XOR2X1 U69 ( .A(n58), .B(n10), .Y(SUM[5]) );
  OAI21X1 U70 ( .A(n58), .B(n56), .C(n57), .Y(n55) );
  NAND2X1 U71 ( .A(n57), .B(n86), .Y(n10) );
  NOR2X1 U73 ( .A(A[5]), .B(B[5]), .Y(n56) );
  NAND2X1 U74 ( .A(A[5]), .B(B[5]), .Y(n57) );
  XNOR2X1 U75 ( .A(n63), .B(n11), .Y(SUM[4]) );
  AOI21X1 U76 ( .A(n163), .B(n63), .C(n60), .Y(n58) );
  NAND2X1 U79 ( .A(n62), .B(n163), .Y(n11) );
  NAND2X1 U82 ( .A(A[4]), .B(B[4]), .Y(n62) );
  XOR2X1 U83 ( .A(n66), .B(n12), .Y(SUM[3]) );
  OAI21X1 U84 ( .A(n66), .B(n64), .C(n65), .Y(n63) );
  NAND2X1 U85 ( .A(n65), .B(n88), .Y(n12) );
  NOR2X1 U87 ( .A(A[3]), .B(B[3]), .Y(n64) );
  NAND2X1 U88 ( .A(A[3]), .B(B[3]), .Y(n65) );
  XNOR2X1 U89 ( .A(n71), .B(n13), .Y(SUM[2]) );
  AOI21X1 U90 ( .A(n162), .B(n71), .C(n68), .Y(n66) );
  NAND2X1 U93 ( .A(n70), .B(n162), .Y(n13) );
  NAND2X1 U96 ( .A(A[2]), .B(B[2]), .Y(n70) );
  XOR2X1 U97 ( .A(n14), .B(n161), .Y(SUM[1]) );
  OAI21X1 U98 ( .A(n72), .B(n75), .C(n73), .Y(n71) );
  NAND2X1 U99 ( .A(n73), .B(n90), .Y(n14) );
  NOR2X1 U101 ( .A(A[1]), .B(B[1]), .Y(n72) );
  NAND2X1 U102 ( .A(A[1]), .B(B[1]), .Y(n73) );
  NAND2X1 U107 ( .A(A[0]), .B(B[0]), .Y(n75) );
  OR2X1 U113 ( .A(A[12]), .B(B[12]), .Y(n167) );
  OR2X1 U114 ( .A(A[0]), .B(B[0]), .Y(n169) );
  XOR2X1 U115 ( .A(A[15]), .B(B[15]), .Y(n152) );
  XOR2X1 U116 ( .A(n152), .B(n76), .Y(SUM[15]) );
  NAND2X1 U117 ( .A(A[15]), .B(B[15]), .Y(n153) );
  NAND2X1 U118 ( .A(A[15]), .B(n76), .Y(n154) );
  NAND2X1 U119 ( .A(B[15]), .B(n76), .Y(n155) );
  NAND3X1 U120 ( .A(n153), .B(n154), .C(n155), .Y(n17) );
  XOR2X1 U121 ( .A(n93), .B(n92), .Y(n156) );
  XOR2X1 U122 ( .A(n156), .B(n17), .Y(SUM[16]) );
  NAND2X1 U123 ( .A(n93), .B(n92), .Y(n157) );
  NAND2X1 U124 ( .A(n93), .B(n17), .Y(n158) );
  NAND2X1 U125 ( .A(n92), .B(n17), .Y(n159) );
  NAND3X1 U126 ( .A(n157), .B(n158), .C(n159), .Y(n16) );
  INVX1 U127 ( .A(n72), .Y(n90) );
  AND2X2 U128 ( .A(n161), .B(n169), .Y(SUM[0]) );
  NAND2X1 U129 ( .A(A[0]), .B(B[0]), .Y(n161) );
  OR2X1 U130 ( .A(A[6]), .B(B[6]), .Y(n164) );
  OR2X2 U131 ( .A(A[2]), .B(B[2]), .Y(n162) );
  OR2X2 U132 ( .A(A[4]), .B(B[4]), .Y(n163) );
  OR2X2 U133 ( .A(A[8]), .B(B[8]), .Y(n165) );
  OR2X2 U134 ( .A(A[10]), .B(B[10]), .Y(n166) );
  OR2X2 U135 ( .A(A[14]), .B(B[14]), .Y(n168) );
  INVX2 U136 ( .A(A[17]), .Y(n93) );
  INVX2 U137 ( .A(B[17]), .Y(n92) );
  INVX2 U138 ( .A(n64), .Y(n88) );
  INVX2 U139 ( .A(n56), .Y(n86) );
  INVX2 U140 ( .A(n48), .Y(n84) );
  INVX2 U141 ( .A(n40), .Y(n82) );
  INVX2 U142 ( .A(n32), .Y(n80) );
  INVX2 U143 ( .A(n24), .Y(n78) );
  INVX2 U144 ( .A(n18), .Y(n76) );
  INVX2 U145 ( .A(n70), .Y(n68) );
  INVX2 U146 ( .A(n62), .Y(n60) );
  INVX2 U147 ( .A(n54), .Y(n52) );
  INVX2 U148 ( .A(n46), .Y(n44) );
  INVX2 U149 ( .A(n38), .Y(n36) );
  INVX2 U150 ( .A(n30), .Y(n28) );
  INVX2 U151 ( .A(n22), .Y(n20) );
  INVX2 U152 ( .A(n16), .Y(SUM[17]) );
endmodule


module alu_DW01_sub_2 ( A, B, CI, DIFF, CO );
  input [17:0] A;
  input [17:0] B;
  output [17:0] DIFF;
  input CI;
  output CO;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n19, n20, n22, n24, n25, n26, n27, n28, n30, n32, n33, n34,
         n35, n36, n38, n40, n41, n42, n43, n44, n46, n48, n49, n50, n51, n52,
         n54, n56, n57, n58, n59, n60, n61, n62, n63, n64, n65, n66, n67, n68,
         n69, n70, n71, n72, n73, n75, n77, n79, n81, n83, n84, n85, n86, n87,
         n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n103, n162, n163, n164, n165, n166, n167, n168, n169, n170,
         n171, n172, n173, n174, n175, n176, n177;

  XOR2X1 U4 ( .A(n20), .B(n1), .Y(DIFF[14]) );
  OAI21X1 U5 ( .A(n20), .B(n18), .C(n19), .Y(n17) );
  NAND2X1 U6 ( .A(n19), .B(n73), .Y(n1) );
  NOR2X1 U8 ( .A(A[14]), .B(n88), .Y(n18) );
  NAND2X1 U9 ( .A(A[14]), .B(n88), .Y(n19) );
  XNOR2X1 U10 ( .A(n25), .B(n2), .Y(DIFF[13]) );
  AOI21X1 U11 ( .A(n168), .B(n25), .C(n22), .Y(n20) );
  NAND2X1 U14 ( .A(n24), .B(n168), .Y(n2) );
  NAND2X1 U17 ( .A(A[13]), .B(n89), .Y(n24) );
  XOR2X1 U18 ( .A(n28), .B(n3), .Y(DIFF[12]) );
  OAI21X1 U19 ( .A(n28), .B(n26), .C(n27), .Y(n25) );
  NAND2X1 U20 ( .A(n27), .B(n75), .Y(n3) );
  NOR2X1 U22 ( .A(A[12]), .B(n90), .Y(n26) );
  NAND2X1 U23 ( .A(A[12]), .B(n90), .Y(n27) );
  XNOR2X1 U24 ( .A(n33), .B(n4), .Y(DIFF[11]) );
  AOI21X1 U25 ( .A(n169), .B(n33), .C(n30), .Y(n28) );
  NAND2X1 U28 ( .A(n32), .B(n169), .Y(n4) );
  NAND2X1 U31 ( .A(A[11]), .B(n91), .Y(n32) );
  XOR2X1 U32 ( .A(n36), .B(n5), .Y(DIFF[10]) );
  OAI21X1 U33 ( .A(n36), .B(n34), .C(n35), .Y(n33) );
  NAND2X1 U34 ( .A(n35), .B(n77), .Y(n5) );
  NOR2X1 U36 ( .A(A[10]), .B(n92), .Y(n34) );
  NAND2X1 U37 ( .A(A[10]), .B(n92), .Y(n35) );
  XNOR2X1 U38 ( .A(n41), .B(n6), .Y(DIFF[9]) );
  AOI21X1 U39 ( .A(n176), .B(n41), .C(n38), .Y(n36) );
  NAND2X1 U42 ( .A(n40), .B(n176), .Y(n6) );
  NAND2X1 U45 ( .A(A[9]), .B(n93), .Y(n40) );
  XOR2X1 U46 ( .A(n163), .B(n7), .Y(DIFF[8]) );
  OAI21X1 U47 ( .A(n44), .B(n42), .C(n43), .Y(n41) );
  NAND2X1 U48 ( .A(n43), .B(n79), .Y(n7) );
  NOR2X1 U50 ( .A(A[8]), .B(n94), .Y(n42) );
  NAND2X1 U51 ( .A(A[8]), .B(n94), .Y(n43) );
  XNOR2X1 U52 ( .A(n49), .B(n8), .Y(DIFF[7]) );
  AOI21X1 U53 ( .A(n175), .B(n49), .C(n46), .Y(n44) );
  NAND2X1 U56 ( .A(n48), .B(n175), .Y(n8) );
  NAND2X1 U59 ( .A(A[7]), .B(n95), .Y(n48) );
  XOR2X1 U60 ( .A(n52), .B(n9), .Y(DIFF[6]) );
  OAI21X1 U61 ( .A(n52), .B(n50), .C(n51), .Y(n49) );
  NAND2X1 U62 ( .A(n51), .B(n81), .Y(n9) );
  NOR2X1 U64 ( .A(A[6]), .B(n96), .Y(n50) );
  NAND2X1 U65 ( .A(A[6]), .B(n96), .Y(n51) );
  XNOR2X1 U66 ( .A(n57), .B(n10), .Y(DIFF[5]) );
  AOI21X1 U67 ( .A(n174), .B(n57), .C(n54), .Y(n52) );
  NAND2X1 U70 ( .A(n56), .B(n174), .Y(n10) );
  NAND2X1 U73 ( .A(A[5]), .B(n97), .Y(n56) );
  XOR2X1 U74 ( .A(n60), .B(n11), .Y(DIFF[4]) );
  OAI21X1 U75 ( .A(n60), .B(n58), .C(n59), .Y(n57) );
  NAND2X1 U76 ( .A(n59), .B(n83), .Y(n11) );
  NOR2X1 U78 ( .A(A[4]), .B(n98), .Y(n58) );
  NAND2X1 U79 ( .A(A[4]), .B(n98), .Y(n59) );
  XNOR2X1 U80 ( .A(n65), .B(n12), .Y(DIFF[3]) );
  AOI21X1 U81 ( .A(n69), .B(n61), .C(n62), .Y(n60) );
  NOR2X1 U82 ( .A(n66), .B(n63), .Y(n61) );
  OAI21X1 U83 ( .A(n63), .B(n67), .C(n64), .Y(n62) );
  NAND2X1 U84 ( .A(n64), .B(n84), .Y(n12) );
  NOR2X1 U86 ( .A(A[3]), .B(n99), .Y(n63) );
  NAND2X1 U87 ( .A(A[3]), .B(n99), .Y(n64) );
  XOR2X1 U88 ( .A(n68), .B(n13), .Y(DIFF[2]) );
  OAI21X1 U89 ( .A(n68), .B(n66), .C(n67), .Y(n65) );
  NAND2X1 U90 ( .A(n67), .B(n85), .Y(n13) );
  NOR2X1 U92 ( .A(A[2]), .B(n100), .Y(n66) );
  NAND2X1 U93 ( .A(A[2]), .B(n100), .Y(n67) );
  XOR2X1 U94 ( .A(n14), .B(n72), .Y(DIFF[1]) );
  OAI21X1 U96 ( .A(n70), .B(n72), .C(n71), .Y(n69) );
  NAND2X1 U97 ( .A(n71), .B(n86), .Y(n14) );
  NOR2X1 U99 ( .A(A[1]), .B(n101), .Y(n70) );
  NAND2X1 U100 ( .A(A[1]), .B(n101), .Y(n71) );
  XNOR2X1 U101 ( .A(n177), .B(A[0]), .Y(DIFF[0]) );
  NOR2X1 U102 ( .A(A[0]), .B(n177), .Y(n72) );
  NAND3X1 U123 ( .A(n167), .B(n165), .C(n166), .Y(n162) );
  INVX1 U124 ( .A(B[3]), .Y(n99) );
  INVX1 U125 ( .A(B[12]), .Y(n90) );
  INVX1 U126 ( .A(B[8]), .Y(n94) );
  INVX1 U127 ( .A(B[9]), .Y(n93) );
  INVX1 U128 ( .A(B[5]), .Y(n97) );
  INVX2 U129 ( .A(B[0]), .Y(n177) );
  BUFX2 U130 ( .A(n44), .Y(n163) );
  XOR2X1 U131 ( .A(n87), .B(A[15]), .Y(n164) );
  XOR2X1 U132 ( .A(n17), .B(n164), .Y(DIFF[15]) );
  NAND2X1 U133 ( .A(n17), .B(n87), .Y(n165) );
  NAND2X1 U134 ( .A(n17), .B(A[15]), .Y(n166) );
  NAND2X1 U135 ( .A(n87), .B(A[15]), .Y(n167) );
  NAND3X1 U136 ( .A(n167), .B(n165), .C(n166), .Y(n16) );
  INVX1 U137 ( .A(B[13]), .Y(n89) );
  INVX1 U138 ( .A(B[2]), .Y(n100) );
  INVX2 U139 ( .A(n15), .Y(DIFF[17]) );
  INVX1 U140 ( .A(B[1]), .Y(n101) );
  OR2X2 U141 ( .A(A[13]), .B(n89), .Y(n168) );
  OR2X2 U142 ( .A(A[11]), .B(n91), .Y(n169) );
  INVX1 U143 ( .A(B[11]), .Y(n91) );
  INVX1 U144 ( .A(B[7]), .Y(n95) );
  INVX1 U145 ( .A(B[14]), .Y(n88) );
  INVX1 U146 ( .A(B[4]), .Y(n98) );
  INVX1 U147 ( .A(B[6]), .Y(n96) );
  XOR2X1 U148 ( .A(n103), .B(B[16]), .Y(n170) );
  XOR2X1 U149 ( .A(n162), .B(n170), .Y(DIFF[16]) );
  NAND2X1 U150 ( .A(n16), .B(n103), .Y(n171) );
  NAND2X1 U151 ( .A(n16), .B(B[16]), .Y(n172) );
  NAND2X1 U152 ( .A(n103), .B(B[16]), .Y(n173) );
  NAND3X1 U153 ( .A(n172), .B(n171), .C(n173), .Y(n15) );
  INVX1 U154 ( .A(n69), .Y(n68) );
  INVX1 U155 ( .A(B[15]), .Y(n87) );
  OR2X2 U156 ( .A(A[5]), .B(n97), .Y(n174) );
  OR2X2 U157 ( .A(A[7]), .B(n95), .Y(n175) );
  OR2X2 U158 ( .A(A[9]), .B(n93), .Y(n176) );
  INVX2 U159 ( .A(B[10]), .Y(n92) );
  INVX2 U160 ( .A(n70), .Y(n86) );
  INVX2 U161 ( .A(n66), .Y(n85) );
  INVX2 U162 ( .A(n63), .Y(n84) );
  INVX2 U163 ( .A(n58), .Y(n83) );
  INVX2 U164 ( .A(n50), .Y(n81) );
  INVX2 U165 ( .A(n42), .Y(n79) );
  INVX2 U166 ( .A(n34), .Y(n77) );
  INVX2 U167 ( .A(n26), .Y(n75) );
  INVX2 U168 ( .A(n18), .Y(n73) );
  INVX2 U169 ( .A(n56), .Y(n54) );
  INVX2 U170 ( .A(n48), .Y(n46) );
  INVX2 U171 ( .A(n40), .Y(n38) );
  INVX2 U172 ( .A(n32), .Y(n30) );
  INVX2 U173 ( .A(n24), .Y(n22) );
  INVX2 U174 ( .A(A[17]), .Y(n103) );
endmodule


module alu_DW_mult_uns_2 ( a, b, product );
  input [30:0] a;
  input [15:0] b;
  output [46:0] product;
  wire   n1, n7, n13, n18, n19, n22, n25, n28, n31, n36, n37, n40, n46, n49,
         n51, n52, n53, n54, n56, n58, n59, n64, n65, n66, n67, n68, n69, n70,
         n72, n73, n74, n75, n77, n79, n80, n81, n82, n83, n84, n85, n86, n87,
         n88, n89, n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100,
         n101, n102, n103, n104, n105, n106, n107, n109, n111, n112, n113,
         n114, n115, n116, n120, n122, n123, n124, n125, n126, n127, n128,
         n129, n130, n133, n134, n135, n136, n137, n140, n142, n144, n145,
         n146, n147, n148, n149, n151, n154, n155, n156, n159, n160, n161,
         n162, n163, n164, n165, n166, n169, n170, n171, n172, n173, n174,
         n177, n178, n179, n181, n182, n183, n185, n186, n187, n188, n189,
         n190, n191, n192, n193, n194, n197, n198, n199, n200, n201, n202,
         n205, n206, n207, n209, n210, n211, n212, n213, n214, n215, n216,
         n217, n218, n219, n220, n221, n222, n223, n224, n233, n234, n235,
         n236, n237, n238, n239, n240, n241, n242, n243, n248, n249, n250,
         n251, n256, n257, n258, n259, n264, n265, n266, n267, n275, n279,
         n282, n283, n284, n285, n286, n287, n288, n289, n290, n291, n292,
         n293, n294, n295, n296, n297, n298, n299, n300, n301, n302, n303,
         n304, n305, n306, n307, n308, n309, n310, n311, n312, n313, n314,
         n315, n316, n317, n318, n319, n320, n321, n322, n323, n324, n325,
         n326, n327, n328, n329, n330, n331, n332, n333, n334, n335, n336,
         n337, n338, n339, n340, n341, n342, n343, n344, n345, n346, n347,
         n348, n349, n350, n351, n352, n353, n354, n355, n356, n357, n358,
         n359, n360, n361, n362, n363, n364, n365, n366, n367, n368, n369,
         n370, n371, n372, n373, n374, n375, n376, n377, n378, n379, n380,
         n381, n382, n383, n384, n385, n386, n387, n388, n389, n390, n391,
         n392, n393, n394, n395, n396, n397, n398, n399, n400, n401, n402,
         n403, n404, n405, n406, n407, n408, n409, n410, n411, n412, n413,
         n414, n415, n416, n417, n418, n419, n420, n421, n422, n423, n424,
         n425, n426, n427, n428, n429, n430, n431, n432, n433, n434, n435,
         n436, n437, n438, n439, n440, n441, n442, n443, n444, n445, n446,
         n447, n448, n449, n450, n451, n452, n453, n454, n455, n456, n457,
         n458, n459, n460, n461, n462, n463, n464, n465, n466, n467, n468,
         n469, n470, n471, n472, n473, n474, n475, n476, n477, n478, n479,
         n480, n481, n482, n483, n484, n485, n486, n487, n488, n489, n490,
         n491, n492, n493, n494, n495, n496, n497, n498, n499, n500, n501,
         n502, n503, n504, n505, n506, n507, n508, n509, n510, n511, n512,
         n513, n514, n515, n516, n517, n518, n519, n520, n521, n522, n523,
         n524, n525, n526, n527, n528, n529, n530, n531, n532, n533, n534,
         n535, n536, n537, n538, n539, n540, n541, n542, n545, n548, n551,
         n552, n554, n555, n557, n558, n560, n561, n565, n566, n567, n568,
         n569, n570, n571, n572, n573, n574, n575, n576, n577, n578, n579,
         n580, n581, n582, n584, n585, n586, n587, n588, n589, n590, n591,
         n592, n593, n594, n595, n596, n597, n598, n599, n600, n601, n602,
         n603, n604, n605, n606, n607, n608, n609, n610, n611, n612, n613,
         n614, n615, n616, n617, n618, n619, n620, n621, n622, n623, n624,
         n625, n626, n627, n628, n629, n630, n631, n632, n633, n634, n635,
         n636, n637, n638, n639, n640, n641, n642, n643, n644, n645, n646,
         n647, n648, n649, n650, n651, n652, n653, n654, n655, n656, n657,
         n658, n659, n660, n661, n662, n663, n664, n665, n666, n667, n668,
         n669, n670, n671, n672, n673, n674, n675, n676, n677, n678, n679,
         n680, n681, n682, n683, n684, n685, n686, n687, n688, n689, n690,
         n691, n692, n693, n694, n695, n696, n697, n698, n699, n700, n701,
         n702, n703, n704, n705, n706, n707, n708, n709, n710, n711, n712,
         n713, n714, n715, n716, n717, n718, n719, n720, n721, n722, n723,
         n724, n725, n730, n731, n732, n741, n742, n743, n744, n745, n746,
         n747, n748, n749, n750, n751, n752, n753, n754, n755, n756, n757,
         n758, n759, n760, n761, n762, n763, n764, n765, n766, n767, n768,
         n769, n770, n771, n772, n773, n774, n775, n776, n777, n778, n779,
         n780, n781, n782, n783, n784, n785, n786, n787, n788, n789, n790,
         n791, n792, n793, n794, n795, n796, n797, n798, n799, n800, n801,
         n802, n803, n804, n805, n806, n807, n808, n809, n810, n811, n812,
         n813, n814, n815, n816, n817, n818, n819, n820, n821, n822, n823,
         n824, n825, n826, n827, n828, n829, n830, n831, n832, n833, n834,
         n835, n836, n837, n838, n839, n840, n841, n842, n843, n844, n845,
         n846, n847, n848, n849, n850, n851, n852, n853, n854, n855, n856,
         n857, n858, n859, n860, n861, n862, n863, n864, n865, n866, n867,
         n868, n869, n870, n871, n872, n873, n874, n875, n876, n877, n878,
         n879, n880, n881, n882, n883, n884, n885, n886, n887, n888, n889,
         n890, n891, n894, n896, n899, n900, n917, n918, n995, n996, n997,
         n998, n999, n1000, n1001, n1002, n1003, n1004, n1005, n1006, n1007,
         n1008, n1009, n1010, n1011, n1012, n1013, n1014, n1015, n1016, n1017,
         n1018, n1019, n1020, n1021, n1022, n1023, n1024, n1025, n1026, n1027,
         n1028, n1029, n1030, n1031, n1032, n1033, n1034, n1035, n1036, n1037,
         n1038, n1039, n1040, n1041, n1042, n1043, n1044, n1045, n1046, n1047,
         n1048, n1049, n1050, n1051, n1052, n1053, n1054, n1055, n1056, n1057,
         n1058, n1059, n1060, n1061, n1062, n1063, n1064, n1065, n1066, n1067,
         n1068, n1069, n1070, n1071, n1072, n1073, n1074, n1075, n1076, n1077,
         n1078, n1079, n1080, n1081, n1082, n1083, n1084, n1085, n1086, n1087,
         n1088, n1089, n1090, n1091, n1092, n1093, n1094, n1095, n1096, n1097,
         n1098, n1099, n1100, n1101, n1102, n1103, n1104, n1105, n1106, n1107,
         n1108, n1109, n1110, n1111, n1112, n1113, n1114, n1115, n1116, n1117,
         n1118, n1119, n1120, n1121, n1122, n1123, n1124, n1125, n1126, n1127,
         n1128, n1129, n1130, n1131, n1132, n1133, n1134, n1135, n1136, n1137,
         n1138, n1139, n1140, n1141, n1142, n1143, n1144, n1145, n1146, n1147,
         n1148, n1149, n1150, n1151, n1152, n1153, n1154, n1155, n1156, n1157,
         n1158, n1159, n1160, n1161, n1162, n1163, n1164, n1165, n1166, n1167,
         n1168, n1169, n1170, n1171, n1172, n1173, n1174, n1175, n1176, n1177,
         n1178, n1179, n1180, n1181, n1182, n1183, n1184, n1185, n1186, n1187,
         n1188, n1189, n1190, n1191, n1192, n1193, n1194, n1195, n1196, n1197,
         n1198, n1199, n1200, n1201, n1202, n1203, n1204, n1205, n1206, n1207,
         n1208, n1209, n1210, n1211, n1212, n1213, n1214, n1215, n1216, n1217,
         n1218, n1219, n1220, n1221, n1222, n1223, n1224, n1225, n1226, n1227,
         n1228, n1229, n1230, n1231, n1232, n1233, n1234, n1235, n1236, n1237,
         n1238, n1239, n1240, n1241, n1242, n1243, n1244, n1245, n1246, n1247,
         n1248, n1249, n1250, n1251, n1252, n1253, n1254, n1255, n1256, n1257,
         n1258, n1259, n1260, n1261, n1262, n1263, n1264, n1265, n1266, n1267,
         n1268, n1269, n1270, n1271, n1272, n1273, n1274, n1275, n1276, n1277,
         n1278, n1279, n1280, n1281, n1282, n1283, n1284, n1285, n1286, n1287,
         n1288, n1289, n1290, n1291, n1292, n1293, n1294, n1295, n1296, n1297,
         n1298, n1299, n1300, n1301, n1302, n1303, n1304, n1305, n1306, n1307,
         n1308, n1309, n1310, n1311, n1312, n1313, n1314, n1315, n1316, n1317,
         n1318, n1319, n1320, n1321, n1322, n1323, n1324, n1325, n1326, n1327,
         n1328, n1329, n1330, n1331, n1332, n1333, n1334, n1335, n1336, n1337,
         n1338, n1339, n1340, n1341, n1342, n1343, n1344, n1345, n1346, n1347,
         n1348, n1349, n1350, n1351, n1352, n1353, n1354, n1355, n1356;
  assign n1 = a[16];
  assign n7 = a[18];
  assign n13 = a[20];
  assign n19 = a[22];
  assign n25 = a[24];
  assign n31 = a[26];
  assign n37 = a[28];
  assign n49 = b[0];
  assign n541 = a[30];
  assign n877 = b[15];
  assign n878 = b[14];
  assign n879 = b[13];
  assign n880 = b[12];
  assign n881 = b[11];
  assign n882 = b[10];
  assign n883 = b[9];
  assign n884 = b[8];
  assign n885 = b[7];
  assign n886 = b[6];
  assign n887 = b[5];
  assign n888 = b[4];
  assign n889 = b[3];
  assign n890 = b[2];
  assign n891 = b[1];

  XOR2X1 U54 ( .A(n73), .B(n54), .Y(product[46]) );
  NAND2X1 U55 ( .A(n72), .B(n1082), .Y(n54) );
  NAND2X1 U58 ( .A(n292), .B(n293), .Y(n72) );
  AOI21X1 U60 ( .A(n1119), .B(n74), .C(n75), .Y(n73) );
  NOR2X1 U61 ( .A(n53), .B(n1236), .Y(n74) );
  OAI21X1 U62 ( .A(n1261), .B(n1236), .C(n77), .Y(n75) );
  OAI21X1 U66 ( .A(n80), .B(n140), .C(n81), .Y(n79) );
  NAND2X1 U67 ( .A(n82), .B(n104), .Y(n80) );
  AOI21X1 U68 ( .A(n82), .B(n105), .C(n83), .Y(n81) );
  NOR2X1 U69 ( .A(n84), .B(n93), .Y(n82) );
  OAI21X1 U70 ( .A(n94), .B(n84), .C(n85), .Y(n83) );
  NOR2X1 U73 ( .A(n294), .B(n297), .Y(n84) );
  NAND2X1 U74 ( .A(n294), .B(n297), .Y(n85) );
  XOR2X1 U75 ( .A(n95), .B(n56), .Y(product[44]) );
  AOI21X1 U76 ( .A(n1303), .B(n87), .C(n88), .Y(n86) );
  NOR2X1 U77 ( .A(n89), .B(n53), .Y(n87) );
  OAI21X1 U78 ( .A(n1261), .B(n89), .C(n90), .Y(n88) );
  NAND2X1 U79 ( .A(n91), .B(n100), .Y(n89) );
  AOI21X1 U80 ( .A(n91), .B(n101), .C(n92), .Y(n90) );
  NAND2X1 U83 ( .A(n94), .B(n91), .Y(n56) );
  NOR2X1 U85 ( .A(n298), .B(n301), .Y(n93) );
  NAND2X1 U86 ( .A(n298), .B(n301), .Y(n94) );
  AOI21X1 U88 ( .A(n1303), .B(n96), .C(n97), .Y(n95) );
  NOR2X1 U89 ( .A(n98), .B(n53), .Y(n96) );
  OAI21X1 U90 ( .A(n1261), .B(n98), .C(n99), .Y(n97) );
  NOR2X1 U93 ( .A(n102), .B(n1260), .Y(n100) );
  OAI21X1 U94 ( .A(n140), .B(n102), .C(n103), .Y(n101) );
  NOR2X1 U97 ( .A(n106), .B(n130), .Y(n104) );
  OAI21X1 U98 ( .A(n106), .B(n133), .C(n107), .Y(n105) );
  NAND2X1 U99 ( .A(n1238), .B(n1078), .Y(n106) );
  AOI21X1 U100 ( .A(n120), .B(n1238), .C(n109), .Y(n107) );
  NAND2X1 U106 ( .A(n302), .B(n307), .Y(n111) );
  XOR2X1 U107 ( .A(n123), .B(n58), .Y(product[42]) );
  AOI21X1 U108 ( .A(n1303), .B(n113), .C(n114), .Y(n112) );
  NOR2X1 U109 ( .A(n115), .B(n53), .Y(n113) );
  OAI21X1 U110 ( .A(n115), .B(n52), .C(n116), .Y(n114) );
  NAND2X1 U111 ( .A(n1078), .B(n128), .Y(n115) );
  AOI21X1 U112 ( .A(n1078), .B(n129), .C(n120), .Y(n116) );
  NAND2X1 U117 ( .A(n122), .B(n1078), .Y(n58) );
  NAND2X1 U120 ( .A(n308), .B(n313), .Y(n122) );
  XOR2X1 U121 ( .A(n134), .B(n59), .Y(product[41]) );
  AOI21X1 U122 ( .A(n1303), .B(n124), .C(n125), .Y(n123) );
  NOR2X1 U123 ( .A(n126), .B(n53), .Y(n124) );
  OAI21X1 U124 ( .A(n126), .B(n52), .C(n127), .Y(n125) );
  NOR2X1 U127 ( .A(n130), .B(n1260), .Y(n128) );
  OAI21X1 U128 ( .A(n140), .B(n130), .C(n133), .Y(n129) );
  NAND2X1 U131 ( .A(n133), .B(n279), .Y(n59) );
  NOR2X1 U133 ( .A(n314), .B(n321), .Y(n130) );
  NAND2X1 U134 ( .A(n314), .B(n321), .Y(n133) );
  AOI21X1 U136 ( .A(n1303), .B(n135), .C(n136), .Y(n134) );
  NOR2X1 U137 ( .A(n1260), .B(n53), .Y(n135) );
  OAI21X1 U138 ( .A(n52), .B(n1260), .C(n140), .Y(n136) );
  NAND2X1 U141 ( .A(n1237), .B(n1011), .Y(n137) );
  AOI21X1 U142 ( .A(n151), .B(n1237), .C(n142), .Y(n140) );
  NAND2X1 U148 ( .A(n322), .B(n329), .Y(n144) );
  AOI21X1 U150 ( .A(n1303), .B(n146), .C(n147), .Y(n145) );
  NOR2X1 U151 ( .A(n148), .B(n53), .Y(n146) );
  OAI21X1 U152 ( .A(n1261), .B(n148), .C(n149), .Y(n147) );
  NAND2X1 U160 ( .A(n339), .B(n330), .Y(n149) );
  AOI21X1 U162 ( .A(n1303), .B(n155), .C(n156), .Y(n154) );
  AOI21X1 U166 ( .A(n172), .B(n159), .C(n160), .Y(n52) );
  NOR2X1 U167 ( .A(n161), .B(n166), .Y(n159) );
  OAI21X1 U168 ( .A(n161), .B(n169), .C(n162), .Y(n160) );
  NOR2X1 U171 ( .A(n340), .B(n349), .Y(n161) );
  NAND2X1 U172 ( .A(n340), .B(n349), .Y(n162) );
  AOI21X1 U174 ( .A(n164), .B(n1303), .C(n165), .Y(n163) );
  NOR2X1 U175 ( .A(n166), .B(n173), .Y(n164) );
  OAI21X1 U176 ( .A(n174), .B(n166), .C(n169), .Y(n165) );
  NOR2X1 U181 ( .A(n361), .B(n350), .Y(n166) );
  NAND2X1 U182 ( .A(n1116), .B(n361), .Y(n169) );
  XOR2X1 U183 ( .A(n179), .B(n64), .Y(product[36]) );
  AOI21X1 U184 ( .A(n171), .B(n1303), .C(n172), .Y(n170) );
  NOR2X1 U189 ( .A(n182), .B(n177), .Y(n171) );
  OAI21X1 U190 ( .A(n1158), .B(n183), .C(n178), .Y(n172) );
  NAND2X1 U191 ( .A(n178), .B(n284), .Y(n64) );
  NOR2X1 U193 ( .A(n373), .B(n362), .Y(n177) );
  NAND2X1 U194 ( .A(n373), .B(n362), .Y(n178) );
  XNOR2X1 U195 ( .A(n1119), .B(n65), .Y(product[35]) );
  AOI21X1 U196 ( .A(n285), .B(n1303), .C(n181), .Y(n179) );
  NAND2X1 U199 ( .A(n183), .B(n285), .Y(n65) );
  NOR2X1 U201 ( .A(n387), .B(n374), .Y(n182) );
  NAND2X1 U202 ( .A(n387), .B(n374), .Y(n183) );
  XOR2X1 U203 ( .A(n191), .B(n66), .Y(product[34]) );
  OAI21X1 U204 ( .A(n213), .B(n185), .C(n186), .Y(n51) );
  NAND2X1 U205 ( .A(n187), .B(n199), .Y(n185) );
  AOI21X1 U206 ( .A(n200), .B(n187), .C(n188), .Y(n186) );
  NOR2X1 U207 ( .A(n189), .B(n194), .Y(n187) );
  OAI21X1 U208 ( .A(n197), .B(n189), .C(n190), .Y(n188) );
  NAND2X1 U209 ( .A(n190), .B(n286), .Y(n66) );
  NOR2X1 U211 ( .A(n401), .B(n388), .Y(n189) );
  NAND2X1 U212 ( .A(n401), .B(n388), .Y(n190) );
  XOR2X1 U213 ( .A(n198), .B(n67), .Y(product[33]) );
  AOI21X1 U214 ( .A(n212), .B(n192), .C(n193), .Y(n191) );
  NOR2X1 U215 ( .A(n194), .B(n201), .Y(n192) );
  OAI21X1 U216 ( .A(n202), .B(n194), .C(n197), .Y(n193) );
  NAND2X1 U219 ( .A(n197), .B(n287), .Y(n67) );
  NOR2X1 U221 ( .A(n415), .B(n402), .Y(n194) );
  NAND2X1 U222 ( .A(n1129), .B(n1228), .Y(n197) );
  XOR2X1 U223 ( .A(n207), .B(n68), .Y(product[32]) );
  AOI21X1 U224 ( .A(n199), .B(n212), .C(n1164), .Y(n198) );
  NOR2X1 U229 ( .A(n210), .B(n205), .Y(n199) );
  OAI21X1 U230 ( .A(n205), .B(n211), .C(n206), .Y(n200) );
  NAND2X1 U231 ( .A(n206), .B(n288), .Y(n68) );
  NOR2X1 U233 ( .A(n429), .B(n416), .Y(n205) );
  NAND2X1 U234 ( .A(n429), .B(n416), .Y(n206) );
  XNOR2X1 U235 ( .A(n212), .B(n69), .Y(product[31]) );
  AOI21X1 U236 ( .A(n289), .B(n212), .C(n209), .Y(n207) );
  NAND2X1 U239 ( .A(n211), .B(n289), .Y(n69) );
  NOR2X1 U241 ( .A(n443), .B(n430), .Y(n210) );
  NAND2X1 U242 ( .A(n430), .B(n443), .Y(n211) );
  XNOR2X1 U243 ( .A(n218), .B(n70), .Y(product[30]) );
  AOI21X1 U245 ( .A(n222), .B(n214), .C(n215), .Y(n213) );
  NOR2X1 U246 ( .A(n219), .B(n1209), .Y(n214) );
  OAI21X1 U247 ( .A(n216), .B(n220), .C(n217), .Y(n215) );
  NAND2X1 U248 ( .A(n217), .B(n290), .Y(n70) );
  NOR2X1 U250 ( .A(n457), .B(n444), .Y(n216) );
  NAND2X1 U251 ( .A(n457), .B(n444), .Y(n217) );
  OAI21X1 U252 ( .A(n221), .B(n219), .C(n220), .Y(n218) );
  NOR2X1 U253 ( .A(n469), .B(n458), .Y(n219) );
  NAND2X1 U254 ( .A(n469), .B(n458), .Y(n220) );
  OAI21X1 U256 ( .A(n223), .B(n233), .C(n224), .Y(n222) );
  NAND2X1 U257 ( .A(n1242), .B(n1239), .Y(n223) );
  AOI21X1 U258 ( .A(n1241), .B(n1239), .C(n1243), .Y(n224) );
  AOI21X1 U267 ( .A(n240), .B(n234), .C(n235), .Y(n233) );
  NOR2X1 U268 ( .A(n238), .B(n236), .Y(n234) );
  OAI21X1 U269 ( .A(n236), .B(n239), .C(n237), .Y(n235) );
  NOR2X1 U270 ( .A(n501), .B(n492), .Y(n236) );
  NAND2X1 U271 ( .A(n501), .B(n492), .Y(n237) );
  NOR2X1 U272 ( .A(n509), .B(n502), .Y(n238) );
  NAND2X1 U273 ( .A(n509), .B(n502), .Y(n239) );
  OAI21X1 U274 ( .A(n243), .B(n241), .C(n242), .Y(n240) );
  NOR2X1 U275 ( .A(n517), .B(n510), .Y(n241) );
  NAND2X1 U276 ( .A(n517), .B(n510), .Y(n242) );
  AOI21X1 U277 ( .A(n1240), .B(n248), .C(n1244), .Y(n243) );
  OAI21X1 U282 ( .A(n251), .B(n249), .C(n250), .Y(n248) );
  NOR2X1 U283 ( .A(n529), .B(n524), .Y(n249) );
  NAND2X1 U284 ( .A(n529), .B(n524), .Y(n250) );
  AOI21X1 U285 ( .A(n256), .B(n1245), .C(n1249), .Y(n251) );
  OAI21X1 U290 ( .A(n257), .B(n259), .C(n258), .Y(n256) );
  NOR2X1 U291 ( .A(n537), .B(n534), .Y(n257) );
  NAND2X1 U292 ( .A(n537), .B(n534), .Y(n258) );
  AOI21X1 U293 ( .A(n264), .B(n1246), .C(n1250), .Y(n259) );
  OAI21X1 U298 ( .A(n265), .B(n267), .C(n266), .Y(n264) );
  NOR2X1 U299 ( .A(n707), .B(n540), .Y(n265) );
  NAND2X1 U300 ( .A(n707), .B(n540), .Y(n266) );
  AOI21X1 U301 ( .A(n1252), .B(n1247), .C(n1248), .Y(n267) );
  XOR2X1 U308 ( .A(n295), .B(n291), .Y(n292) );
  FAX1 U310 ( .A(n296), .B(n584), .C(n299), .YC(n293), .YS(n294) );
  FAX1 U312 ( .A(n601), .B(n300), .C(n303), .YC(n297), .YS(n298) );
  FAX1 U313 ( .A(n305), .B(n574), .C(n585), .YC(n299), .YS(n300) );
  FAX1 U314 ( .A(n311), .B(n304), .C(n309), .YC(n301), .YS(n302) );
  FAX1 U315 ( .A(n306), .B(n602), .C(n586), .YC(n303), .YS(n304) );
  FAX1 U317 ( .A(n317), .B(n315), .C(n310), .YC(n307), .YS(n308) );
  FAX1 U318 ( .A(n587), .B(n619), .C(n312), .YC(n309), .YS(n310) );
  FAX1 U319 ( .A(n319), .B(n575), .C(n603), .YC(n311), .YS(n312) );
  FAX1 U320 ( .A(n318), .B(n316), .C(n323), .YC(n313), .YS(n314) );
  FAX1 U322 ( .A(n320), .B(n620), .C(n588), .YC(n317), .YS(n318) );
  FAX1 U324 ( .A(n333), .B(n324), .C(n331), .YC(n321), .YS(n322) );
  FAX1 U325 ( .A(n328), .B(n335), .C(n326), .YC(n323), .YS(n324) );
  FAX1 U326 ( .A(n605), .B(n589), .C(n637), .YC(n325), .YS(n326) );
  FAX1 U327 ( .A(n337), .B(n576), .C(n621), .YC(n327), .YS(n328) );
  FAX1 U329 ( .A(n345), .B(n336), .C(n334), .YC(n331), .YS(n332) );
  FAX1 U330 ( .A(n622), .B(n606), .C(n347), .YC(n333), .YS(n334) );
  FAX1 U331 ( .A(n338), .B(n638), .C(n590), .YC(n335), .YS(n336) );
  FAX1 U333 ( .A(n344), .B(n351), .C(n342), .YC(n339), .YS(n340) );
  FAX1 U334 ( .A(n355), .B(n346), .C(n353), .YC(n341), .YS(n342) );
  FAX1 U335 ( .A(n607), .B(n348), .C(n357), .YC(n343), .YS(n344) );
  FAX1 U336 ( .A(n639), .B(n591), .C(n655), .YC(n345), .YS(n346) );
  FAX1 U337 ( .A(n359), .B(n577), .C(n623), .YC(n347), .YS(n348) );
  FAX1 U338 ( .A(n354), .B(n352), .C(n363), .YC(n349), .YS(n350) );
  FAX1 U341 ( .A(n624), .B(n640), .C(n608), .YC(n355), .YS(n356) );
  FAX1 U344 ( .A(n375), .B(n366), .C(n364), .YC(n361), .YS(n362) );
  FAX1 U348 ( .A(n657), .B(n593), .C(n673), .YC(n369), .YS(n370) );
  FAX1 U355 ( .A(n386), .B(n674), .C(n594), .YC(n383), .YS(n384) );
  FAX1 U361 ( .A(n611), .B(n659), .C(n691), .YC(n395), .YS(n396) );
  FAX1 U363 ( .A(n579), .B(n643), .C(n627), .YC(n399), .YS(n400) );
  FAX1 U366 ( .A(n423), .B(n410), .C(n412), .YC(n405), .YS(n406) );
  FAX1 U368 ( .A(n676), .B(n644), .C(n660), .YC(n409), .YS(n410) );
  FAX1 U369 ( .A(n628), .B(n612), .C(n596), .YC(n411), .YS(n412) );
  FAX1 U375 ( .A(n677), .B(n645), .C(n661), .YC(n423), .YS(n424) );
  FAX1 U383 ( .A(n630), .B(n598), .C(n710), .YC(n439), .YS(n440) );
  FAX1 U385 ( .A(n448), .B(n459), .C(n446), .YC(n443), .YS(n444) );
  FAX1 U389 ( .A(n679), .B(n631), .C(n711), .YC(n451), .YS(n452) );
  HAX1 U391 ( .A(n695), .B(n615), .YC(n455), .YS(n456) );
  FAX1 U392 ( .A(n462), .B(n471), .C(n460), .YC(n457), .YS(n458) );
  FAX1 U395 ( .A(n680), .B(n648), .C(n479), .YC(n463), .YS(n464) );
  FAX1 U397 ( .A(n696), .B(n616), .C(n600), .YC(n467), .YS(n468) );
  FAX1 U398 ( .A(n474), .B(n483), .C(n472), .YC(n469), .YS(n470) );
  FAX1 U400 ( .A(n480), .B(n489), .C(n487), .YC(n473), .YS(n474) );
  FAX1 U401 ( .A(n665), .B(n681), .C(n713), .YC(n475), .YS(n476) );
  FAX1 U402 ( .A(n649), .B(n633), .C(n617), .YC(n477), .YS(n478) );
  HAX1 U403 ( .A(n697), .B(n566), .YC(n479), .YS(n480) );
  FAX1 U404 ( .A(n486), .B(n493), .C(n484), .YC(n481), .YS(n482) );
  FAX1 U407 ( .A(n682), .B(n634), .C(n618), .YC(n487), .YS(n488) );
  FAX1 U408 ( .A(n698), .B(n650), .C(n714), .YC(n489), .YS(n490) );
  FAX1 U409 ( .A(n496), .B(n503), .C(n494), .YC(n491), .YS(n492) );
  FAX1 U410 ( .A(n507), .B(n505), .C(n498), .YC(n493), .YS(n494) );
  FAX1 U411 ( .A(n651), .B(n715), .C(n500), .YC(n495), .YS(n496) );
  FAX1 U412 ( .A(n667), .B(n635), .C(n683), .YC(n497), .YS(n498) );
  HAX1 U413 ( .A(n699), .B(n567), .YC(n499), .YS(n500) );
  FAX1 U414 ( .A(n506), .B(n511), .C(n504), .YC(n501), .YS(n502) );
  FAX1 U415 ( .A(n515), .B(n513), .C(n508), .YC(n503), .YS(n504) );
  FAX1 U416 ( .A(n684), .B(n652), .C(n636), .YC(n505), .YS(n506) );
  FAX1 U417 ( .A(n700), .B(n668), .C(n716), .YC(n507), .YS(n508) );
  FAX1 U418 ( .A(n514), .B(n519), .C(n512), .YC(n509), .YS(n510) );
  FAX1 U419 ( .A(n717), .B(n516), .C(n521), .YC(n511), .YS(n512) );
  FAX1 U420 ( .A(n669), .B(n685), .C(n653), .YC(n513), .YS(n514) );
  HAX1 U421 ( .A(n701), .B(n568), .YC(n515), .YS(n516) );
  FAX1 U422 ( .A(n525), .B(n522), .C(n520), .YC(n517), .YS(n518) );
  FAX1 U423 ( .A(n686), .B(n654), .C(n527), .YC(n519), .YS(n520) );
  FAX1 U424 ( .A(n702), .B(n670), .C(n718), .YC(n521), .YS(n522) );
  FAX1 U425 ( .A(n528), .B(n531), .C(n526), .YC(n523), .YS(n524) );
  FAX1 U426 ( .A(n687), .B(n719), .C(n671), .YC(n525), .YS(n526) );
  HAX1 U427 ( .A(n703), .B(n569), .YC(n527), .YS(n528) );
  FAX1 U428 ( .A(n672), .B(n535), .C(n532), .YC(n529), .YS(n530) );
  FAX1 U429 ( .A(n704), .B(n688), .C(n720), .YC(n531), .YS(n532) );
  FAX1 U430 ( .A(n721), .B(n689), .C(n536), .YC(n533), .YS(n534) );
  HAX1 U431 ( .A(n705), .B(n570), .YC(n535), .YS(n536) );
  FAX1 U432 ( .A(n706), .B(n690), .C(n722), .YC(n537), .YS(n538) );
  HAX1 U433 ( .A(n571), .B(n723), .YC(n539), .YS(n540) );
  NOR2X1 U434 ( .A(n918), .B(n1332), .Y(n573) );
  NOR2X1 U435 ( .A(n918), .B(n1330), .Y(n295) );
  NOR2X1 U436 ( .A(n918), .B(n1328), .Y(n574) );
  NOR2X1 U437 ( .A(n918), .B(n1326), .Y(n305) );
  NOR2X1 U438 ( .A(n918), .B(n730), .Y(n575) );
  NOR2X1 U439 ( .A(n918), .B(n731), .Y(n319) );
  NOR2X1 U440 ( .A(n918), .B(n732), .Y(n576) );
  NOR2X1 U441 ( .A(n918), .B(n1318), .Y(n337) );
  NOR2X1 U442 ( .A(n918), .B(n1316), .Y(n577) );
  NOR2X1 U443 ( .A(n918), .B(n1314), .Y(n359) );
  NOR2X1 U444 ( .A(n918), .B(n1312), .Y(n578) );
  NOR2X1 U445 ( .A(n918), .B(n1310), .Y(n385) );
  NOR2X1 U446 ( .A(n918), .B(n1308), .Y(n579) );
  NOR2X1 U447 ( .A(n1306), .B(n918), .Y(n580) );
  NOR2X1 U448 ( .A(n918), .B(n1304), .Y(n581) );
  OAI22X1 U466 ( .A(n1299), .B(n757), .C(n918), .D(n1301), .Y(n565) );
  OAI22X1 U469 ( .A(n918), .B(n1300), .C(n741), .D(n1301), .Y(n584) );
  OAI22X1 U470 ( .A(n1300), .B(n741), .C(n742), .D(n1301), .Y(n585) );
  OAI22X1 U471 ( .A(n1299), .B(n742), .C(n743), .D(n1301), .Y(n586) );
  OAI22X1 U472 ( .A(n1300), .B(n743), .C(n744), .D(n1301), .Y(n587) );
  OAI22X1 U473 ( .A(n1299), .B(n744), .C(n745), .D(n1301), .Y(n588) );
  OAI22X1 U474 ( .A(n1300), .B(n745), .C(n746), .D(n1301), .Y(n589) );
  OAI22X1 U475 ( .A(n1299), .B(n746), .C(n747), .D(n1301), .Y(n590) );
  OAI22X1 U476 ( .A(n1300), .B(n747), .C(n748), .D(n1301), .Y(n591) );
  OAI22X1 U477 ( .A(n1299), .B(n748), .C(n749), .D(n1301), .Y(n592) );
  OAI22X1 U478 ( .A(n1300), .B(n749), .C(n750), .D(n1301), .Y(n593) );
  OAI22X1 U479 ( .A(n1299), .B(n750), .C(n751), .D(n1301), .Y(n594) );
  OAI22X1 U480 ( .A(n1300), .B(n751), .C(n752), .D(n1301), .Y(n595) );
  OAI22X1 U481 ( .A(n1299), .B(n752), .C(n753), .D(n1301), .Y(n596) );
  OAI22X1 U482 ( .A(n1300), .B(n753), .C(n754), .D(n1301), .Y(n597) );
  OAI22X1 U483 ( .A(n1299), .B(n754), .C(n755), .D(n1301), .Y(n598) );
  OAI22X1 U484 ( .A(n1300), .B(n755), .C(n1301), .D(n756), .Y(n599) );
  AND2X1 U485 ( .A(n1337), .B(n1298), .Y(n600) );
  XNOR2X1 U487 ( .A(n1333), .B(n1336), .Y(n741) );
  XNOR2X1 U488 ( .A(n1331), .B(n1336), .Y(n742) );
  XNOR2X1 U489 ( .A(n1329), .B(n1336), .Y(n743) );
  XNOR2X1 U490 ( .A(n1327), .B(n1336), .Y(n744) );
  XNOR2X1 U491 ( .A(n1325), .B(n1336), .Y(n745) );
  XNOR2X1 U492 ( .A(n1323), .B(n1336), .Y(n746) );
  XNOR2X1 U493 ( .A(n1321), .B(n1335), .Y(n747) );
  XNOR2X1 U494 ( .A(n1319), .B(n1335), .Y(n748) );
  XNOR2X1 U495 ( .A(n1317), .B(n1335), .Y(n749) );
  XNOR2X1 U496 ( .A(n1315), .B(n1335), .Y(n750) );
  XNOR2X1 U497 ( .A(n1313), .B(n1335), .Y(n751) );
  XNOR2X1 U498 ( .A(n1311), .B(n1335), .Y(n752) );
  XNOR2X1 U499 ( .A(n1309), .B(n1335), .Y(n753) );
  XNOR2X1 U500 ( .A(n1336), .B(n1307), .Y(n754) );
  XNOR2X1 U501 ( .A(n998), .B(n1335), .Y(n755) );
  OAI22X1 U505 ( .A(n1295), .B(n774), .C(n1356), .D(n1297), .Y(n566) );
  OAI22X1 U508 ( .A(n1356), .B(n1296), .C(n758), .D(n1297), .Y(n602) );
  OAI22X1 U509 ( .A(n1296), .B(n758), .C(n759), .D(n1297), .Y(n603) );
  OAI22X1 U510 ( .A(n1295), .B(n759), .C(n760), .D(n1297), .Y(n604) );
  OAI22X1 U511 ( .A(n1296), .B(n760), .C(n761), .D(n1297), .Y(n605) );
  OAI22X1 U512 ( .A(n1295), .B(n761), .C(n762), .D(n1297), .Y(n606) );
  OAI22X1 U513 ( .A(n1296), .B(n762), .C(n763), .D(n1274), .Y(n607) );
  OAI22X1 U514 ( .A(n1295), .B(n763), .C(n764), .D(n1297), .Y(n608) );
  OAI22X1 U515 ( .A(n1296), .B(n764), .C(n765), .D(n1297), .Y(n609) );
  OAI22X1 U516 ( .A(n1295), .B(n765), .C(n766), .D(n1274), .Y(n610) );
  OAI22X1 U517 ( .A(n1296), .B(n766), .C(n767), .D(n1297), .Y(n611) );
  OAI22X1 U518 ( .A(n1295), .B(n767), .C(n768), .D(n1297), .Y(n612) );
  OAI22X1 U519 ( .A(n1296), .B(n768), .C(n769), .D(n1297), .Y(n613) );
  OAI22X1 U520 ( .A(n1295), .B(n769), .C(n770), .D(n1297), .Y(n614) );
  OAI22X1 U521 ( .A(n1296), .B(n770), .C(n771), .D(n1297), .Y(n615) );
  OAI22X1 U522 ( .A(n1295), .B(n771), .C(n772), .D(n1274), .Y(n616) );
  OAI22X1 U523 ( .A(n1296), .B(n772), .C(n1297), .D(n773), .Y(n617) );
  AND2X1 U524 ( .A(n1337), .B(n1294), .Y(n618) );
  XNOR2X1 U526 ( .A(n1333), .B(n1006), .Y(n758) );
  XNOR2X1 U527 ( .A(n1331), .B(n1006), .Y(n759) );
  XNOR2X1 U528 ( .A(n1329), .B(n1007), .Y(n760) );
  XNOR2X1 U529 ( .A(n1327), .B(n1006), .Y(n761) );
  XNOR2X1 U530 ( .A(n1325), .B(n1006), .Y(n762) );
  XNOR2X1 U531 ( .A(n1323), .B(n1006), .Y(n763) );
  XNOR2X1 U532 ( .A(n1321), .B(n1007), .Y(n764) );
  XNOR2X1 U533 ( .A(n1319), .B(n1006), .Y(n765) );
  XNOR2X1 U534 ( .A(n1317), .B(n1005), .Y(n766) );
  XNOR2X1 U535 ( .A(n1315), .B(n1005), .Y(n767) );
  XNOR2X1 U536 ( .A(n1313), .B(n1005), .Y(n768) );
  XNOR2X1 U537 ( .A(n1311), .B(n1005), .Y(n769) );
  XNOR2X1 U538 ( .A(n1309), .B(n1007), .Y(n770) );
  XNOR2X1 U539 ( .A(n1307), .B(n1007), .Y(n771) );
  XNOR2X1 U540 ( .A(n999), .B(n1007), .Y(n772) );
  XNOR2X1 U541 ( .A(n996), .B(n1007), .Y(n773) );
  OAI22X1 U544 ( .A(n1075), .B(n791), .C(n1354), .D(n1293), .Y(n567) );
  OAI22X1 U547 ( .A(n1354), .B(n1075), .C(n775), .D(n1292), .Y(n620) );
  OAI22X1 U548 ( .A(n1075), .B(n775), .C(n776), .D(n1293), .Y(n621) );
  OAI22X1 U549 ( .A(n1075), .B(n776), .C(n777), .D(n1292), .Y(n622) );
  OAI22X1 U550 ( .A(n1075), .B(n777), .C(n778), .D(n1293), .Y(n623) );
  OAI22X1 U551 ( .A(n1075), .B(n778), .C(n779), .D(n1292), .Y(n624) );
  OAI22X1 U552 ( .A(n1075), .B(n779), .C(n780), .D(n1293), .Y(n625) );
  OAI22X1 U553 ( .A(n1075), .B(n780), .C(n781), .D(n1292), .Y(n626) );
  OAI22X1 U554 ( .A(n1075), .B(n781), .C(n782), .D(n1292), .Y(n627) );
  OAI22X1 U555 ( .A(n1075), .B(n782), .C(n783), .D(n1293), .Y(n628) );
  OAI22X1 U556 ( .A(n1075), .B(n783), .C(n784), .D(n1292), .Y(n629) );
  OAI22X1 U557 ( .A(n1075), .B(n784), .C(n785), .D(n1293), .Y(n630) );
  OAI22X1 U558 ( .A(n1075), .B(n785), .C(n1292), .D(n786), .Y(n631) );
  OAI22X1 U559 ( .A(n1075), .B(n786), .C(n787), .D(n1293), .Y(n632) );
  OAI22X1 U560 ( .A(n1075), .B(n787), .C(n788), .D(n1292), .Y(n633) );
  OAI22X1 U561 ( .A(n1075), .B(n788), .C(n789), .D(n1293), .Y(n634) );
  OAI22X1 U562 ( .A(n1075), .B(n789), .C(n1292), .D(n790), .Y(n635) );
  AND2X1 U563 ( .A(n1337), .B(n1184), .Y(n636) );
  XNOR2X1 U565 ( .A(n1333), .B(n1352), .Y(n775) );
  XNOR2X1 U566 ( .A(n1331), .B(n1352), .Y(n776) );
  XNOR2X1 U567 ( .A(n1329), .B(n1352), .Y(n777) );
  XNOR2X1 U568 ( .A(n1327), .B(n1352), .Y(n778) );
  XNOR2X1 U569 ( .A(n1325), .B(n1352), .Y(n779) );
  XNOR2X1 U570 ( .A(n1323), .B(n1352), .Y(n780) );
  XNOR2X1 U571 ( .A(n1321), .B(n1353), .Y(n781) );
  XNOR2X1 U572 ( .A(n1319), .B(n1353), .Y(n782) );
  XNOR2X1 U573 ( .A(n1317), .B(n1352), .Y(n783) );
  XNOR2X1 U574 ( .A(n1315), .B(n1352), .Y(n784) );
  XNOR2X1 U575 ( .A(n1313), .B(n1352), .Y(n785) );
  XNOR2X1 U576 ( .A(n1311), .B(n1352), .Y(n786) );
  XNOR2X1 U577 ( .A(n1309), .B(n1352), .Y(n787) );
  XNOR2X1 U578 ( .A(n1307), .B(n1352), .Y(n788) );
  XNOR2X1 U579 ( .A(n999), .B(n1352), .Y(n789) );
  XNOR2X1 U580 ( .A(n995), .B(n1352), .Y(n790) );
  OAI22X1 U583 ( .A(n1288), .B(n808), .C(n1273), .D(n1176), .Y(n568) );
  OAI22X1 U586 ( .A(n1273), .B(n1288), .C(n792), .D(n1176), .Y(n638) );
  OAI22X1 U587 ( .A(n1288), .B(n792), .C(n793), .D(n1176), .Y(n639) );
  OAI22X1 U588 ( .A(n1288), .B(n793), .C(n794), .D(n1176), .Y(n640) );
  OAI22X1 U589 ( .A(n1288), .B(n794), .C(n795), .D(n1251), .Y(n641) );
  OAI22X1 U590 ( .A(n1288), .B(n795), .C(n796), .D(n1251), .Y(n642) );
  OAI22X1 U591 ( .A(n1288), .B(n796), .C(n797), .D(n1251), .Y(n643) );
  OAI22X1 U592 ( .A(n1288), .B(n797), .C(n798), .D(n1251), .Y(n644) );
  OAI22X1 U593 ( .A(n1288), .B(n798), .C(n799), .D(n1289), .Y(n645) );
  OAI22X1 U594 ( .A(n1288), .B(n799), .C(n800), .D(n1289), .Y(n646) );
  OAI22X1 U595 ( .A(n1288), .B(n800), .C(n801), .D(n1289), .Y(n647) );
  OAI22X1 U596 ( .A(n1288), .B(n801), .C(n802), .D(n1176), .Y(n648) );
  OAI22X1 U597 ( .A(n1288), .B(n802), .C(n803), .D(n1176), .Y(n649) );
  OAI22X1 U598 ( .A(n1288), .B(n803), .C(n804), .D(n1176), .Y(n650) );
  OAI22X1 U599 ( .A(n1288), .B(n804), .C(n805), .D(n1176), .Y(n651) );
  OAI22X1 U600 ( .A(n1288), .B(n805), .C(n806), .D(n1176), .Y(n652) );
  OAI22X1 U601 ( .A(n1288), .B(n806), .C(n1176), .D(n807), .Y(n653) );
  AND2X1 U602 ( .A(n1337), .B(n552), .Y(n654) );
  XNOR2X1 U604 ( .A(n1333), .B(n1234), .Y(n792) );
  XNOR2X1 U605 ( .A(n1331), .B(n1235), .Y(n793) );
  XNOR2X1 U606 ( .A(n1329), .B(n1235), .Y(n794) );
  XNOR2X1 U607 ( .A(n1327), .B(n1235), .Y(n795) );
  XNOR2X1 U608 ( .A(n1325), .B(n1349), .Y(n796) );
  XNOR2X1 U609 ( .A(n1323), .B(n1234), .Y(n797) );
  XNOR2X1 U610 ( .A(n1321), .B(n1349), .Y(n798) );
  XNOR2X1 U611 ( .A(n1319), .B(n1234), .Y(n799) );
  XNOR2X1 U612 ( .A(n1317), .B(n1349), .Y(n800) );
  XNOR2X1 U613 ( .A(n1315), .B(n1235), .Y(n801) );
  XNOR2X1 U614 ( .A(n1313), .B(n1349), .Y(n802) );
  XNOR2X1 U615 ( .A(n1311), .B(n1234), .Y(n803) );
  XNOR2X1 U616 ( .A(n1309), .B(n1235), .Y(n804) );
  XNOR2X1 U617 ( .A(n1307), .B(n1349), .Y(n805) );
  XNOR2X1 U618 ( .A(n1000), .B(n1234), .Y(n806) );
  XNOR2X1 U619 ( .A(n996), .B(n1349), .Y(n807) );
  OAI22X1 U622 ( .A(n1284), .B(n825), .C(n1183), .D(n1286), .Y(n569) );
  OAI22X1 U625 ( .A(n1183), .B(n997), .C(n809), .D(n1286), .Y(n656) );
  OAI22X1 U626 ( .A(n997), .B(n809), .C(n810), .D(n1286), .Y(n657) );
  OAI22X1 U628 ( .A(n997), .B(n811), .C(n812), .D(n1286), .Y(n659) );
  OAI22X1 U629 ( .A(n1284), .B(n812), .C(n813), .D(n1286), .Y(n660) );
  OAI22X1 U630 ( .A(n997), .B(n813), .C(n814), .D(n1286), .Y(n661) );
  OAI22X1 U631 ( .A(n1284), .B(n814), .C(n815), .D(n1286), .Y(n662) );
  OAI22X1 U632 ( .A(n997), .B(n815), .C(n816), .D(n1286), .Y(n663) );
  OAI22X1 U633 ( .A(n1284), .B(n816), .C(n817), .D(n1286), .Y(n664) );
  OAI22X1 U634 ( .A(n997), .B(n817), .C(n818), .D(n1286), .Y(n665) );
  OAI22X1 U635 ( .A(n1284), .B(n818), .C(n819), .D(n1286), .Y(n666) );
  OAI22X1 U636 ( .A(n997), .B(n819), .C(n820), .D(n1286), .Y(n667) );
  OAI22X1 U637 ( .A(n1284), .B(n820), .C(n821), .D(n1286), .Y(n668) );
  OAI22X1 U638 ( .A(n997), .B(n821), .C(n822), .D(n1286), .Y(n669) );
  OAI22X1 U639 ( .A(n1284), .B(n822), .C(n823), .D(n1286), .Y(n670) );
  OAI22X1 U640 ( .A(n997), .B(n823), .C(n1286), .D(n824), .Y(n671) );
  AND2X1 U641 ( .A(n1337), .B(n555), .Y(n672) );
  XNOR2X1 U643 ( .A(n1333), .B(n1347), .Y(n809) );
  XNOR2X1 U644 ( .A(n1331), .B(n1347), .Y(n810) );
  XNOR2X1 U645 ( .A(n1329), .B(n1347), .Y(n811) );
  XNOR2X1 U646 ( .A(n1327), .B(n1346), .Y(n812) );
  XNOR2X1 U647 ( .A(n1325), .B(n1346), .Y(n813) );
  XNOR2X1 U648 ( .A(n1323), .B(n1346), .Y(n814) );
  XNOR2X1 U649 ( .A(n1321), .B(n1346), .Y(n815) );
  XNOR2X1 U650 ( .A(n1319), .B(n1346), .Y(n816) );
  XNOR2X1 U651 ( .A(n1317), .B(n1346), .Y(n817) );
  XNOR2X1 U652 ( .A(n1315), .B(n1346), .Y(n818) );
  XNOR2X1 U653 ( .A(n1313), .B(n1346), .Y(n819) );
  XNOR2X1 U654 ( .A(n1311), .B(n1346), .Y(n820) );
  XNOR2X1 U655 ( .A(n1309), .B(n1346), .Y(n821) );
  XNOR2X1 U656 ( .A(n1307), .B(n1346), .Y(n822) );
  XNOR2X1 U657 ( .A(n999), .B(n1346), .Y(n823) );
  XNOR2X1 U658 ( .A(n996), .B(n1346), .Y(n824) );
  OAI22X1 U661 ( .A(n1278), .B(n842), .C(n1142), .D(n1282), .Y(n570) );
  OAI22X1 U664 ( .A(n1142), .B(n1279), .C(n826), .D(n1281), .Y(n674) );
  OAI22X1 U665 ( .A(n1279), .B(n826), .C(n827), .D(n1128), .Y(n675) );
  OAI22X1 U666 ( .A(n1278), .B(n827), .C(n1281), .D(n828), .Y(n676) );
  OAI22X1 U667 ( .A(n1279), .B(n828), .C(n829), .D(n1282), .Y(n677) );
  OAI22X1 U668 ( .A(n1278), .B(n829), .C(n830), .D(n1282), .Y(n678) );
  OAI22X1 U669 ( .A(n1279), .B(n830), .C(n831), .D(n1282), .Y(n679) );
  OAI22X1 U670 ( .A(n1278), .B(n831), .C(n832), .D(n1282), .Y(n680) );
  OAI22X1 U671 ( .A(n1279), .B(n832), .C(n833), .D(n1282), .Y(n681) );
  OAI22X1 U672 ( .A(n1278), .B(n833), .C(n834), .D(n1282), .Y(n682) );
  OAI22X1 U673 ( .A(n1279), .B(n834), .C(n835), .D(n1282), .Y(n683) );
  OAI22X1 U674 ( .A(n1278), .B(n835), .C(n836), .D(n1282), .Y(n684) );
  OAI22X1 U675 ( .A(n1279), .B(n836), .C(n837), .D(n1282), .Y(n685) );
  OAI22X1 U676 ( .A(n1278), .B(n837), .C(n838), .D(n1282), .Y(n686) );
  OAI22X1 U677 ( .A(n1279), .B(n838), .C(n839), .D(n1282), .Y(n687) );
  OAI22X1 U678 ( .A(n1278), .B(n839), .C(n840), .D(n1282), .Y(n688) );
  OAI22X1 U679 ( .A(n1279), .B(n840), .C(n1282), .D(n841), .Y(n689) );
  AND2X1 U680 ( .A(n1337), .B(n558), .Y(n690) );
  XNOR2X1 U682 ( .A(n1333), .B(n1001), .Y(n826) );
  XNOR2X1 U683 ( .A(n1331), .B(n1003), .Y(n827) );
  XNOR2X1 U684 ( .A(n1329), .B(n1001), .Y(n828) );
  XNOR2X1 U685 ( .A(n1327), .B(n1002), .Y(n829) );
  XNOR2X1 U686 ( .A(n1325), .B(n1001), .Y(n830) );
  XNOR2X1 U687 ( .A(n1323), .B(n1001), .Y(n831) );
  XNOR2X1 U688 ( .A(n1321), .B(n1002), .Y(n832) );
  XNOR2X1 U689 ( .A(n1319), .B(n1003), .Y(n833) );
  XNOR2X1 U690 ( .A(n1317), .B(n1002), .Y(n834) );
  XNOR2X1 U691 ( .A(n1315), .B(n1002), .Y(n835) );
  XNOR2X1 U692 ( .A(n1313), .B(n1003), .Y(n836) );
  XNOR2X1 U693 ( .A(n1311), .B(n1003), .Y(n837) );
  XNOR2X1 U694 ( .A(n1309), .B(n1002), .Y(n838) );
  XNOR2X1 U695 ( .A(n1307), .B(n1002), .Y(n839) );
  XNOR2X1 U696 ( .A(n1000), .B(n1003), .Y(n840) );
  XNOR2X1 U697 ( .A(n996), .B(n1003), .Y(n841) );
  OAI22X1 U700 ( .A(n1081), .B(n859), .C(n1177), .D(n1276), .Y(n571) );
  OAI22X1 U703 ( .A(n1178), .B(n1194), .C(n843), .D(n1276), .Y(n692) );
  OAI22X1 U704 ( .A(n1193), .B(n843), .C(n844), .D(n1277), .Y(n693) );
  OAI22X1 U705 ( .A(n1193), .B(n844), .C(n845), .D(n1277), .Y(n694) );
  OAI22X1 U706 ( .A(n1193), .B(n845), .C(n846), .D(n1276), .Y(n695) );
  OAI22X1 U707 ( .A(n1194), .B(n846), .C(n847), .D(n1276), .Y(n696) );
  OAI22X1 U708 ( .A(n1193), .B(n847), .C(n848), .D(n1276), .Y(n697) );
  OAI22X1 U709 ( .A(n1194), .B(n848), .C(n849), .D(n1276), .Y(n698) );
  OAI22X1 U710 ( .A(n1194), .B(n849), .C(n850), .D(n1276), .Y(n699) );
  OAI22X1 U711 ( .A(n1193), .B(n850), .C(n851), .D(n1276), .Y(n700) );
  OAI22X1 U712 ( .A(n1193), .B(n851), .C(n852), .D(n1276), .Y(n701) );
  OAI22X1 U713 ( .A(n1193), .B(n852), .C(n853), .D(n1276), .Y(n702) );
  OAI22X1 U714 ( .A(n1194), .B(n853), .C(n854), .D(n1276), .Y(n703) );
  OAI22X1 U715 ( .A(n1193), .B(n854), .C(n855), .D(n1276), .Y(n704) );
  OAI22X1 U716 ( .A(n1194), .B(n855), .C(n856), .D(n1276), .Y(n705) );
  OAI22X1 U717 ( .A(n1194), .B(n856), .C(n857), .D(n1276), .Y(n706) );
  OAI22X1 U718 ( .A(n1193), .B(n857), .C(n1276), .D(n858), .Y(n707) );
  AND2X1 U719 ( .A(n1337), .B(n561), .Y(n708) );
  XNOR2X1 U722 ( .A(n1331), .B(n1342), .Y(n844) );
  XNOR2X1 U723 ( .A(n1329), .B(n1342), .Y(n845) );
  XNOR2X1 U724 ( .A(n1327), .B(n1342), .Y(n846) );
  XNOR2X1 U725 ( .A(n1325), .B(n1342), .Y(n847) );
  XNOR2X1 U726 ( .A(n1323), .B(n1342), .Y(n848) );
  XNOR2X1 U727 ( .A(n1321), .B(n1342), .Y(n849) );
  XNOR2X1 U728 ( .A(n1319), .B(n1342), .Y(n850) );
  XNOR2X1 U729 ( .A(n1317), .B(n1342), .Y(n851) );
  XNOR2X1 U730 ( .A(n1315), .B(n1342), .Y(n852) );
  XNOR2X1 U731 ( .A(n1313), .B(n1342), .Y(n853) );
  XNOR2X1 U732 ( .A(n1311), .B(n1342), .Y(n854) );
  XNOR2X1 U733 ( .A(n1309), .B(n1342), .Y(n855) );
  XNOR2X1 U734 ( .A(n1307), .B(n1342), .Y(n856) );
  XNOR2X1 U735 ( .A(n1000), .B(n1342), .Y(n857) );
  XNOR2X1 U736 ( .A(n996), .B(n1342), .Y(n858) );
  OAI22X1 U739 ( .A(n917), .B(n876), .C(n1207), .D(n1275), .Y(n572) );
  OAI22X1 U742 ( .A(n917), .B(n1207), .C(n860), .D(n1275), .Y(n710) );
  OAI22X1 U743 ( .A(n917), .B(n860), .C(n861), .D(n1275), .Y(n711) );
  OAI22X1 U744 ( .A(n917), .B(n861), .C(n862), .D(n1275), .Y(n712) );
  OAI22X1 U745 ( .A(n917), .B(n862), .C(n863), .D(n1275), .Y(n713) );
  OAI22X1 U746 ( .A(n917), .B(n863), .C(n864), .D(n1275), .Y(n714) );
  OAI22X1 U747 ( .A(n917), .B(n864), .C(n865), .D(n1275), .Y(n715) );
  OAI22X1 U748 ( .A(n917), .B(n865), .C(n866), .D(n1275), .Y(n716) );
  OAI22X1 U749 ( .A(n917), .B(n866), .C(n867), .D(n1275), .Y(n717) );
  OAI22X1 U750 ( .A(n917), .B(n867), .C(n868), .D(n1275), .Y(n718) );
  OAI22X1 U751 ( .A(n917), .B(n868), .C(n869), .D(n1275), .Y(n719) );
  OAI22X1 U752 ( .A(n917), .B(n869), .C(n870), .D(n1275), .Y(n720) );
  OAI22X1 U753 ( .A(n917), .B(n870), .C(n871), .D(n1275), .Y(n721) );
  OAI22X1 U754 ( .A(n917), .B(n871), .C(n872), .D(n1275), .Y(n722) );
  OAI22X1 U755 ( .A(n917), .B(n872), .C(n873), .D(n1275), .Y(n723) );
  OAI22X1 U756 ( .A(n917), .B(n873), .C(n874), .D(n1275), .Y(n724) );
  OAI22X1 U757 ( .A(n917), .B(n874), .C(n1275), .D(n875), .Y(n725) );
  XNOR2X1 U758 ( .A(n1333), .B(n1339), .Y(n860) );
  XNOR2X1 U759 ( .A(n1331), .B(n1339), .Y(n861) );
  XNOR2X1 U760 ( .A(n1329), .B(n1339), .Y(n862) );
  XNOR2X1 U762 ( .A(n1325), .B(n1339), .Y(n864) );
  XNOR2X1 U763 ( .A(n1323), .B(n1339), .Y(n865) );
  XNOR2X1 U764 ( .A(n1321), .B(n1339), .Y(n866) );
  XNOR2X1 U765 ( .A(n1319), .B(n1339), .Y(n867) );
  XNOR2X1 U766 ( .A(n1317), .B(n1339), .Y(n868) );
  XNOR2X1 U767 ( .A(n1315), .B(n1339), .Y(n869) );
  XNOR2X1 U768 ( .A(n1313), .B(n1339), .Y(n870) );
  XNOR2X1 U769 ( .A(n1311), .B(n1339), .Y(n871) );
  XNOR2X1 U770 ( .A(n1309), .B(n1339), .Y(n872) );
  XNOR2X1 U771 ( .A(n1307), .B(n1339), .Y(n873) );
  XNOR2X1 U772 ( .A(n999), .B(n1339), .Y(n874) );
  XNOR2X1 U773 ( .A(n996), .B(n1339), .Y(n875) );
  XOR2X1 U811 ( .A(n1350), .B(a[23]), .Y(n896) );
  XOR2X1 U823 ( .A(a[15]), .B(n1340), .Y(n900) );
  INVX4 U828 ( .A(n18), .Y(n1280) );
  INVX4 U829 ( .A(n880), .Y(n1326) );
  INVX8 U830 ( .A(n1314), .Y(n1315) );
  INVX8 U831 ( .A(n1330), .Y(n1331) );
  INVX8 U832 ( .A(n1077), .Y(n1286) );
  INVX8 U833 ( .A(n1287), .Y(n1288) );
  BUFX2 U834 ( .A(n1233), .Y(n995) );
  BUFX4 U835 ( .A(n1233), .Y(n996) );
  BUFX2 U836 ( .A(n49), .Y(n1233) );
  BUFX4 U837 ( .A(n1285), .Y(n997) );
  INVX8 U838 ( .A(n1255), .Y(n1297) );
  INVX8 U839 ( .A(n1306), .Y(n1307) );
  INVX4 U840 ( .A(n1272), .Y(n1176) );
  INVX8 U841 ( .A(n1320), .Y(n1321) );
  INVX4 U842 ( .A(n1294), .Y(n1296) );
  BUFX2 U843 ( .A(n1305), .Y(n998) );
  BUFX4 U844 ( .A(n1305), .Y(n999) );
  BUFX2 U845 ( .A(n1305), .Y(n1000) );
  INVX2 U846 ( .A(n1304), .Y(n1305) );
  INVX8 U847 ( .A(n1312), .Y(n1313) );
  INVX4 U848 ( .A(n887), .Y(n1312) );
  BUFX4 U849 ( .A(n137), .Y(n1260) );
  INVX8 U850 ( .A(n1316), .Y(n1317) );
  INVX4 U851 ( .A(n885), .Y(n1316) );
  BUFX4 U852 ( .A(n1344), .Y(n1001) );
  BUFX4 U853 ( .A(n1344), .Y(n1002) );
  BUFX4 U854 ( .A(n1344), .Y(n1003) );
  INVX2 U855 ( .A(n1345), .Y(n1344) );
  BUFX4 U856 ( .A(n369), .Y(n1004) );
  INVX8 U857 ( .A(n1354), .Y(n1353) );
  INVX8 U858 ( .A(n31), .Y(n1354) );
  OR2X1 U859 ( .A(n995), .B(n1354), .Y(n791) );
  INVX8 U860 ( .A(n1280), .Y(n1282) );
  BUFX4 U861 ( .A(n1355), .Y(n1005) );
  BUFX4 U862 ( .A(n1355), .Y(n1006) );
  BUFX4 U863 ( .A(n1355), .Y(n1007) );
  INVX2 U864 ( .A(n1356), .Y(n1355) );
  INVX8 U865 ( .A(n1326), .Y(n1327) );
  INVX8 U866 ( .A(n1328), .Y(n1329) );
  INVX4 U867 ( .A(n879), .Y(n1328) );
  INVX2 U868 ( .A(n19), .Y(n1348) );
  INVX2 U869 ( .A(n13), .Y(n1345) );
  INVX2 U870 ( .A(n36), .Y(n1291) );
  INVX4 U871 ( .A(n37), .Y(n1356) );
  INVX4 U872 ( .A(n1302), .Y(n1303) );
  INVX4 U873 ( .A(n1348), .Y(n1347) );
  INVX4 U874 ( .A(n1341), .Y(n1340) );
  BUFX2 U875 ( .A(n422), .Y(n1257) );
  BUFX2 U876 ( .A(n435), .Y(n1258) );
  INVX2 U877 ( .A(n1001), .Y(n1142) );
  INVX2 U878 ( .A(n1235), .Y(n1273) );
  INVX4 U879 ( .A(n1322), .Y(n1323) );
  INVX4 U880 ( .A(n1348), .Y(n1346) );
  INVX2 U881 ( .A(n610), .Y(n1206) );
  BUFX2 U882 ( .A(n384), .Y(n1159) );
  INVX4 U883 ( .A(n1324), .Y(n1325) );
  INVX4 U884 ( .A(n1291), .Y(n1293) );
  INVX4 U885 ( .A(n1291), .Y(n1292) );
  INVX2 U886 ( .A(n647), .Y(n1009) );
  INVX2 U887 ( .A(n1298), .Y(n1300) );
  INVX4 U888 ( .A(n1076), .Y(n1301) );
  INVX2 U889 ( .A(n51), .Y(n1302) );
  BUFX2 U890 ( .A(n441), .Y(n1008) );
  XOR2X1 U891 ( .A(n1009), .B(n1010), .Y(n454) );
  XNOR2X1 U892 ( .A(n663), .B(n599), .Y(n1010) );
  OR2X2 U893 ( .A(n996), .B(n1207), .Y(n876) );
  OR2X2 U894 ( .A(n996), .B(n1178), .Y(n859) );
  OR2X2 U895 ( .A(n996), .B(n918), .Y(n757) );
  OR2X2 U896 ( .A(n996), .B(n1142), .Y(n842) );
  OR2X2 U897 ( .A(n996), .B(n1273), .Y(n808) );
  OR2X2 U898 ( .A(n996), .B(n1183), .Y(n825) );
  OR2X2 U899 ( .A(n995), .B(n1356), .Y(n774) );
  OR2X2 U900 ( .A(n339), .B(n330), .Y(n1011) );
  INVX1 U901 ( .A(n1011), .Y(n148) );
  INVX2 U902 ( .A(n406), .Y(n1130) );
  XOR2X1 U903 ( .A(n400), .B(n398), .Y(n1012) );
  XOR2X1 U904 ( .A(n396), .B(n1012), .Y(n392) );
  NAND2X1 U905 ( .A(n396), .B(n400), .Y(n1013) );
  NAND2X1 U906 ( .A(n396), .B(n398), .Y(n1014) );
  NAND2X1 U907 ( .A(n400), .B(n398), .Y(n1015) );
  NAND3X1 U908 ( .A(n1014), .B(n1013), .C(n1015), .Y(n391) );
  XOR2X1 U909 ( .A(n445), .B(n434), .Y(n1016) );
  XOR2X1 U910 ( .A(n432), .B(n1016), .Y(n430) );
  NAND2X1 U911 ( .A(n432), .B(n445), .Y(n1017) );
  NAND2X1 U912 ( .A(n432), .B(n434), .Y(n1018) );
  NAND2X1 U913 ( .A(n445), .B(n434), .Y(n1019) );
  NAND3X1 U914 ( .A(n1018), .B(n1017), .C(n1019), .Y(n429) );
  XOR2X1 U915 ( .A(n327), .B(n604), .Y(n1020) );
  XOR2X1 U916 ( .A(n325), .B(n1020), .Y(n316) );
  NAND2X1 U917 ( .A(n325), .B(n327), .Y(n1021) );
  NAND2X1 U918 ( .A(n325), .B(n604), .Y(n1022) );
  NAND2X1 U919 ( .A(n327), .B(n604), .Y(n1023) );
  NAND3X1 U920 ( .A(n1022), .B(n1021), .C(n1023), .Y(n315) );
  XOR2X1 U921 ( .A(n464), .B(n468), .Y(n1024) );
  XOR2X1 U922 ( .A(n473), .B(n1024), .Y(n460) );
  NAND2X1 U923 ( .A(n473), .B(n464), .Y(n1025) );
  NAND2X1 U924 ( .A(n473), .B(n468), .Y(n1026) );
  NAND2X1 U925 ( .A(n464), .B(n468), .Y(n1027) );
  NAND3X1 U926 ( .A(n1026), .B(n1025), .C(n1027), .Y(n459) );
  XOR2X1 U927 ( .A(n490), .B(n488), .Y(n1028) );
  XOR2X1 U928 ( .A(n495), .B(n1028), .Y(n484) );
  NAND2X1 U929 ( .A(n495), .B(n490), .Y(n1029) );
  NAND2X1 U930 ( .A(n495), .B(n488), .Y(n1030) );
  NAND2X1 U931 ( .A(n490), .B(n488), .Y(n1031) );
  NAND3X1 U932 ( .A(n1030), .B(n1029), .C(n1031), .Y(n483) );
  XOR2X1 U933 ( .A(n1259), .B(n580), .Y(n1032) );
  XOR2X1 U934 ( .A(n1032), .B(n692), .Y(n414) );
  NAND2X1 U935 ( .A(n1259), .B(n580), .Y(n1033) );
  NAND2X1 U936 ( .A(n1259), .B(n692), .Y(n1034) );
  NAND2X1 U937 ( .A(n580), .B(n692), .Y(n1035) );
  NAND3X1 U938 ( .A(n1033), .B(n1034), .C(n1035), .Y(n413) );
  XOR2X1 U939 ( .A(n411), .B(n409), .Y(n1036) );
  XOR2X1 U940 ( .A(n1036), .B(n413), .Y(n394) );
  NAND2X1 U941 ( .A(n411), .B(n409), .Y(n1037) );
  NAND2X1 U942 ( .A(n411), .B(n413), .Y(n1038) );
  NAND2X1 U943 ( .A(n409), .B(n413), .Y(n1039) );
  NAND3X1 U944 ( .A(n1037), .B(n1038), .C(n1039), .Y(n393) );
  XOR2X1 U945 ( .A(n675), .B(n709), .Y(n1040) );
  XOR2X1 U946 ( .A(n595), .B(n1040), .Y(n398) );
  NAND2X1 U947 ( .A(n595), .B(n675), .Y(n1041) );
  NAND2X1 U948 ( .A(n595), .B(n709), .Y(n1042) );
  NAND2X1 U949 ( .A(n675), .B(n709), .Y(n1043) );
  NAND3X1 U950 ( .A(n1042), .B(n1041), .C(n1043), .Y(n397) );
  XOR2X1 U951 ( .A(n453), .B(n455), .Y(n1044) );
  XOR2X1 U952 ( .A(n451), .B(n1044), .Y(n436) );
  NAND2X1 U953 ( .A(n451), .B(n453), .Y(n1045) );
  NAND2X1 U954 ( .A(n451), .B(n455), .Y(n1046) );
  NAND2X1 U955 ( .A(n453), .B(n455), .Y(n1047) );
  NAND3X1 U956 ( .A(n1046), .B(n1045), .C(n1047), .Y(n435) );
  XOR2X1 U957 ( .A(n440), .B(n438), .Y(n1048) );
  XOR2X1 U958 ( .A(n1196), .B(n1048), .Y(n434) );
  NAND2X1 U959 ( .A(n1196), .B(n440), .Y(n1049) );
  NAND2X1 U960 ( .A(n1196), .B(n438), .Y(n1050) );
  NAND2X1 U961 ( .A(n440), .B(n438), .Y(n1051) );
  NAND3X1 U962 ( .A(n1050), .B(n1049), .C(n1051), .Y(n433) );
  INVX2 U963 ( .A(n1195), .Y(n1196) );
  XOR2X1 U964 ( .A(n646), .B(n582), .Y(n1052) );
  XOR2X1 U965 ( .A(n694), .B(n1052), .Y(n442) );
  NAND2X1 U966 ( .A(n694), .B(n646), .Y(n1053) );
  NAND2X1 U967 ( .A(n694), .B(n582), .Y(n1054) );
  NAND2X1 U968 ( .A(n646), .B(n582), .Y(n1055) );
  NAND3X1 U969 ( .A(n1054), .B(n1053), .C(n1055), .Y(n441) );
  XOR2X1 U970 ( .A(n397), .B(n626), .Y(n1056) );
  XOR2X1 U971 ( .A(n399), .B(n1056), .Y(n380) );
  NAND2X1 U972 ( .A(n399), .B(n397), .Y(n1057) );
  NAND2X1 U973 ( .A(n399), .B(n626), .Y(n1058) );
  NAND2X1 U974 ( .A(n397), .B(n626), .Y(n1059) );
  NAND3X1 U975 ( .A(n1058), .B(n1057), .C(n1059), .Y(n379) );
  NAND2X1 U976 ( .A(n647), .B(n663), .Y(n1060) );
  NAND2X1 U977 ( .A(n647), .B(n599), .Y(n1061) );
  NAND2X1 U978 ( .A(n663), .B(n599), .Y(n1062) );
  NAND3X1 U979 ( .A(n1061), .B(n1060), .C(n1062), .Y(n453) );
  XOR2X1 U980 ( .A(n439), .B(n424), .Y(n1063) );
  XOR2X1 U981 ( .A(n426), .B(n1063), .Y(n420) );
  NAND2X1 U982 ( .A(n426), .B(n439), .Y(n1064) );
  NAND2X1 U983 ( .A(n426), .B(n424), .Y(n1065) );
  NAND2X1 U984 ( .A(n439), .B(n424), .Y(n1066) );
  NAND3X1 U985 ( .A(n1065), .B(n1064), .C(n1066), .Y(n419) );
  XOR2X1 U986 ( .A(n1259), .B(n581), .Y(n1067) );
  XOR2X1 U987 ( .A(n693), .B(n1067), .Y(n428) );
  NAND2X1 U988 ( .A(n693), .B(n1259), .Y(n1068) );
  NAND2X1 U989 ( .A(n693), .B(n581), .Y(n1069) );
  NAND2X1 U990 ( .A(n1259), .B(n581), .Y(n1070) );
  NAND3X1 U991 ( .A(n1069), .B(n1068), .C(n1070), .Y(n427) );
  XOR2X1 U992 ( .A(n367), .B(n356), .Y(n1071) );
  XOR2X1 U993 ( .A(n365), .B(n1071), .Y(n352) );
  NAND2X1 U994 ( .A(n365), .B(n367), .Y(n1072) );
  NAND2X1 U995 ( .A(n365), .B(n356), .Y(n1073) );
  NAND2X1 U996 ( .A(n367), .B(n356), .Y(n1074) );
  NAND3X1 U997 ( .A(n1073), .B(n1072), .C(n1074), .Y(n351) );
  BUFX4 U998 ( .A(n1290), .Y(n1075) );
  INVX1 U999 ( .A(n1184), .Y(n1290) );
  INVX4 U1000 ( .A(n1310), .Y(n1311) );
  INVX4 U1001 ( .A(n1), .Y(n1341) );
  INVX1 U1002 ( .A(n891), .Y(n1304) );
  INVX2 U1003 ( .A(n877), .Y(n1332) );
  INVX4 U1004 ( .A(n1332), .Y(n1333) );
  AND2X2 U1005 ( .A(n46), .B(n1180), .Y(n1076) );
  INVX2 U1006 ( .A(n1255), .Y(n1274) );
  AND2X2 U1007 ( .A(n1156), .B(n22), .Y(n1077) );
  OR2X2 U1008 ( .A(n308), .B(n313), .Y(n1078) );
  AND2X2 U1009 ( .A(n169), .B(n283), .Y(n1079) );
  AND2X2 U1010 ( .A(n162), .B(n282), .Y(n1080) );
  INVX4 U1011 ( .A(n1318), .Y(n1319) );
  INVX4 U1012 ( .A(n1308), .Y(n1309) );
  INVX2 U1013 ( .A(n889), .Y(n1308) );
  INVX2 U1014 ( .A(n888), .Y(n1310) );
  XNOR2X1 U1015 ( .A(n1340), .B(a[17]), .Y(n1081) );
  INVX2 U1016 ( .A(n878), .Y(n1330) );
  OR2X2 U1017 ( .A(n292), .B(n293), .Y(n1082) );
  XNOR2X1 U1018 ( .A(n995), .B(n1335), .Y(n756) );
  INVX2 U1019 ( .A(n881), .Y(n1324) );
  INVX1 U1020 ( .A(n1288), .Y(n552) );
  INVX2 U1021 ( .A(n886), .Y(n1314) );
  XOR2X1 U1022 ( .A(n678), .B(n662), .Y(n1083) );
  XOR2X1 U1023 ( .A(n1083), .B(n614), .Y(n438) );
  NAND2X1 U1024 ( .A(n662), .B(n678), .Y(n1084) );
  NAND2X1 U1025 ( .A(n678), .B(n614), .Y(n1085) );
  NAND2X1 U1026 ( .A(n662), .B(n614), .Y(n1086) );
  NAND3X1 U1027 ( .A(n1084), .B(n1085), .C(n1086), .Y(n437) );
  XOR2X1 U1028 ( .A(n428), .B(n441), .Y(n1087) );
  XOR2X1 U1029 ( .A(n1087), .B(n437), .Y(n422) );
  NAND2X1 U1030 ( .A(n428), .B(n441), .Y(n1088) );
  NAND2X1 U1031 ( .A(n428), .B(n437), .Y(n1089) );
  NAND2X1 U1032 ( .A(n1008), .B(n437), .Y(n1090) );
  NAND3X1 U1033 ( .A(n1088), .B(n1089), .C(n1090), .Y(n421) );
  XNOR2X1 U1034 ( .A(n1333), .B(n1342), .Y(n843) );
  INVX2 U1035 ( .A(n1131), .Y(n1128) );
  XOR2X1 U1036 ( .A(n393), .B(n380), .Y(n1091) );
  XOR2X1 U1037 ( .A(n1091), .B(n391), .Y(n376) );
  XOR2X1 U1038 ( .A(n378), .B(n389), .Y(n1092) );
  XOR2X1 U1039 ( .A(n1092), .B(n376), .Y(n374) );
  NAND2X1 U1040 ( .A(n393), .B(n380), .Y(n1093) );
  NAND2X1 U1041 ( .A(n393), .B(n391), .Y(n1094) );
  NAND2X1 U1042 ( .A(n380), .B(n391), .Y(n1095) );
  NAND3X1 U1043 ( .A(n1093), .B(n1094), .C(n1095), .Y(n375) );
  NAND2X1 U1044 ( .A(n378), .B(n389), .Y(n1096) );
  NAND2X1 U1045 ( .A(n378), .B(n376), .Y(n1097) );
  NAND2X1 U1046 ( .A(n389), .B(n376), .Y(n1098) );
  NAND3X1 U1047 ( .A(n1096), .B(n1097), .C(n1098), .Y(n373) );
  XOR2X1 U1048 ( .A(n1159), .B(n395), .Y(n1099) );
  XOR2X1 U1049 ( .A(n1099), .B(n382), .Y(n378) );
  NAND2X1 U1050 ( .A(n1159), .B(n395), .Y(n1100) );
  NAND2X1 U1051 ( .A(n1159), .B(n382), .Y(n1101) );
  NAND2X1 U1052 ( .A(n395), .B(n382), .Y(n1102) );
  NAND3X1 U1053 ( .A(n1100), .B(n1101), .C(n1102), .Y(n377) );
  XOR2X1 U1054 ( .A(n368), .B(n379), .Y(n1103) );
  XOR2X1 U1055 ( .A(n1103), .B(n377), .Y(n364) );
  NAND2X1 U1056 ( .A(n368), .B(n379), .Y(n1104) );
  NAND2X1 U1057 ( .A(n368), .B(n377), .Y(n1105) );
  NAND2X1 U1058 ( .A(n379), .B(n377), .Y(n1106) );
  NAND3X1 U1059 ( .A(n1104), .B(n1105), .C(n1106), .Y(n363) );
  XOR2X1 U1060 ( .A(n664), .B(n632), .Y(n1107) );
  XOR2X1 U1061 ( .A(n1107), .B(n712), .Y(n466) );
  XOR2X1 U1062 ( .A(n477), .B(n475), .Y(n1108) );
  XOR2X1 U1063 ( .A(n1108), .B(n466), .Y(n462) );
  NAND2X1 U1064 ( .A(n664), .B(n632), .Y(n1109) );
  NAND2X1 U1065 ( .A(n664), .B(n712), .Y(n1110) );
  NAND2X1 U1066 ( .A(n632), .B(n712), .Y(n1111) );
  NAND3X1 U1067 ( .A(n1109), .B(n1110), .C(n1111), .Y(n465) );
  NAND2X1 U1068 ( .A(n477), .B(n475), .Y(n1112) );
  NAND2X1 U1069 ( .A(n477), .B(n466), .Y(n1113) );
  NAND2X1 U1070 ( .A(n475), .B(n466), .Y(n1114) );
  NAND3X1 U1071 ( .A(n1112), .B(n1113), .C(n1114), .Y(n461) );
  INVX1 U1072 ( .A(n350), .Y(n1115) );
  INVX1 U1073 ( .A(n1115), .Y(n1116) );
  XNOR2X1 U1074 ( .A(n154), .B(n1117), .Y(product[39]) );
  AND2X2 U1075 ( .A(n149), .B(n1011), .Y(n1117) );
  XNOR2X1 U1076 ( .A(n1179), .B(n1345), .Y(n1218) );
  XNOR2X1 U1077 ( .A(n86), .B(n1118), .Y(product[45]) );
  AND2X2 U1078 ( .A(n85), .B(n275), .Y(n1118) );
  INVX1 U1079 ( .A(n1302), .Y(n1119) );
  INVX1 U1080 ( .A(a[19]), .Y(n1179) );
  XOR2X1 U1081 ( .A(n666), .B(n499), .Y(n1120) );
  XOR2X1 U1082 ( .A(n1120), .B(n497), .Y(n486) );
  NAND2X1 U1083 ( .A(n666), .B(n499), .Y(n1121) );
  NAND2X1 U1084 ( .A(n666), .B(n497), .Y(n1122) );
  NAND2X1 U1085 ( .A(n499), .B(n497), .Y(n1123) );
  NAND3X1 U1086 ( .A(n1121), .B(n1122), .C(n1123), .Y(n485) );
  XOR2X1 U1087 ( .A(n476), .B(n478), .Y(n1124) );
  XOR2X1 U1088 ( .A(n1124), .B(n485), .Y(n472) );
  NAND2X1 U1089 ( .A(n476), .B(n478), .Y(n1125) );
  NAND2X1 U1090 ( .A(n476), .B(n485), .Y(n1126) );
  NAND2X1 U1091 ( .A(n478), .B(n485), .Y(n1127) );
  NAND3X1 U1092 ( .A(n1125), .B(n1126), .C(n1127), .Y(n471) );
  INVX1 U1093 ( .A(n1131), .Y(n1281) );
  BUFX2 U1094 ( .A(n415), .Y(n1129) );
  XNOR2X1 U1095 ( .A(n1130), .B(n417), .Y(n1144) );
  INVX1 U1096 ( .A(n100), .Y(n98) );
  INVX2 U1097 ( .A(n18), .Y(n1131) );
  XOR2X1 U1098 ( .A(n465), .B(n452), .Y(n1132) );
  XOR2X1 U1099 ( .A(n1132), .B(n454), .Y(n448) );
  NAND2X1 U1100 ( .A(n465), .B(n452), .Y(n1133) );
  NAND2X1 U1101 ( .A(n465), .B(n454), .Y(n1134) );
  NAND2X1 U1102 ( .A(n452), .B(n454), .Y(n1135) );
  NAND3X1 U1103 ( .A(n1133), .B(n1134), .C(n1135), .Y(n447) );
  XOR2X1 U1104 ( .A(n449), .B(n436), .Y(n1136) );
  XOR2X1 U1105 ( .A(n1136), .B(n447), .Y(n432) );
  NAND2X1 U1106 ( .A(n449), .B(n436), .Y(n1137) );
  NAND2X1 U1107 ( .A(n449), .B(n447), .Y(n1138) );
  NAND2X1 U1108 ( .A(n436), .B(n447), .Y(n1139) );
  NAND3X1 U1109 ( .A(n1139), .B(n1138), .C(n1137), .Y(n431) );
  INVX4 U1110 ( .A(n1351), .Y(n1349) );
  INVX1 U1111 ( .A(n1343), .Y(n1140) );
  XNOR2X1 U1112 ( .A(n145), .B(n1141), .Y(product[40]) );
  AND2X2 U1113 ( .A(n144), .B(n1237), .Y(n1141) );
  XOR2X1 U1114 ( .A(n421), .B(n408), .Y(n1143) );
  XOR2X1 U1115 ( .A(n1143), .B(n419), .Y(n404) );
  XOR2X1 U1116 ( .A(n1144), .B(n404), .Y(n402) );
  NAND2X1 U1117 ( .A(n421), .B(n408), .Y(n1145) );
  NAND2X1 U1118 ( .A(n421), .B(n419), .Y(n1146) );
  NAND2X1 U1119 ( .A(n408), .B(n419), .Y(n1147) );
  NAND3X1 U1120 ( .A(n1145), .B(n1146), .C(n1147), .Y(n403) );
  NAND2X1 U1121 ( .A(n406), .B(n417), .Y(n1148) );
  NAND2X1 U1122 ( .A(n406), .B(n404), .Y(n1149) );
  NAND2X1 U1123 ( .A(n417), .B(n404), .Y(n1150) );
  NAND3X1 U1124 ( .A(n1148), .B(n1149), .C(n1150), .Y(n401) );
  XOR2X1 U1125 ( .A(n597), .B(n613), .Y(n1151) );
  XOR2X1 U1126 ( .A(n629), .B(n1151), .Y(n426) );
  NAND2X1 U1127 ( .A(n629), .B(n597), .Y(n1152) );
  NAND2X1 U1128 ( .A(n629), .B(n613), .Y(n1153) );
  NAND2X1 U1129 ( .A(n597), .B(n613), .Y(n1154) );
  NAND3X1 U1130 ( .A(n1153), .B(n1152), .C(n1154), .Y(n425) );
  INVX1 U1131 ( .A(n222), .Y(n221) );
  XNOR2X1 U1132 ( .A(n112), .B(n1155), .Y(product[43]) );
  AND2X2 U1133 ( .A(n111), .B(n1238), .Y(n1155) );
  XOR2X1 U1134 ( .A(n1347), .B(a[21]), .Y(n1156) );
  XOR2X1 U1135 ( .A(n1348), .B(a[23]), .Y(n28) );
  AND2X2 U1136 ( .A(n159), .B(n171), .Y(n1157) );
  INVX4 U1137 ( .A(n1157), .Y(n53) );
  NOR2X1 U1138 ( .A(n373), .B(n362), .Y(n1158) );
  INVX4 U1139 ( .A(n1166), .Y(n1259) );
  INVX4 U1140 ( .A(n1341), .Y(n1339) );
  XOR2X1 U1141 ( .A(n341), .B(n343), .Y(n1160) );
  XOR2X1 U1142 ( .A(n1160), .B(n332), .Y(n330) );
  NAND2X1 U1143 ( .A(n332), .B(n341), .Y(n1161) );
  NAND2X1 U1144 ( .A(n332), .B(n343), .Y(n1162) );
  NAND2X1 U1145 ( .A(n341), .B(n343), .Y(n1163) );
  NAND3X1 U1146 ( .A(n1162), .B(n1161), .C(n1163), .Y(n329) );
  BUFX2 U1147 ( .A(n200), .Y(n1164) );
  INVX1 U1148 ( .A(n171), .Y(n173) );
  INVX2 U1149 ( .A(n22), .Y(n1283) );
  INVX4 U1150 ( .A(n7), .Y(n1177) );
  INVX2 U1151 ( .A(n40), .Y(n1294) );
  XOR2X1 U1152 ( .A(n1340), .B(a[17]), .Y(n1165) );
  XNOR2X1 U1153 ( .A(n1343), .B(a[17]), .Y(n899) );
  INVX2 U1154 ( .A(n7), .Y(n1343) );
  AOI22X1 U1155 ( .A(a[15]), .B(n1167), .C(n1253), .D(n1167), .Y(n1166) );
  INVX2 U1156 ( .A(n1207), .Y(n1167) );
  XNOR2X1 U1157 ( .A(n1334), .B(a[29]), .Y(n1180) );
  AND2X2 U1158 ( .A(n1337), .B(n1336), .Y(n582) );
  XOR2X1 U1159 ( .A(n385), .B(n578), .Y(n1168) );
  XOR2X1 U1160 ( .A(n1168), .B(n641), .Y(n372) );
  XOR2X1 U1161 ( .A(n625), .B(n609), .Y(n1169) );
  XOR2X1 U1162 ( .A(n1169), .B(n372), .Y(n368) );
  NAND2X1 U1163 ( .A(n385), .B(n578), .Y(n1170) );
  NAND2X1 U1164 ( .A(n385), .B(n641), .Y(n1171) );
  NAND2X1 U1165 ( .A(n578), .B(n641), .Y(n1172) );
  NAND3X1 U1166 ( .A(n1170), .B(n1171), .C(n1172), .Y(n371) );
  NAND2X1 U1167 ( .A(n625), .B(n609), .Y(n1173) );
  NAND2X1 U1168 ( .A(n625), .B(n372), .Y(n1174) );
  NAND2X1 U1169 ( .A(n609), .B(n372), .Y(n1175) );
  NAND3X1 U1170 ( .A(n1173), .B(n1174), .C(n1175), .Y(n367) );
  INVX2 U1171 ( .A(n1272), .Y(n1289) );
  INVX1 U1172 ( .A(n1140), .Y(n1178) );
  INVX2 U1173 ( .A(n1165), .Y(n1193) );
  INVX2 U1174 ( .A(n46), .Y(n1298) );
  XNOR2X1 U1175 ( .A(n1326), .B(n1207), .Y(n863) );
  INVX1 U1176 ( .A(n25), .Y(n1181) );
  INVX1 U1177 ( .A(n25), .Y(n1182) );
  INVX1 U1178 ( .A(n25), .Y(n1351) );
  INVX1 U1179 ( .A(n1347), .Y(n1183) );
  XOR2X1 U1180 ( .A(a[25]), .B(n25), .Y(n1184) );
  XOR2X1 U1181 ( .A(n360), .B(n656), .Y(n1185) );
  XOR2X1 U1182 ( .A(n1185), .B(n592), .Y(n358) );
  XOR2X1 U1183 ( .A(n371), .B(n1004), .Y(n1186) );
  XOR2X1 U1184 ( .A(n1186), .B(n358), .Y(n354) );
  NAND2X1 U1185 ( .A(n360), .B(n656), .Y(n1187) );
  NAND2X1 U1186 ( .A(n360), .B(n592), .Y(n1188) );
  NAND2X1 U1187 ( .A(n656), .B(n592), .Y(n1189) );
  NAND3X1 U1188 ( .A(n1187), .B(n1188), .C(n1189), .Y(n357) );
  NAND2X1 U1189 ( .A(n371), .B(n1004), .Y(n1190) );
  NAND2X1 U1190 ( .A(n371), .B(n358), .Y(n1191) );
  NAND2X1 U1191 ( .A(n1004), .B(n358), .Y(n1192) );
  NAND3X1 U1192 ( .A(n1190), .B(n1191), .C(n1192), .Y(n353) );
  INVX1 U1193 ( .A(n1165), .Y(n1194) );
  INVX2 U1194 ( .A(n442), .Y(n1195) );
  XOR2X1 U1195 ( .A(n403), .B(n392), .Y(n1197) );
  XOR2X1 U1196 ( .A(n390), .B(n1197), .Y(n388) );
  NAND2X1 U1197 ( .A(n390), .B(n403), .Y(n1198) );
  NAND2X1 U1198 ( .A(n390), .B(n392), .Y(n1199) );
  NAND2X1 U1199 ( .A(n403), .B(n392), .Y(n1200) );
  NAND3X1 U1200 ( .A(n1199), .B(n1198), .C(n1200), .Y(n387) );
  XOR2X1 U1201 ( .A(n394), .B(n407), .Y(n1201) );
  XOR2X1 U1202 ( .A(n1205), .B(n1201), .Y(n390) );
  NAND2X1 U1203 ( .A(n405), .B(n394), .Y(n1202) );
  NAND2X1 U1204 ( .A(n405), .B(n407), .Y(n1203) );
  NAND2X1 U1205 ( .A(n394), .B(n407), .Y(n1204) );
  NAND3X1 U1206 ( .A(n1203), .B(n1202), .C(n1204), .Y(n389) );
  BUFX2 U1207 ( .A(n405), .Y(n1205) );
  XNOR2X1 U1208 ( .A(n1356), .B(a[27]), .Y(n894) );
  XNOR2X1 U1209 ( .A(n170), .B(n1079), .Y(product[37]) );
  XNOR2X1 U1210 ( .A(n1262), .B(n1206), .Y(n382) );
  INVX2 U1211 ( .A(n1283), .Y(n1285) );
  INVX1 U1212 ( .A(n210), .Y(n289) );
  XNOR2X1 U1213 ( .A(n163), .B(n1080), .Y(product[38]) );
  INVX2 U1214 ( .A(n560), .Y(n691) );
  BUFX2 U1215 ( .A(n1341), .Y(n1207) );
  OR2X2 U1216 ( .A(n1208), .B(n1184), .Y(n36) );
  XNOR2X1 U1217 ( .A(n1353), .B(a[25]), .Y(n1208) );
  INVX2 U1218 ( .A(n1256), .Y(n1277) );
  NOR2X1 U1219 ( .A(n457), .B(n444), .Y(n1209) );
  XOR2X1 U1220 ( .A(n565), .B(n456), .Y(n1210) );
  XOR2X1 U1221 ( .A(n1210), .B(n467), .Y(n450) );
  XOR2X1 U1222 ( .A(n463), .B(n461), .Y(n1211) );
  XOR2X1 U1223 ( .A(n1211), .B(n450), .Y(n446) );
  NAND2X1 U1224 ( .A(n565), .B(n456), .Y(n1212) );
  NAND2X1 U1225 ( .A(n565), .B(n467), .Y(n1213) );
  NAND2X1 U1226 ( .A(n456), .B(n467), .Y(n1214) );
  NAND3X1 U1227 ( .A(n1212), .B(n1213), .C(n1214), .Y(n449) );
  NAND2X1 U1228 ( .A(n463), .B(n461), .Y(n1215) );
  NAND2X1 U1229 ( .A(n463), .B(n450), .Y(n1216) );
  NAND2X1 U1230 ( .A(n461), .B(n450), .Y(n1217) );
  NAND3X1 U1231 ( .A(n1215), .B(n1216), .C(n1217), .Y(n445) );
  XOR2X1 U1232 ( .A(n1354), .B(a[27]), .Y(n40) );
  OR2X2 U1233 ( .A(n1218), .B(n1254), .Y(n18) );
  INVX2 U1234 ( .A(n1254), .Y(n1279) );
  INVX1 U1235 ( .A(n53), .Y(n155) );
  XOR2X1 U1236 ( .A(n1258), .B(n1257), .Y(n1219) );
  XOR2X1 U1237 ( .A(n1219), .B(n433), .Y(n418) );
  XOR2X1 U1238 ( .A(n420), .B(n431), .Y(n1220) );
  XOR2X1 U1239 ( .A(n1220), .B(n418), .Y(n416) );
  NAND2X1 U1240 ( .A(n1258), .B(n1257), .Y(n1221) );
  NAND2X1 U1241 ( .A(n1258), .B(n433), .Y(n1222) );
  NAND2X1 U1242 ( .A(n1257), .B(n433), .Y(n1223) );
  NAND3X1 U1243 ( .A(n1221), .B(n1222), .C(n1223), .Y(n417) );
  NAND2X1 U1244 ( .A(n420), .B(n431), .Y(n1224) );
  NAND2X1 U1245 ( .A(n418), .B(n420), .Y(n1225) );
  NAND2X1 U1246 ( .A(n431), .B(n418), .Y(n1226) );
  NAND3X1 U1247 ( .A(n1224), .B(n1225), .C(n1226), .Y(n415) );
  INVX1 U1248 ( .A(n402), .Y(n1227) );
  INVX1 U1249 ( .A(n1227), .Y(n1228) );
  XOR2X1 U1250 ( .A(n425), .B(n427), .Y(n1229) );
  XOR2X1 U1251 ( .A(n1229), .B(n414), .Y(n408) );
  NAND2X1 U1252 ( .A(n414), .B(n425), .Y(n1230) );
  NAND2X1 U1253 ( .A(n414), .B(n427), .Y(n1231) );
  NAND2X1 U1254 ( .A(n425), .B(n427), .Y(n1232) );
  NAND3X1 U1255 ( .A(n1231), .B(n1230), .C(n1232), .Y(n407) );
  INVX1 U1256 ( .A(n84), .Y(n275) );
  INVX2 U1257 ( .A(n1181), .Y(n1235) );
  INVX2 U1258 ( .A(n1181), .Y(n1234) );
  INVX1 U1259 ( .A(n49), .Y(n1338) );
  OR2X2 U1260 ( .A(n1260), .B(n80), .Y(n1236) );
  OR2X2 U1261 ( .A(n322), .B(n329), .Y(n1237) );
  OR2X2 U1262 ( .A(n481), .B(n470), .Y(n1239) );
  OR2X2 U1263 ( .A(n302), .B(n307), .Y(n1238) );
  INVX2 U1264 ( .A(n1259), .Y(n709) );
  INVX4 U1265 ( .A(n1253), .Y(n1275) );
  INVX4 U1266 ( .A(n1256), .Y(n1276) );
  INVX2 U1267 ( .A(n883), .Y(n1320) );
  INVX2 U1268 ( .A(n884), .Y(n1318) );
  INVX2 U1269 ( .A(n882), .Y(n1322) );
  OR2X1 U1270 ( .A(n523), .B(n518), .Y(n1240) );
  AND2X2 U1271 ( .A(n491), .B(n482), .Y(n1241) );
  OR2X1 U1272 ( .A(n491), .B(n482), .Y(n1242) );
  AND2X2 U1273 ( .A(n481), .B(n470), .Y(n1243) );
  AND2X2 U1274 ( .A(n523), .B(n518), .Y(n1244) );
  INVX2 U1275 ( .A(n554), .Y(n655) );
  INVX2 U1276 ( .A(n551), .Y(n637) );
  OR2X1 U1277 ( .A(n533), .B(n530), .Y(n1245) );
  OR2X1 U1278 ( .A(n539), .B(n538), .Y(n1246) );
  OR2X1 U1279 ( .A(n708), .B(n724), .Y(n1247) );
  AND2X2 U1280 ( .A(n708), .B(n724), .Y(n1248) );
  AND2X2 U1281 ( .A(n533), .B(n530), .Y(n1249) );
  AND2X2 U1282 ( .A(n539), .B(n538), .Y(n1250) );
  XNOR2X1 U1283 ( .A(n542), .B(n573), .Y(n291) );
  INVX2 U1284 ( .A(n548), .Y(n619) );
  INVX4 U1285 ( .A(n1334), .Y(n1335) );
  INVX2 U1286 ( .A(n545), .Y(n601) );
  INVX2 U1287 ( .A(n1294), .Y(n1295) );
  INVX2 U1288 ( .A(n1298), .Y(n1299) );
  INVX2 U1289 ( .A(n28), .Y(n1287) );
  NAND2X1 U1290 ( .A(n896), .B(n28), .Y(n1251) );
  INVX2 U1291 ( .A(n1182), .Y(n1350) );
  INVX2 U1292 ( .A(n1338), .Y(n1337) );
  AND2X2 U1293 ( .A(n572), .B(n725), .Y(n1252) );
  AND2X2 U1294 ( .A(n917), .B(n900), .Y(n1253) );
  XOR2X1 U1295 ( .A(n1356), .B(a[29]), .Y(n46) );
  INVX2 U1296 ( .A(n890), .Y(n1306) );
  XNOR2X1 U1297 ( .A(n1177), .B(a[19]), .Y(n1254) );
  AND2X2 U1298 ( .A(n40), .B(n894), .Y(n1255) );
  AND2X2 U1299 ( .A(n1081), .B(n899), .Y(n1256) );
  INVX2 U1300 ( .A(n1254), .Y(n1278) );
  INVX1 U1301 ( .A(n189), .Y(n286) );
  INVX1 U1302 ( .A(n128), .Y(n126) );
  INVX1 U1303 ( .A(n213), .Y(n212) );
  INVX1 U1304 ( .A(n1209), .Y(n290) );
  INVX1 U1305 ( .A(n199), .Y(n201) );
  AOI21X1 U1306 ( .A(n172), .B(n159), .C(n160), .Y(n1261) );
  XOR2X1 U1307 ( .A(n658), .B(n642), .Y(n1262) );
  NAND2X1 U1308 ( .A(n658), .B(n642), .Y(n1263) );
  NAND2X1 U1309 ( .A(n658), .B(n610), .Y(n1264) );
  NAND2X1 U1310 ( .A(n642), .B(n610), .Y(n1265) );
  NAND3X1 U1311 ( .A(n1263), .B(n1264), .C(n1265), .Y(n381) );
  XOR2X1 U1312 ( .A(n383), .B(n370), .Y(n1266) );
  XOR2X1 U1313 ( .A(n1266), .B(n381), .Y(n366) );
  NAND2X1 U1314 ( .A(n383), .B(n370), .Y(n1267) );
  NAND2X1 U1315 ( .A(n383), .B(n381), .Y(n1268) );
  NAND2X1 U1316 ( .A(n370), .B(n381), .Y(n1269) );
  NAND3X1 U1317 ( .A(n1269), .B(n1268), .C(n1267), .Y(n365) );
  NOR2X1 U1318 ( .A(n1284), .B(n810), .Y(n1270) );
  NOR2X1 U1319 ( .A(n811), .B(n1286), .Y(n1271) );
  OR2X2 U1320 ( .A(n1270), .B(n1271), .Y(n658) );
  INVX4 U1321 ( .A(n1354), .Y(n1352) );
  AND2X2 U1322 ( .A(n896), .B(n28), .Y(n1272) );
  INVX2 U1323 ( .A(n1283), .Y(n1284) );
  INVX1 U1324 ( .A(n182), .Y(n285) );
  INVX1 U1325 ( .A(n1193), .Y(n561) );
  INVX2 U1326 ( .A(n557), .Y(n673) );
  INVX1 U1327 ( .A(n205), .Y(n288) );
  INVX1 U1328 ( .A(n200), .Y(n202) );
  XOR2X1 U1329 ( .A(n1345), .B(a[21]), .Y(n22) );
  INVX1 U1330 ( .A(n166), .Y(n283) );
  INVX1 U1331 ( .A(n161), .Y(n282) );
  INVX1 U1332 ( .A(n1158), .Y(n284) );
  INVX1 U1333 ( .A(n194), .Y(n287) );
  INVX1 U1334 ( .A(n52), .Y(n156) );
  INVX8 U1335 ( .A(n1336), .Y(n918) );
  INVX8 U1336 ( .A(a[15]), .Y(n917) );
  INVX8 U1337 ( .A(n541), .Y(n1334) );
  INVX8 U1338 ( .A(n1334), .Y(n1336) );
  INVX8 U1339 ( .A(n1343), .Y(n1342) );
  INVX2 U1340 ( .A(n101), .Y(n99) );
  INVX2 U1341 ( .A(n94), .Y(n92) );
  INVX2 U1342 ( .A(n79), .Y(n77) );
  INVX2 U1343 ( .A(n1321), .Y(n732) );
  INVX2 U1344 ( .A(n1323), .Y(n731) );
  INVX2 U1345 ( .A(n1325), .Y(n730) );
  OAI22X1 U1346 ( .A(n1193), .B(n1178), .C(n1277), .D(n1177), .Y(n560) );
  INVX2 U1347 ( .A(n1278), .Y(n558) );
  OAI22X1 U1348 ( .A(n1278), .B(n1142), .C(n1142), .D(n1128), .Y(n557) );
  INVX2 U1349 ( .A(n1284), .Y(n555) );
  OAI22X1 U1350 ( .A(n1284), .B(n1183), .C(n1286), .D(n1183), .Y(n554) );
  OAI22X1 U1351 ( .A(n1288), .B(n1273), .C(n1176), .D(n1273), .Y(n551) );
  OAI22X1 U1352 ( .A(n1075), .B(n1354), .C(n1293), .D(n1354), .Y(n548) );
  OAI22X1 U1353 ( .A(n1295), .B(n1356), .C(n1274), .D(n1356), .Y(n545) );
  OAI22X1 U1354 ( .A(n1299), .B(n918), .C(n1301), .D(n918), .Y(n542) );
  INVX2 U1355 ( .A(n385), .Y(n386) );
  INVX2 U1356 ( .A(n359), .Y(n360) );
  INVX2 U1357 ( .A(n337), .Y(n338) );
  INVX2 U1358 ( .A(n319), .Y(n320) );
  INVX2 U1359 ( .A(n305), .Y(n306) );
  INVX2 U1360 ( .A(n295), .Y(n296) );
  INVX2 U1361 ( .A(n130), .Y(n279) );
  INVX2 U1362 ( .A(n93), .Y(n91) );
  INVX2 U1363 ( .A(n211), .Y(n209) );
  INVX2 U1364 ( .A(n183), .Y(n181) );
  INVX2 U1365 ( .A(n172), .Y(n174) );
  INVX2 U1366 ( .A(n149), .Y(n151) );
  INVX2 U1367 ( .A(n144), .Y(n142) );
  INVX2 U1368 ( .A(n129), .Y(n127) );
  INVX2 U1369 ( .A(n122), .Y(n120) );
  INVX2 U1370 ( .A(n111), .Y(n109) );
  INVX2 U1371 ( .A(n105), .Y(n103) );
  INVX2 U1372 ( .A(n104), .Y(n102) );
endmodule


module alu ( src1_data, src2_data, alu_op, result, overflow );
  input [16:0] src1_data;
  input [16:0] src2_data;
  input [1:0] alu_op;
  output [16:0] result;
  output overflow;
  wire   N26, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15,
         n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n29, n30, n31,
         n32, n33, n34, n35, n36, n37, n38, n39, n40, n41, n42, n43, n44, n45,
         n46, n47, n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59,
         n60, n61, n62, n63, n64, n65, n66, n67, n68;
  wire   [46:30] full_mult;
  wire   [17:0] large_sum;
  wire   [17:0] large_dif;
  wire   SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, 
        SYNOPSYS_UNCONNECTED__16, SYNOPSYS_UNCONNECTED__17, 
        SYNOPSYS_UNCONNECTED__18, SYNOPSYS_UNCONNECTED__19, 
        SYNOPSYS_UNCONNECTED__20, SYNOPSYS_UNCONNECTED__21, 
        SYNOPSYS_UNCONNECTED__22, SYNOPSYS_UNCONNECTED__23, 
        SYNOPSYS_UNCONNECTED__24, SYNOPSYS_UNCONNECTED__25, 
        SYNOPSYS_UNCONNECTED__26, SYNOPSYS_UNCONNECTED__27, 
        SYNOPSYS_UNCONNECTED__28, SYNOPSYS_UNCONNECTED__29;

  alu_DW01_add_2 add_41 ( .A({src1_data[16], src1_data[16], n24, src1_data[14], 
        n20, src1_data[12], n25, n13, n14, src1_data[8], n4, n15, n16, n10, 
        n18, n11, src1_data[1:0]}), .B({src2_data[16], src2_data[16], n9, n1, 
        src2_data[13:5], n6, src2_data[3:0]}), .CI(1'b0), .SUM(large_sum) );
  alu_DW01_sub_2 sub_44 ( .A({src1_data[16], src1_data[16], n24, src1_data[14], 
        n20, src1_data[12], n25, n13, n14, src1_data[8], n4, n15, n16, n10, 
        n18, n11, src1_data[1:0]}), .B({src2_data[16], src2_data[16:5], n6, 
        src2_data[3:0]}), .CI(1'b0), .DIFF(large_dif) );
  alu_DW_mult_uns_2 mult_35 ( .a({src1_data[15:0], 1'b0, 1'b0, 1'b0, 1'b0, 
        1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0, 1'b0}), 
        .b(src2_data[15:0]), .product({N26, full_mult[45:30], 
        SYNOPSYS_UNCONNECTED__0, SYNOPSYS_UNCONNECTED__1, 
        SYNOPSYS_UNCONNECTED__2, SYNOPSYS_UNCONNECTED__3, 
        SYNOPSYS_UNCONNECTED__4, SYNOPSYS_UNCONNECTED__5, 
        SYNOPSYS_UNCONNECTED__6, SYNOPSYS_UNCONNECTED__7, 
        SYNOPSYS_UNCONNECTED__8, SYNOPSYS_UNCONNECTED__9, 
        SYNOPSYS_UNCONNECTED__10, SYNOPSYS_UNCONNECTED__11, 
        SYNOPSYS_UNCONNECTED__12, SYNOPSYS_UNCONNECTED__13, 
        SYNOPSYS_UNCONNECTED__14, SYNOPSYS_UNCONNECTED__15, 
        SYNOPSYS_UNCONNECTED__16, SYNOPSYS_UNCONNECTED__17, 
        SYNOPSYS_UNCONNECTED__18, SYNOPSYS_UNCONNECTED__19, 
        SYNOPSYS_UNCONNECTED__20, SYNOPSYS_UNCONNECTED__21, 
        SYNOPSYS_UNCONNECTED__22, SYNOPSYS_UNCONNECTED__23, 
        SYNOPSYS_UNCONNECTED__24, SYNOPSYS_UNCONNECTED__25, 
        SYNOPSYS_UNCONNECTED__26, SYNOPSYS_UNCONNECTED__27, 
        SYNOPSYS_UNCONNECTED__28, SYNOPSYS_UNCONNECTED__29}) );
  BUFX2 U3 ( .A(src1_data[15]), .Y(n24) );
  INVX2 U4 ( .A(large_dif[17]), .Y(n17) );
  BUFX2 U6 ( .A(src2_data[14]), .Y(n1) );
  XNOR2X1 U7 ( .A(n67), .B(large_sum[17]), .Y(n2) );
  INVX1 U9 ( .A(src1_data[7]), .Y(n3) );
  INVX2 U10 ( .A(n3), .Y(n4) );
  INVX1 U11 ( .A(src2_data[4]), .Y(n5) );
  INVX2 U12 ( .A(n5), .Y(n6) );
  INVX1 U13 ( .A(src1_data[5]), .Y(n7) );
  INVX2 U14 ( .A(n7), .Y(n8) );
  BUFX2 U15 ( .A(src2_data[15]), .Y(n9) );
  BUFX2 U16 ( .A(src1_data[4]), .Y(n10) );
  BUFX2 U17 ( .A(src1_data[2]), .Y(n11) );
  NAND2X1 U18 ( .A(n2), .B(n63), .Y(n12) );
  NAND2X1 U19 ( .A(n12), .B(n30), .Y(overflow) );
  BUFX2 U20 ( .A(src1_data[10]), .Y(n13) );
  BUFX2 U21 ( .A(src1_data[9]), .Y(n14) );
  BUFX2 U22 ( .A(src1_data[6]), .Y(n15) );
  BUFX2 U23 ( .A(n8), .Y(n16) );
  XNOR2X1 U24 ( .A(n17), .B(large_dif[16]), .Y(n29) );
  BUFX2 U25 ( .A(src1_data[3]), .Y(n18) );
  INVX1 U26 ( .A(src1_data[13]), .Y(n19) );
  INVX2 U27 ( .A(n19), .Y(n20) );
  INVX2 U28 ( .A(n68), .Y(n63) );
  AND2X2 U29 ( .A(n32), .B(n31), .Y(n21) );
  AND2X2 U30 ( .A(alu_op[1]), .B(n31), .Y(n22) );
  AND2X2 U31 ( .A(alu_op[0]), .B(alu_op[1]), .Y(n23) );
  INVX1 U32 ( .A(src1_data[11]), .Y(n26) );
  INVX2 U33 ( .A(n26), .Y(n25) );
  INVX2 U34 ( .A(large_sum[16]), .Y(n67) );
  INVX2 U35 ( .A(alu_op[1]), .Y(n32) );
  NAND2X1 U36 ( .A(alu_op[0]), .B(n32), .Y(n68) );
  INVX2 U37 ( .A(alu_op[0]), .Y(n31) );
  AOI22X1 U38 ( .A(N26), .B(n23), .C(n22), .D(n29), .Y(n30) );
  AOI22X1 U39 ( .A(src1_data[0]), .B(n21), .C(full_mult[30]), .D(n23), .Y(n34)
         );
  AOI22X1 U40 ( .A(large_dif[0]), .B(n22), .C(large_sum[0]), .D(n63), .Y(n33)
         );
  NAND2X1 U41 ( .A(n34), .B(n33), .Y(result[0]) );
  AOI22X1 U42 ( .A(src1_data[1]), .B(n21), .C(full_mult[31]), .D(n23), .Y(n36)
         );
  AOI22X1 U43 ( .A(large_dif[1]), .B(n22), .C(large_sum[1]), .D(n63), .Y(n35)
         );
  NAND2X1 U44 ( .A(n36), .B(n35), .Y(result[1]) );
  AOI22X1 U45 ( .A(n11), .B(n21), .C(full_mult[32]), .D(n23), .Y(n38) );
  AOI22X1 U46 ( .A(large_dif[2]), .B(n22), .C(large_sum[2]), .D(n63), .Y(n37)
         );
  NAND2X1 U47 ( .A(n38), .B(n37), .Y(result[2]) );
  AOI22X1 U48 ( .A(n18), .B(n21), .C(full_mult[33]), .D(n23), .Y(n40) );
  AOI22X1 U49 ( .A(large_dif[3]), .B(n22), .C(large_sum[3]), .D(n63), .Y(n39)
         );
  NAND2X1 U50 ( .A(n40), .B(n39), .Y(result[3]) );
  AOI22X1 U51 ( .A(n10), .B(n21), .C(full_mult[34]), .D(n23), .Y(n42) );
  AOI22X1 U52 ( .A(large_dif[4]), .B(n22), .C(large_sum[4]), .D(n63), .Y(n41)
         );
  NAND2X1 U53 ( .A(n42), .B(n41), .Y(result[4]) );
  AOI22X1 U54 ( .A(n16), .B(n21), .C(full_mult[35]), .D(n23), .Y(n44) );
  AOI22X1 U55 ( .A(large_dif[5]), .B(n22), .C(large_sum[5]), .D(n63), .Y(n43)
         );
  NAND2X1 U56 ( .A(n44), .B(n43), .Y(result[5]) );
  AOI22X1 U57 ( .A(n15), .B(n21), .C(full_mult[36]), .D(n23), .Y(n46) );
  AOI22X1 U58 ( .A(large_dif[6]), .B(n22), .C(large_sum[6]), .D(n63), .Y(n45)
         );
  NAND2X1 U59 ( .A(n45), .B(n46), .Y(result[6]) );
  AOI22X1 U60 ( .A(n4), .B(n21), .C(full_mult[37]), .D(n23), .Y(n48) );
  AOI22X1 U61 ( .A(large_dif[7]), .B(n22), .C(large_sum[7]), .D(n63), .Y(n47)
         );
  NAND2X1 U62 ( .A(n47), .B(n48), .Y(result[7]) );
  AOI22X1 U63 ( .A(src1_data[8]), .B(n21), .C(full_mult[38]), .D(n23), .Y(n50)
         );
  AOI22X1 U64 ( .A(large_dif[8]), .B(n22), .C(large_sum[8]), .D(n63), .Y(n49)
         );
  NAND2X1 U65 ( .A(n49), .B(n50), .Y(result[8]) );
  AOI22X1 U66 ( .A(n14), .B(n21), .C(full_mult[39]), .D(n23), .Y(n52) );
  AOI22X1 U67 ( .A(large_dif[9]), .B(n22), .C(large_sum[9]), .D(n63), .Y(n51)
         );
  NAND2X1 U68 ( .A(n52), .B(n51), .Y(result[9]) );
  AOI22X1 U69 ( .A(n13), .B(n21), .C(full_mult[40]), .D(n23), .Y(n54) );
  AOI22X1 U70 ( .A(large_dif[10]), .B(n22), .C(large_sum[10]), .D(n63), .Y(n53) );
  NAND2X1 U71 ( .A(n53), .B(n54), .Y(result[10]) );
  AOI22X1 U72 ( .A(n25), .B(n21), .C(full_mult[41]), .D(n23), .Y(n56) );
  AOI22X1 U73 ( .A(large_dif[11]), .B(n22), .C(large_sum[11]), .D(n63), .Y(n55) );
  NAND2X1 U74 ( .A(n55), .B(n56), .Y(result[11]) );
  AOI22X1 U75 ( .A(src1_data[12]), .B(n21), .C(full_mult[42]), .D(n23), .Y(n58) );
  AOI22X1 U76 ( .A(large_dif[12]), .B(n22), .C(large_sum[12]), .D(n63), .Y(n57) );
  NAND2X1 U77 ( .A(n57), .B(n58), .Y(result[12]) );
  AOI22X1 U78 ( .A(n20), .B(n21), .C(full_mult[43]), .D(n23), .Y(n60) );
  AOI22X1 U79 ( .A(large_dif[13]), .B(n22), .C(large_sum[13]), .D(n63), .Y(n59) );
  NAND2X1 U80 ( .A(n60), .B(n59), .Y(result[13]) );
  AOI22X1 U81 ( .A(src1_data[14]), .B(n21), .C(full_mult[44]), .D(n23), .Y(n62) );
  AOI22X1 U82 ( .A(large_dif[14]), .B(n22), .C(large_sum[14]), .D(n63), .Y(n61) );
  NAND2X1 U83 ( .A(n61), .B(n62), .Y(result[14]) );
  AOI22X1 U84 ( .A(n24), .B(n21), .C(full_mult[45]), .D(n23), .Y(n65) );
  AOI22X1 U85 ( .A(large_dif[15]), .B(n22), .C(large_sum[15]), .D(n63), .Y(n64) );
  NAND2X1 U86 ( .A(n64), .B(n65), .Y(result[15]) );
  AOI22X1 U87 ( .A(src1_data[16]), .B(n21), .C(large_dif[16]), .D(n22), .Y(n66) );
  OAI21X1 U88 ( .A(n68), .B(n67), .C(n66), .Y(result[16]) );
endmodule


module flex_sreg_NUM_BITS17_15 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n10), .Y(n48) );
  INVX1 U3 ( .A(n17), .Y(n34) );
  INVX1 U4 ( .A(n7), .Y(n53) );
  INVX1 U5 ( .A(n9), .Y(n50) );
  INVX2 U6 ( .A(n1), .Y(n2) );
  INVX2 U7 ( .A(write_enable), .Y(n1) );
  INVX2 U8 ( .A(n4), .Y(n3) );
  INVX2 U9 ( .A(n_reset), .Y(n4) );
  INVX1 U10 ( .A(n13), .Y(n42) );
  INVX1 U11 ( .A(n11), .Y(n46) );
  INVX1 U12 ( .A(n14), .Y(n40) );
  INVX1 U13 ( .A(n15), .Y(n38) );
  INVX1 U14 ( .A(n20), .Y(n30) );
  INVX1 U15 ( .A(n12), .Y(n44) );
  INVX1 U16 ( .A(n16), .Y(n36) );
  INVX1 U17 ( .A(n18), .Y(n32) );
  INVX1 U18 ( .A(n22), .Y(n28) );
  MUX2X1 U19 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U20 ( .A(n5), .Y(n55) );
  MUX2X1 U21 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U22 ( .A(n6), .Y(n54) );
  MUX2X1 U23 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  MUX2X1 U24 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U25 ( .A(n8), .Y(n52) );
  MUX2X1 U26 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  MUX2X1 U27 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  MUX2X1 U28 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U29 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U30 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U31 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U32 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U33 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U34 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U35 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U36 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_14 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n17), .Y(n34) );
  INVX1 U3 ( .A(n18), .Y(n32) );
  INVX1 U4 ( .A(n16), .Y(n36) );
  INVX1 U5 ( .A(n15), .Y(n38) );
  INVX2 U6 ( .A(n1), .Y(n2) );
  INVX2 U7 ( .A(write_enable), .Y(n1) );
  INVX2 U8 ( .A(n4), .Y(n3) );
  INVX2 U9 ( .A(n_reset), .Y(n4) );
  INVX1 U10 ( .A(n11), .Y(n46) );
  INVX1 U11 ( .A(n14), .Y(n40) );
  INVX1 U12 ( .A(n13), .Y(n42) );
  INVX1 U13 ( .A(n12), .Y(n44) );
  INVX1 U14 ( .A(n22), .Y(n28) );
  INVX1 U15 ( .A(n20), .Y(n30) );
  MUX2X1 U16 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U17 ( .A(n5), .Y(n55) );
  MUX2X1 U18 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U19 ( .A(n6), .Y(n54) );
  MUX2X1 U20 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U21 ( .A(n7), .Y(n53) );
  MUX2X1 U22 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U23 ( .A(n8), .Y(n52) );
  MUX2X1 U24 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U25 ( .A(n9), .Y(n50) );
  MUX2X1 U26 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U27 ( .A(n10), .Y(n48) );
  MUX2X1 U28 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U29 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U30 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U31 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U32 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U33 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U34 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U35 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U36 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_13 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n16), .Y(n36) );
  INVX1 U3 ( .A(n20), .Y(n30) );
  INVX1 U4 ( .A(n18), .Y(n32) );
  INVX1 U5 ( .A(n15), .Y(n38) );
  INVX2 U6 ( .A(n1), .Y(n2) );
  INVX2 U7 ( .A(write_enable), .Y(n1) );
  INVX2 U8 ( .A(n4), .Y(n3) );
  INVX2 U9 ( .A(n_reset), .Y(n4) );
  INVX1 U10 ( .A(n11), .Y(n46) );
  INVX1 U11 ( .A(n14), .Y(n40) );
  INVX1 U12 ( .A(n13), .Y(n42) );
  INVX1 U13 ( .A(n12), .Y(n44) );
  INVX1 U14 ( .A(n22), .Y(n28) );
  MUX2X1 U15 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U16 ( .A(n5), .Y(n55) );
  MUX2X1 U17 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U18 ( .A(n6), .Y(n54) );
  MUX2X1 U19 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U20 ( .A(n7), .Y(n53) );
  MUX2X1 U21 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U22 ( .A(n8), .Y(n52) );
  MUX2X1 U23 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U24 ( .A(n9), .Y(n50) );
  MUX2X1 U25 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U26 ( .A(n10), .Y(n48) );
  MUX2X1 U27 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U28 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U29 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U30 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U31 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U32 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U33 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  INVX2 U34 ( .A(n17), .Y(n34) );
  MUX2X1 U35 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U36 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_12 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX1 U3 ( .A(n15), .Y(n38) );
  INVX1 U4 ( .A(n18), .Y(n32) );
  INVX2 U5 ( .A(n1), .Y(n2) );
  INVX2 U6 ( .A(write_enable), .Y(n1) );
  INVX2 U7 ( .A(n4), .Y(n3) );
  INVX2 U8 ( .A(n_reset), .Y(n4) );
  INVX1 U9 ( .A(n11), .Y(n46) );
  INVX1 U10 ( .A(n14), .Y(n40) );
  INVX1 U11 ( .A(n13), .Y(n42) );
  INVX1 U12 ( .A(n12), .Y(n44) );
  MUX2X1 U13 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U14 ( .A(n5), .Y(n55) );
  MUX2X1 U15 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U16 ( .A(n6), .Y(n54) );
  MUX2X1 U17 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U18 ( .A(n7), .Y(n53) );
  MUX2X1 U19 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U20 ( .A(n8), .Y(n52) );
  MUX2X1 U21 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U22 ( .A(n9), .Y(n50) );
  MUX2X1 U23 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U24 ( .A(n10), .Y(n48) );
  MUX2X1 U25 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U26 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U27 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U28 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U29 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U30 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  INVX2 U31 ( .A(n16), .Y(n36) );
  MUX2X1 U32 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  INVX2 U33 ( .A(n17), .Y(n34) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_11 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX1 U3 ( .A(n15), .Y(n38) );
  INVX1 U4 ( .A(n18), .Y(n32) );
  INVX2 U5 ( .A(n1), .Y(n2) );
  INVX2 U6 ( .A(write_enable), .Y(n1) );
  INVX2 U7 ( .A(n4), .Y(n3) );
  INVX2 U8 ( .A(n_reset), .Y(n4) );
  INVX1 U9 ( .A(n11), .Y(n46) );
  INVX1 U10 ( .A(n14), .Y(n40) );
  INVX1 U11 ( .A(n13), .Y(n42) );
  INVX1 U12 ( .A(n12), .Y(n44) );
  MUX2X1 U13 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U14 ( .A(n5), .Y(n55) );
  MUX2X1 U15 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U16 ( .A(n6), .Y(n54) );
  MUX2X1 U17 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U18 ( .A(n7), .Y(n53) );
  MUX2X1 U19 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U20 ( .A(n8), .Y(n52) );
  MUX2X1 U21 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U22 ( .A(n9), .Y(n50) );
  MUX2X1 U23 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U24 ( .A(n10), .Y(n48) );
  MUX2X1 U25 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U26 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U27 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U28 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U29 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U30 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  INVX2 U31 ( .A(n16), .Y(n36) );
  MUX2X1 U32 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  INVX2 U33 ( .A(n17), .Y(n34) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_10 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX1 U3 ( .A(n15), .Y(n38) );
  INVX1 U4 ( .A(n18), .Y(n32) );
  INVX2 U5 ( .A(n1), .Y(n2) );
  INVX2 U6 ( .A(write_enable), .Y(n1) );
  INVX2 U7 ( .A(n4), .Y(n3) );
  INVX2 U8 ( .A(n_reset), .Y(n4) );
  INVX1 U9 ( .A(n11), .Y(n46) );
  INVX1 U10 ( .A(n14), .Y(n40) );
  INVX1 U11 ( .A(n13), .Y(n42) );
  INVX1 U12 ( .A(n12), .Y(n44) );
  MUX2X1 U13 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U14 ( .A(n5), .Y(n55) );
  MUX2X1 U15 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U16 ( .A(n6), .Y(n54) );
  MUX2X1 U17 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U18 ( .A(n7), .Y(n53) );
  MUX2X1 U19 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U20 ( .A(n8), .Y(n52) );
  MUX2X1 U21 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U22 ( .A(n9), .Y(n50) );
  MUX2X1 U23 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U24 ( .A(n10), .Y(n48) );
  MUX2X1 U25 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U26 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U27 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U28 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U29 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U30 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  INVX2 U31 ( .A(n16), .Y(n36) );
  MUX2X1 U32 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  INVX2 U33 ( .A(n17), .Y(n34) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_9 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n18), .Y(n32) );
  INVX1 U3 ( .A(n15), .Y(n38) );
  INVX2 U4 ( .A(n1), .Y(n2) );
  INVX2 U5 ( .A(write_enable), .Y(n1) );
  INVX2 U6 ( .A(n4), .Y(n3) );
  INVX2 U7 ( .A(n_reset), .Y(n4) );
  INVX1 U8 ( .A(n11), .Y(n46) );
  INVX1 U9 ( .A(n14), .Y(n40) );
  INVX1 U10 ( .A(n13), .Y(n42) );
  INVX1 U11 ( .A(n12), .Y(n44) );
  INVX1 U12 ( .A(n22), .Y(n28) );
  MUX2X1 U13 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U14 ( .A(n5), .Y(n55) );
  MUX2X1 U15 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U16 ( .A(n6), .Y(n54) );
  MUX2X1 U17 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U18 ( .A(n7), .Y(n53) );
  MUX2X1 U19 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U20 ( .A(n8), .Y(n52) );
  MUX2X1 U21 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U22 ( .A(n9), .Y(n50) );
  MUX2X1 U23 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U24 ( .A(n10), .Y(n48) );
  MUX2X1 U25 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U26 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U27 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U28 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U29 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U30 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  INVX2 U31 ( .A(n16), .Y(n36) );
  MUX2X1 U32 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  INVX2 U33 ( .A(n17), .Y(n34) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_8 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX1 U3 ( .A(n15), .Y(n38) );
  INVX1 U4 ( .A(n18), .Y(n32) );
  INVX2 U5 ( .A(n1), .Y(n2) );
  INVX2 U6 ( .A(write_enable), .Y(n1) );
  INVX2 U7 ( .A(n4), .Y(n3) );
  INVX2 U8 ( .A(n_reset), .Y(n4) );
  INVX1 U9 ( .A(n11), .Y(n46) );
  INVX1 U10 ( .A(n14), .Y(n40) );
  INVX1 U11 ( .A(n13), .Y(n42) );
  INVX1 U12 ( .A(n12), .Y(n44) );
  MUX2X1 U13 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U14 ( .A(n5), .Y(n55) );
  MUX2X1 U15 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U16 ( .A(n6), .Y(n54) );
  MUX2X1 U17 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U18 ( .A(n7), .Y(n53) );
  MUX2X1 U19 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U20 ( .A(n8), .Y(n52) );
  MUX2X1 U21 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U22 ( .A(n9), .Y(n50) );
  MUX2X1 U23 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U24 ( .A(n10), .Y(n48) );
  MUX2X1 U25 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U26 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U27 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U28 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U29 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U30 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  INVX2 U31 ( .A(n16), .Y(n36) );
  MUX2X1 U32 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  INVX2 U33 ( .A(n17), .Y(n34) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_7 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX1 U3 ( .A(n15), .Y(n38) );
  INVX1 U4 ( .A(n18), .Y(n32) );
  INVX2 U5 ( .A(n1), .Y(n2) );
  INVX2 U6 ( .A(write_enable), .Y(n1) );
  INVX2 U7 ( .A(n4), .Y(n3) );
  INVX2 U8 ( .A(n_reset), .Y(n4) );
  INVX1 U9 ( .A(n11), .Y(n46) );
  INVX1 U10 ( .A(n14), .Y(n40) );
  INVX1 U11 ( .A(n13), .Y(n42) );
  INVX1 U12 ( .A(n12), .Y(n44) );
  MUX2X1 U13 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U14 ( .A(n5), .Y(n55) );
  MUX2X1 U15 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U16 ( .A(n6), .Y(n54) );
  MUX2X1 U17 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U18 ( .A(n7), .Y(n53) );
  MUX2X1 U19 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U20 ( .A(n8), .Y(n52) );
  MUX2X1 U21 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U22 ( .A(n9), .Y(n50) );
  MUX2X1 U23 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U24 ( .A(n10), .Y(n48) );
  MUX2X1 U25 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U26 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U27 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U28 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U29 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U30 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  INVX2 U31 ( .A(n16), .Y(n36) );
  MUX2X1 U32 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  INVX2 U33 ( .A(n17), .Y(n34) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_6 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n17), .Y(n34) );
  INVX1 U3 ( .A(n18), .Y(n32) );
  INVX1 U4 ( .A(n16), .Y(n36) );
  INVX1 U5 ( .A(n15), .Y(n38) );
  INVX1 U6 ( .A(n20), .Y(n30) );
  INVX2 U7 ( .A(n1), .Y(n2) );
  INVX2 U8 ( .A(write_enable), .Y(n1) );
  INVX2 U9 ( .A(n4), .Y(n3) );
  INVX2 U10 ( .A(n_reset), .Y(n4) );
  INVX1 U11 ( .A(n11), .Y(n46) );
  INVX1 U12 ( .A(n14), .Y(n40) );
  INVX1 U13 ( .A(n13), .Y(n42) );
  INVX1 U14 ( .A(n12), .Y(n44) );
  INVX1 U15 ( .A(n22), .Y(n28) );
  MUX2X1 U16 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U17 ( .A(n5), .Y(n55) );
  MUX2X1 U18 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U19 ( .A(n6), .Y(n54) );
  MUX2X1 U20 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U21 ( .A(n7), .Y(n53) );
  MUX2X1 U22 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U23 ( .A(n8), .Y(n52) );
  MUX2X1 U24 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U25 ( .A(n9), .Y(n50) );
  MUX2X1 U26 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U27 ( .A(n10), .Y(n48) );
  MUX2X1 U28 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U29 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U30 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U31 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U32 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U33 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  MUX2X1 U34 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  MUX2X1 U35 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U36 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_5 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n15), .Y(n38) );
  INVX1 U3 ( .A(n18), .Y(n32) );
  INVX2 U4 ( .A(n1), .Y(n2) );
  INVX2 U5 ( .A(write_enable), .Y(n1) );
  INVX2 U6 ( .A(n4), .Y(n3) );
  INVX2 U7 ( .A(n_reset), .Y(n4) );
  INVX1 U8 ( .A(n11), .Y(n46) );
  INVX1 U9 ( .A(n14), .Y(n40) );
  INVX1 U10 ( .A(n13), .Y(n42) );
  INVX1 U11 ( .A(n12), .Y(n44) );
  INVX1 U12 ( .A(n22), .Y(n28) );
  MUX2X1 U13 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U14 ( .A(n5), .Y(n55) );
  MUX2X1 U15 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U16 ( .A(n6), .Y(n54) );
  MUX2X1 U17 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U18 ( .A(n7), .Y(n53) );
  MUX2X1 U19 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U20 ( .A(n8), .Y(n52) );
  MUX2X1 U21 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U22 ( .A(n9), .Y(n50) );
  MUX2X1 U23 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U24 ( .A(n10), .Y(n48) );
  MUX2X1 U25 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U26 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U27 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U28 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U29 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U30 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  INVX2 U31 ( .A(n16), .Y(n36) );
  MUX2X1 U32 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  INVX2 U33 ( .A(n17), .Y(n34) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_4 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX1 U3 ( .A(n15), .Y(n38) );
  INVX1 U4 ( .A(n18), .Y(n32) );
  INVX2 U5 ( .A(n1), .Y(n2) );
  INVX2 U6 ( .A(write_enable), .Y(n1) );
  INVX2 U7 ( .A(n4), .Y(n3) );
  INVX2 U8 ( .A(n_reset), .Y(n4) );
  INVX1 U9 ( .A(n11), .Y(n46) );
  INVX1 U10 ( .A(n14), .Y(n40) );
  INVX1 U11 ( .A(n13), .Y(n42) );
  INVX1 U12 ( .A(n12), .Y(n44) );
  MUX2X1 U13 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U14 ( .A(n5), .Y(n55) );
  MUX2X1 U15 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U16 ( .A(n6), .Y(n54) );
  MUX2X1 U17 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U18 ( .A(n7), .Y(n53) );
  MUX2X1 U19 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U20 ( .A(n8), .Y(n52) );
  MUX2X1 U21 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U22 ( .A(n9), .Y(n50) );
  MUX2X1 U23 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U24 ( .A(n10), .Y(n48) );
  MUX2X1 U25 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U26 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U27 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U28 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U29 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U30 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  INVX2 U31 ( .A(n16), .Y(n36) );
  MUX2X1 U32 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  INVX2 U33 ( .A(n17), .Y(n34) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_3 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX1 U3 ( .A(n15), .Y(n38) );
  INVX1 U4 ( .A(n18), .Y(n32) );
  INVX2 U5 ( .A(n1), .Y(n2) );
  INVX2 U6 ( .A(write_enable), .Y(n1) );
  INVX2 U7 ( .A(n4), .Y(n3) );
  INVX2 U8 ( .A(n_reset), .Y(n4) );
  INVX1 U9 ( .A(n11), .Y(n46) );
  INVX1 U10 ( .A(n14), .Y(n40) );
  INVX1 U11 ( .A(n13), .Y(n42) );
  INVX1 U12 ( .A(n12), .Y(n44) );
  MUX2X1 U13 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U14 ( .A(n5), .Y(n55) );
  MUX2X1 U15 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U16 ( .A(n6), .Y(n54) );
  MUX2X1 U17 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U18 ( .A(n7), .Y(n53) );
  MUX2X1 U19 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U20 ( .A(n8), .Y(n52) );
  MUX2X1 U21 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U22 ( .A(n9), .Y(n50) );
  MUX2X1 U23 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U24 ( .A(n10), .Y(n48) );
  MUX2X1 U25 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U26 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U27 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U28 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U29 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U30 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  INVX2 U31 ( .A(n16), .Y(n36) );
  MUX2X1 U32 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  INVX2 U33 ( .A(n17), .Y(n34) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_2 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n22), .Y(n28) );
  INVX1 U3 ( .A(n15), .Y(n38) );
  INVX1 U4 ( .A(n18), .Y(n32) );
  INVX2 U5 ( .A(n1), .Y(n2) );
  INVX2 U6 ( .A(write_enable), .Y(n1) );
  INVX2 U7 ( .A(n4), .Y(n3) );
  INVX2 U8 ( .A(n_reset), .Y(n4) );
  INVX1 U9 ( .A(n11), .Y(n46) );
  INVX1 U10 ( .A(n14), .Y(n40) );
  INVX1 U11 ( .A(n13), .Y(n42) );
  INVX1 U12 ( .A(n12), .Y(n44) );
  MUX2X1 U13 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U14 ( .A(n5), .Y(n55) );
  MUX2X1 U15 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U16 ( .A(n6), .Y(n54) );
  MUX2X1 U17 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U18 ( .A(n7), .Y(n53) );
  MUX2X1 U19 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U20 ( .A(n8), .Y(n52) );
  MUX2X1 U21 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U22 ( .A(n9), .Y(n50) );
  MUX2X1 U23 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U24 ( .A(n10), .Y(n48) );
  MUX2X1 U25 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U26 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U27 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U28 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U29 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U30 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  INVX2 U31 ( .A(n16), .Y(n36) );
  MUX2X1 U32 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  INVX2 U33 ( .A(n17), .Y(n34) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_1 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n15), .Y(n38) );
  INVX1 U3 ( .A(n18), .Y(n32) );
  INVX2 U4 ( .A(n1), .Y(n2) );
  INVX2 U5 ( .A(write_enable), .Y(n1) );
  INVX2 U6 ( .A(n4), .Y(n3) );
  INVX2 U7 ( .A(n_reset), .Y(n4) );
  INVX1 U8 ( .A(n11), .Y(n46) );
  INVX1 U9 ( .A(n14), .Y(n40) );
  INVX1 U10 ( .A(n13), .Y(n42) );
  INVX1 U11 ( .A(n12), .Y(n44) );
  INVX1 U12 ( .A(n22), .Y(n28) );
  MUX2X1 U13 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U14 ( .A(n5), .Y(n55) );
  MUX2X1 U15 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U16 ( .A(n6), .Y(n54) );
  MUX2X1 U17 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U18 ( .A(n7), .Y(n53) );
  MUX2X1 U19 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U20 ( .A(n8), .Y(n52) );
  MUX2X1 U21 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U22 ( .A(n9), .Y(n50) );
  MUX2X1 U23 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U24 ( .A(n10), .Y(n48) );
  MUX2X1 U25 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U26 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U27 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U28 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U29 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U30 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  INVX2 U31 ( .A(n16), .Y(n36) );
  MUX2X1 U32 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  INVX2 U33 ( .A(n17), .Y(n34) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module flex_sreg_NUM_BITS17_0 ( clk, n_reset, write_enable, new_value, 
        current_value );
  input [16:0] new_value;
  output [16:0] current_value;
  input clk, n_reset, write_enable;
  wire   n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14, n15, n16,
         n17, n18, n20, n22, n24, n26, n28, n30, n32, n34, n36, n38, n40, n42,
         n44, n46, n48, n50, n52, n53, n54, n55;

  DFFSR \value_reg[16]  ( .D(n26), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[16]) );
  DFFSR \value_reg[15]  ( .D(n28), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[15]) );
  DFFSR \value_reg[14]  ( .D(n30), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[14]) );
  DFFSR \value_reg[13]  ( .D(n32), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[13]) );
  DFFSR \value_reg[12]  ( .D(n34), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[12]) );
  DFFSR \value_reg[11]  ( .D(n36), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[11]) );
  DFFSR \value_reg[10]  ( .D(n38), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[10]) );
  DFFSR \value_reg[9]  ( .D(n40), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[9]) );
  DFFSR \value_reg[8]  ( .D(n42), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[8]) );
  DFFSR \value_reg[7]  ( .D(n44), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[7]) );
  DFFSR \value_reg[6]  ( .D(n46), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[6]) );
  DFFSR \value_reg[5]  ( .D(n48), .CLK(clk), .R(n3), .S(1'b1), .Q(
        current_value[5]) );
  DFFSR \value_reg[4]  ( .D(n50), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[4]) );
  DFFSR \value_reg[3]  ( .D(n52), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[3]) );
  DFFSR \value_reg[2]  ( .D(n53), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[2]) );
  DFFSR \value_reg[1]  ( .D(n54), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[1]) );
  DFFSR \value_reg[0]  ( .D(n55), .CLK(clk), .R(n_reset), .S(1'b1), .Q(
        current_value[0]) );
  INVX1 U2 ( .A(n15), .Y(n38) );
  INVX1 U3 ( .A(n18), .Y(n32) );
  INVX2 U4 ( .A(n1), .Y(n2) );
  INVX2 U5 ( .A(write_enable), .Y(n1) );
  INVX2 U6 ( .A(n4), .Y(n3) );
  INVX2 U7 ( .A(n_reset), .Y(n4) );
  INVX1 U8 ( .A(n11), .Y(n46) );
  INVX1 U9 ( .A(n14), .Y(n40) );
  INVX1 U10 ( .A(n13), .Y(n42) );
  INVX1 U11 ( .A(n12), .Y(n44) );
  INVX1 U12 ( .A(n22), .Y(n28) );
  MUX2X1 U13 ( .B(current_value[0]), .A(new_value[0]), .S(n2), .Y(n5) );
  INVX2 U14 ( .A(n5), .Y(n55) );
  MUX2X1 U15 ( .B(current_value[1]), .A(new_value[1]), .S(n2), .Y(n6) );
  INVX2 U16 ( .A(n6), .Y(n54) );
  MUX2X1 U17 ( .B(current_value[2]), .A(new_value[2]), .S(n2), .Y(n7) );
  INVX2 U18 ( .A(n7), .Y(n53) );
  MUX2X1 U19 ( .B(current_value[3]), .A(new_value[3]), .S(n2), .Y(n8) );
  INVX2 U20 ( .A(n8), .Y(n52) );
  MUX2X1 U21 ( .B(current_value[4]), .A(new_value[4]), .S(n2), .Y(n9) );
  INVX2 U22 ( .A(n9), .Y(n50) );
  MUX2X1 U23 ( .B(current_value[5]), .A(new_value[5]), .S(write_enable), .Y(
        n10) );
  INVX2 U24 ( .A(n10), .Y(n48) );
  MUX2X1 U25 ( .B(current_value[6]), .A(new_value[6]), .S(n2), .Y(n11) );
  MUX2X1 U26 ( .B(current_value[7]), .A(new_value[7]), .S(write_enable), .Y(
        n12) );
  MUX2X1 U27 ( .B(current_value[8]), .A(new_value[8]), .S(n2), .Y(n13) );
  MUX2X1 U28 ( .B(current_value[9]), .A(new_value[9]), .S(write_enable), .Y(
        n14) );
  MUX2X1 U29 ( .B(current_value[10]), .A(new_value[10]), .S(n2), .Y(n15) );
  MUX2X1 U30 ( .B(current_value[11]), .A(new_value[11]), .S(write_enable), .Y(
        n16) );
  INVX2 U31 ( .A(n16), .Y(n36) );
  MUX2X1 U32 ( .B(current_value[12]), .A(new_value[12]), .S(n2), .Y(n17) );
  INVX2 U33 ( .A(n17), .Y(n34) );
  MUX2X1 U34 ( .B(current_value[13]), .A(new_value[13]), .S(write_enable), .Y(
        n18) );
  MUX2X1 U35 ( .B(current_value[14]), .A(new_value[14]), .S(n2), .Y(n20) );
  INVX2 U36 ( .A(n20), .Y(n30) );
  MUX2X1 U54 ( .B(current_value[15]), .A(new_value[15]), .S(write_enable), .Y(
        n22) );
  MUX2X1 U55 ( .B(current_value[16]), .A(new_value[16]), .S(n2), .Y(n24) );
  INVX2 U56 ( .A(n24), .Y(n26) );
endmodule


module register_file ( clk, n_reset, w_en, r1_sel, r2_sel, w_sel, w_data, 
        r1_data, r2_data, outreg_data );
  input [3:0] r1_sel;
  input [3:0] r2_sel;
  input [3:0] w_sel;
  input [16:0] w_data;
  output [16:0] r1_data;
  output [16:0] r2_data;
  output [16:0] outreg_data;
  input clk, n_reset, w_en;
  wire   N10, N11, N12, N13, N14, N15, N16, N17, n774, \regs_matrix[15][16] ,
         \regs_matrix[15][15] , \regs_matrix[15][14] , \regs_matrix[15][13] ,
         \regs_matrix[15][12] , \regs_matrix[15][11] , \regs_matrix[15][10] ,
         \regs_matrix[15][9] , \regs_matrix[15][8] , \regs_matrix[15][7] ,
         \regs_matrix[15][6] , \regs_matrix[15][5] , \regs_matrix[15][4] ,
         \regs_matrix[15][3] , \regs_matrix[15][2] , \regs_matrix[15][1] ,
         \regs_matrix[15][0] , \regs_matrix[14][16] , \regs_matrix[14][15] ,
         \regs_matrix[14][14] , \regs_matrix[14][13] , \regs_matrix[14][12] ,
         \regs_matrix[14][11] , \regs_matrix[14][10] , \regs_matrix[14][9] ,
         \regs_matrix[14][8] , \regs_matrix[14][7] , \regs_matrix[14][6] ,
         \regs_matrix[14][5] , \regs_matrix[14][4] , \regs_matrix[14][3] ,
         \regs_matrix[14][2] , \regs_matrix[14][1] , \regs_matrix[14][0] ,
         \regs_matrix[13][16] , \regs_matrix[13][15] , \regs_matrix[13][14] ,
         \regs_matrix[13][13] , \regs_matrix[13][12] , \regs_matrix[13][11] ,
         \regs_matrix[13][10] , \regs_matrix[13][9] , \regs_matrix[13][8] ,
         \regs_matrix[13][7] , \regs_matrix[13][6] , \regs_matrix[13][5] ,
         \regs_matrix[13][4] , \regs_matrix[13][3] , \regs_matrix[13][2] ,
         \regs_matrix[13][1] , \regs_matrix[13][0] , \regs_matrix[12][16] ,
         \regs_matrix[12][15] , \regs_matrix[12][14] , \regs_matrix[12][13] ,
         \regs_matrix[12][12] , \regs_matrix[12][11] , \regs_matrix[12][10] ,
         \regs_matrix[12][9] , \regs_matrix[12][8] , \regs_matrix[12][7] ,
         \regs_matrix[12][6] , \regs_matrix[12][5] , \regs_matrix[12][4] ,
         \regs_matrix[12][3] , \regs_matrix[12][2] , \regs_matrix[12][1] ,
         \regs_matrix[12][0] , \regs_matrix[11][16] , \regs_matrix[11][15] ,
         \regs_matrix[11][14] , \regs_matrix[11][13] , \regs_matrix[11][12] ,
         \regs_matrix[11][11] , \regs_matrix[11][10] , \regs_matrix[11][9] ,
         \regs_matrix[11][8] , \regs_matrix[11][7] , \regs_matrix[11][6] ,
         \regs_matrix[11][5] , \regs_matrix[11][4] , \regs_matrix[11][3] ,
         \regs_matrix[11][2] , \regs_matrix[11][1] , \regs_matrix[11][0] ,
         \regs_matrix[10][16] , \regs_matrix[10][15] , \regs_matrix[10][14] ,
         \regs_matrix[10][13] , \regs_matrix[10][12] , \regs_matrix[10][11] ,
         \regs_matrix[10][10] , \regs_matrix[10][9] , \regs_matrix[10][8] ,
         \regs_matrix[10][7] , \regs_matrix[10][6] , \regs_matrix[10][5] ,
         \regs_matrix[10][4] , \regs_matrix[10][3] , \regs_matrix[10][2] ,
         \regs_matrix[10][1] , \regs_matrix[10][0] , \regs_matrix[9][16] ,
         \regs_matrix[9][15] , \regs_matrix[9][14] , \regs_matrix[9][13] ,
         \regs_matrix[9][12] , \regs_matrix[9][11] , \regs_matrix[9][10] ,
         \regs_matrix[9][9] , \regs_matrix[9][8] , \regs_matrix[9][7] ,
         \regs_matrix[9][6] , \regs_matrix[9][5] , \regs_matrix[9][4] ,
         \regs_matrix[9][3] , \regs_matrix[9][2] , \regs_matrix[9][1] ,
         \regs_matrix[9][0] , \regs_matrix[8][16] , \regs_matrix[8][15] ,
         \regs_matrix[8][14] , \regs_matrix[8][13] , \regs_matrix[8][12] ,
         \regs_matrix[8][11] , \regs_matrix[8][10] , \regs_matrix[8][9] ,
         \regs_matrix[8][8] , \regs_matrix[8][7] , \regs_matrix[8][6] ,
         \regs_matrix[8][5] , \regs_matrix[8][4] , \regs_matrix[8][3] ,
         \regs_matrix[8][2] , \regs_matrix[8][1] , \regs_matrix[8][0] ,
         \regs_matrix[7][16] , \regs_matrix[7][15] , \regs_matrix[7][14] ,
         \regs_matrix[7][13] , \regs_matrix[7][12] , \regs_matrix[7][11] ,
         \regs_matrix[7][10] , \regs_matrix[7][9] , \regs_matrix[7][8] ,
         \regs_matrix[7][7] , \regs_matrix[7][6] , \regs_matrix[7][5] ,
         \regs_matrix[7][4] , \regs_matrix[7][3] , \regs_matrix[7][2] ,
         \regs_matrix[7][1] , \regs_matrix[7][0] , \regs_matrix[6][16] ,
         \regs_matrix[6][15] , \regs_matrix[6][14] , \regs_matrix[6][13] ,
         \regs_matrix[6][12] , \regs_matrix[6][11] , \regs_matrix[6][10] ,
         \regs_matrix[6][9] , \regs_matrix[6][8] , \regs_matrix[6][7] ,
         \regs_matrix[6][6] , \regs_matrix[6][5] , \regs_matrix[6][4] ,
         \regs_matrix[6][3] , \regs_matrix[6][2] , \regs_matrix[6][1] ,
         \regs_matrix[6][0] , \regs_matrix[5][16] , \regs_matrix[5][15] ,
         \regs_matrix[5][14] , \regs_matrix[5][13] , \regs_matrix[5][12] ,
         \regs_matrix[5][11] , \regs_matrix[5][10] , \regs_matrix[5][9] ,
         \regs_matrix[5][8] , \regs_matrix[5][7] , \regs_matrix[5][6] ,
         \regs_matrix[5][5] , \regs_matrix[5][4] , \regs_matrix[5][3] ,
         \regs_matrix[5][2] , \regs_matrix[5][1] , \regs_matrix[5][0] ,
         \regs_matrix[4][16] , \regs_matrix[4][15] , \regs_matrix[4][14] ,
         \regs_matrix[4][13] , \regs_matrix[4][12] , \regs_matrix[4][11] ,
         \regs_matrix[4][10] , \regs_matrix[4][9] , \regs_matrix[4][8] ,
         \regs_matrix[4][7] , \regs_matrix[4][6] , \regs_matrix[4][5] ,
         \regs_matrix[4][4] , \regs_matrix[4][3] , \regs_matrix[4][2] ,
         \regs_matrix[4][1] , \regs_matrix[4][0] , \regs_matrix[3][16] ,
         \regs_matrix[3][15] , \regs_matrix[3][14] , \regs_matrix[3][13] ,
         \regs_matrix[3][12] , \regs_matrix[3][11] , \regs_matrix[3][10] ,
         \regs_matrix[3][9] , \regs_matrix[3][8] , \regs_matrix[3][7] ,
         \regs_matrix[3][6] , \regs_matrix[3][5] , \regs_matrix[3][4] ,
         \regs_matrix[3][3] , \regs_matrix[3][2] , \regs_matrix[3][1] ,
         \regs_matrix[3][0] , \regs_matrix[2][16] , \regs_matrix[2][15] ,
         \regs_matrix[2][14] , \regs_matrix[2][13] , \regs_matrix[2][12] ,
         \regs_matrix[2][11] , \regs_matrix[2][10] , \regs_matrix[2][9] ,
         \regs_matrix[2][8] , \regs_matrix[2][7] , \regs_matrix[2][6] ,
         \regs_matrix[2][5] , \regs_matrix[2][4] , \regs_matrix[2][3] ,
         \regs_matrix[2][2] , \regs_matrix[2][1] , \regs_matrix[2][0] ,
         \regs_matrix[1][16] , \regs_matrix[1][15] , \regs_matrix[1][14] ,
         \regs_matrix[1][13] , \regs_matrix[1][12] , \regs_matrix[1][11] ,
         \regs_matrix[1][10] , \regs_matrix[1][9] , \regs_matrix[1][8] ,
         \regs_matrix[1][7] , \regs_matrix[1][6] , \regs_matrix[1][5] ,
         \regs_matrix[1][4] , \regs_matrix[1][3] , \regs_matrix[1][2] ,
         \regs_matrix[1][1] , \regs_matrix[1][0] , n5, n6, n7, n8, n9, n10,
         n11, n12, n13, n1, n2, n3, n4, n14, n15, n16, n17, n18, n19, n20, n21,
         n22, n23, n24, n25, n26, n27, n28, n29, n30, n31, n32, n33, n34, n35,
         n36, n37, n38, n39, n40, n41, n42, n43, n44, n45, n46, n47, n48, n49,
         n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61, n62, n63,
         n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75, n76, n77,
         n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89, n90, n91,
         n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102, n103, n105,
         n106, n107, n108, n109, n110, n111, n112, n113, n114, n115, n116,
         n117, n118, n119, n120, n121, n122, n123, n124, n125, n126, n127,
         n128, n129, n130, n131, n132, n133, n134, n135, n136, n137, n138,
         n139, n140, n141, n142, n143, n144, n145, n146, n147, n148, n149,
         n150, n151, n152, n153, n154, n155, n156, n157, n158, n159, n160,
         n161, n162, n163, n164, n165, n166, n167, n168, n169, n170, n171,
         n172, n173, n174, n175, n176, n177, n178, n179, n180, n181, n182,
         n183, n184, n185, n186, n187, n188, n189, n190, n191, n192, n193,
         n194, n195, n196, n197, n198, n199, n200, n201, n202, n203, n204,
         n205, n206, n207, n208, n209, n210, n211, n212, n213, n214, n215,
         n216, n217, n218, n219, n220, n221, n222, n223, n224, n225, n226,
         n227, n228, n229, n230, n231, n232, n233, n234, n235, n236, n237,
         n238, n239, n240, n241, n242, n243, n244, n245, n246, n247, n248,
         n249, n250, n251, n252, n253, n254, n255, n256, n257, n258, n259,
         n260, n261, n262, n263, n264, n265, n266, n267, n268, n269, n270,
         n271, n272, n273, n274, n275, n276, n277, n278, n279, n280, n281,
         n282, n283, n284, n285, n286, n287, n288, n289, n290, n291, n292,
         n293, n294, n295, n296, n297, n298, n299, n300, n301, n302, n303,
         n304, n305, n306, n307, n308, n309, n310, n311, n312, n313, n314,
         n315, n316, n317, n318, n319, n320, n321, n322, n323, n324, n325,
         n326, n327, n328, n329, n330, n331, n332, n333, n334, n335, n336,
         n337, n338, n339, n340, n341, n342, n343, n344, n345, n346, n347,
         n348, n349, n350, n351, n352, n353, n354, n355, n356, n357, n358,
         n359, n360, n361, n362, n363, n364, n365, n366, n367, n368, n369,
         n370, n371, n372, n373, n374, n375, n376, n377, n378, n379, n380,
         n381, n382, n383, n384, n385, n386, n387, n388, n389, n390, n391,
         n392, n393, n394, n395, n396, n397, n398, n399, n400, n401, n402,
         n403, n404, n405, n406, n407, n408, n409, n410, n411, n412, n413,
         n414, n415, n416, n417, n418, n419, n420, n421, n422, n423, n424,
         n425, n426, n427, n428, n429, n430, n431, n432, n433, n434, n435,
         n436, n437, n438, n439, n440, n441, n442, n443, n444, n445, n446,
         n447, n448, n449, n450, n451, n452, n453, n454, n455, n456, n457,
         n458, n459, n460, n461, n462, n463, n464, n465, n466, n467, n468,
         n469, n470, n471, n472, n473, n474, n475, n476, n477, n478, n479,
         n480, n481, n482, n483, n484, n485, n486, n487, n488, n489, n490,
         n491, n492, n493, n494, n495, n496, n497, n498, n499, n500, n501,
         n502, n503, n504, n505, n506, n507, n508, n509, n510, n511, n512,
         n513, n514, n515, n516, n517, n518, n519, n520, n521, n522, n523,
         n524, n525, n526, n527, n528, n529, n530, n531, n532, n533, n534,
         n535, n536, n537, n538, n539, n540, n541, n542, n543, n544, n545,
         n546, n547, n548, n549, n550, n551, n552, n553, n554, n555, n556,
         n557, n558, n559, n560, n561, n562, n563, n564, n565, n566, n567,
         n568, n569, n570, n571, n572, n573, n574, n575, n576, n577, n578,
         n579, n580, n581, n582, n583, n584, n585, n586, n587, n588, n589,
         n590, n591, n592, n593, n594, n595, n596, n597, n598, n599, n600,
         n601, n602, n603, n604, n605, n606, n607, n608, n609, n610, n611,
         n612, n613, n614, n615, n616, n617, n618, n619, n620, n621, n622,
         n623, n624, n625, n626, n627, n628, n629, n630, n631, n632, n633,
         n634, n635, n636, n637, n638, n639, n640, n641, n642, n643, n644,
         n645, n646, n647, n648, n649, n650, n651, n652, n653, n654, n655,
         n656, n657, n658, n659, n660, n661, n662, n663, n664, n665, n666,
         n667, n668, n669, n670, n671, n672, n673, n674, n675, n676, n677,
         n678, n679, n680, n681, n682, n683, n684, n685, n686, n687, n688,
         n689, n690, n691, n692, n693, n694, n695, n696, n697, n698, n699,
         n700, n701, n702, n703, n704, n705, n706, n707, n708, n709, n710,
         n711, n712, n713, n714, n715, n716, n717, n718, n719, n720, n721,
         n722, n723, n724, n725, n726, n727, n728, n729, n730, n731, n732,
         n733, n734, n735, n736, n737, n738, n739, n740, n741, n742, n743,
         n744, n745, n746, n747, n748, n749, n750, n751, n752, n753, n754,
         n755, n756, n757, n758, n759, n761, n762, n763, n764, n765, n766,
         n767, n768, n769, n770, n771, n772, n773;
  wire   [15:0] write_enables;
  assign N10 = r1_sel[0];
  assign N11 = r1_sel[1];
  assign N12 = r1_sel[2];
  assign N13 = r1_sel[3];
  assign N14 = r2_sel[0];
  assign N15 = r2_sel[1];
  assign N16 = r2_sel[2];
  assign N17 = r2_sel[3];

  NOR2X1 U6 ( .A(n5), .B(n6), .Y(write_enables[9]) );
  NOR2X1 U7 ( .A(n6), .B(n7), .Y(write_enables[8]) );
  NOR2X1 U8 ( .A(n8), .B(n9), .Y(write_enables[7]) );
  NOR2X1 U9 ( .A(n8), .B(n10), .Y(write_enables[6]) );
  NOR2X1 U10 ( .A(n9), .B(n11), .Y(write_enables[5]) );
  NOR2X1 U11 ( .A(n10), .B(n11), .Y(write_enables[4]) );
  NOR2X1 U12 ( .A(n9), .B(n12), .Y(write_enables[3]) );
  NOR2X1 U13 ( .A(n10), .B(n12), .Y(write_enables[2]) );
  NOR2X1 U14 ( .A(n6), .B(n9), .Y(write_enables[1]) );
  NAND3X1 U15 ( .A(w_en), .B(n771), .C(w_sel[0]), .Y(n9) );
  NOR2X1 U16 ( .A(n5), .B(n8), .Y(write_enables[15]) );
  NOR2X1 U17 ( .A(n7), .B(n8), .Y(write_enables[14]) );
  NAND2X1 U18 ( .A(w_sel[2]), .B(w_sel[1]), .Y(n8) );
  NOR2X1 U19 ( .A(n5), .B(n11), .Y(write_enables[13]) );
  NOR2X1 U20 ( .A(n7), .B(n11), .Y(write_enables[12]) );
  NAND2X1 U21 ( .A(w_sel[2]), .B(n772), .Y(n11) );
  NOR2X1 U22 ( .A(n5), .B(n12), .Y(write_enables[11]) );
  NAND3X1 U23 ( .A(w_sel[0]), .B(w_en), .C(w_sel[3]), .Y(n5) );
  NOR2X1 U24 ( .A(n7), .B(n12), .Y(write_enables[10]) );
  NAND2X1 U25 ( .A(w_sel[1]), .B(n773), .Y(n12) );
  NAND2X1 U26 ( .A(n13), .B(w_sel[3]), .Y(n7) );
  NOR2X1 U27 ( .A(n6), .B(n10), .Y(write_enables[0]) );
  NAND2X1 U28 ( .A(n13), .B(n771), .Y(n10) );
  NOR2X1 U29 ( .A(n770), .B(w_sel[0]), .Y(n13) );
  NAND2X1 U30 ( .A(n772), .B(n773), .Y(n6) );
  flex_sreg_NUM_BITS17_15 \genblk1[0].REGX  ( .clk(clk), .n_reset(n769), 
        .write_enable(write_enables[0]), .new_value({w_data[16], n759, n757, 
        n754, n752, n749, n746, n743, n741, n739, n737, n734, n731, n728, n725, 
        n722, n719}), .current_value({n774, outreg_data[15:0]}) );
  flex_sreg_NUM_BITS17_14 \genblk1[1].REGX  ( .clk(clk), .n_reset(n762), 
        .write_enable(write_enables[1]), .new_value({w_data[16], n759, n756, 
        n754, n751, n748, n745, n743, n741, n739, n736, n733, n730, n727, n724, 
        n721, n719}), .current_value({\regs_matrix[1][16] , 
        \regs_matrix[1][15] , \regs_matrix[1][14] , \regs_matrix[1][13] , 
        \regs_matrix[1][12] , \regs_matrix[1][11] , \regs_matrix[1][10] , 
        \regs_matrix[1][9] , \regs_matrix[1][8] , \regs_matrix[1][7] , 
        \regs_matrix[1][6] , \regs_matrix[1][5] , \regs_matrix[1][4] , 
        \regs_matrix[1][3] , \regs_matrix[1][2] , \regs_matrix[1][1] , 
        \regs_matrix[1][0] }) );
  flex_sreg_NUM_BITS17_13 \genblk1[2].REGX  ( .clk(clk), .n_reset(n762), 
        .write_enable(write_enables[2]), .new_value({w_data[16], n759, n757, 
        n754, n752, n749, n746, n743, n741, n739, n737, n734, n731, n728, n725, 
        n722, w_data[0]}), .current_value({\regs_matrix[2][16] , 
        \regs_matrix[2][15] , \regs_matrix[2][14] , \regs_matrix[2][13] , 
        \regs_matrix[2][12] , \regs_matrix[2][11] , \regs_matrix[2][10] , 
        \regs_matrix[2][9] , \regs_matrix[2][8] , \regs_matrix[2][7] , 
        \regs_matrix[2][6] , \regs_matrix[2][5] , \regs_matrix[2][4] , 
        \regs_matrix[2][3] , \regs_matrix[2][2] , \regs_matrix[2][1] , 
        \regs_matrix[2][0] }) );
  flex_sreg_NUM_BITS17_12 \genblk1[3].REGX  ( .clk(clk), .n_reset(n763), 
        .write_enable(write_enables[3]), .new_value({w_data[16], n759, n756, 
        n754, n751, n748, n745, n743, n741, n739, n736, n733, n730, n727, n724, 
        n721, n719}), .current_value({\regs_matrix[3][16] , 
        \regs_matrix[3][15] , \regs_matrix[3][14] , \regs_matrix[3][13] , 
        \regs_matrix[3][12] , \regs_matrix[3][11] , \regs_matrix[3][10] , 
        \regs_matrix[3][9] , \regs_matrix[3][8] , \regs_matrix[3][7] , 
        \regs_matrix[3][6] , \regs_matrix[3][5] , \regs_matrix[3][4] , 
        \regs_matrix[3][3] , \regs_matrix[3][2] , \regs_matrix[3][1] , 
        \regs_matrix[3][0] }) );
  flex_sreg_NUM_BITS17_11 \genblk1[4].REGX  ( .clk(clk), .n_reset(n763), 
        .write_enable(write_enables[4]), .new_value({w_data[16], n759, n757, 
        n754, n752, n749, n746, n743, n741, n739, n737, n734, n731, n728, n725, 
        n722, w_data[0]}), .current_value({\regs_matrix[4][16] , 
        \regs_matrix[4][15] , \regs_matrix[4][14] , \regs_matrix[4][13] , 
        \regs_matrix[4][12] , \regs_matrix[4][11] , \regs_matrix[4][10] , 
        \regs_matrix[4][9] , \regs_matrix[4][8] , \regs_matrix[4][7] , 
        \regs_matrix[4][6] , \regs_matrix[4][5] , \regs_matrix[4][4] , 
        \regs_matrix[4][3] , \regs_matrix[4][2] , \regs_matrix[4][1] , 
        \regs_matrix[4][0] }) );
  flex_sreg_NUM_BITS17_10 \genblk1[5].REGX  ( .clk(clk), .n_reset(n764), 
        .write_enable(write_enables[5]), .new_value({w_data[16], n759, n756, 
        n754, n751, n748, n745, n743, n741, n739, n736, n733, n730, n727, n724, 
        n721, n719}), .current_value({\regs_matrix[5][16] , 
        \regs_matrix[5][15] , \regs_matrix[5][14] , \regs_matrix[5][13] , 
        \regs_matrix[5][12] , \regs_matrix[5][11] , \regs_matrix[5][10] , 
        \regs_matrix[5][9] , \regs_matrix[5][8] , \regs_matrix[5][7] , 
        \regs_matrix[5][6] , \regs_matrix[5][5] , \regs_matrix[5][4] , 
        \regs_matrix[5][3] , \regs_matrix[5][2] , \regs_matrix[5][1] , 
        \regs_matrix[5][0] }) );
  flex_sreg_NUM_BITS17_9 \genblk1[6].REGX  ( .clk(clk), .n_reset(n764), 
        .write_enable(write_enables[6]), .new_value({w_data[16], n759, n757, 
        n754, n752, n749, n746, n743, n741, n739, n737, n734, n731, n728, n725, 
        n722, w_data[0]}), .current_value({\regs_matrix[6][16] , 
        \regs_matrix[6][15] , \regs_matrix[6][14] , \regs_matrix[6][13] , 
        \regs_matrix[6][12] , \regs_matrix[6][11] , \regs_matrix[6][10] , 
        \regs_matrix[6][9] , \regs_matrix[6][8] , \regs_matrix[6][7] , 
        \regs_matrix[6][6] , \regs_matrix[6][5] , \regs_matrix[6][4] , 
        \regs_matrix[6][3] , \regs_matrix[6][2] , \regs_matrix[6][1] , 
        \regs_matrix[6][0] }) );
  flex_sreg_NUM_BITS17_8 \genblk1[7].REGX  ( .clk(clk), .n_reset(n765), 
        .write_enable(write_enables[7]), .new_value({w_data[16], n759, n756, 
        n754, n751, n748, n745, n743, n741, n739, n736, n733, n730, n727, n724, 
        n721, n719}), .current_value({\regs_matrix[7][16] , 
        \regs_matrix[7][15] , \regs_matrix[7][14] , \regs_matrix[7][13] , 
        \regs_matrix[7][12] , \regs_matrix[7][11] , \regs_matrix[7][10] , 
        \regs_matrix[7][9] , \regs_matrix[7][8] , \regs_matrix[7][7] , 
        \regs_matrix[7][6] , \regs_matrix[7][5] , \regs_matrix[7][4] , 
        \regs_matrix[7][3] , \regs_matrix[7][2] , \regs_matrix[7][1] , 
        \regs_matrix[7][0] }) );
  flex_sreg_NUM_BITS17_7 \genblk1[8].REGX  ( .clk(clk), .n_reset(n765), 
        .write_enable(write_enables[8]), .new_value({w_data[16], n759, n757, 
        n754, n752, n749, n746, n743, n741, n739, n737, n734, n731, n728, n725, 
        n722, w_data[0]}), .current_value({\regs_matrix[8][16] , 
        \regs_matrix[8][15] , \regs_matrix[8][14] , \regs_matrix[8][13] , 
        \regs_matrix[8][12] , \regs_matrix[8][11] , \regs_matrix[8][10] , 
        \regs_matrix[8][9] , \regs_matrix[8][8] , \regs_matrix[8][7] , 
        \regs_matrix[8][6] , \regs_matrix[8][5] , \regs_matrix[8][4] , 
        \regs_matrix[8][3] , \regs_matrix[8][2] , \regs_matrix[8][1] , 
        \regs_matrix[8][0] }) );
  flex_sreg_NUM_BITS17_6 \genblk1[9].REGX  ( .clk(clk), .n_reset(n766), 
        .write_enable(write_enables[9]), .new_value({w_data[16], n759, n756, 
        n754, n751, n748, n745, n743, n741, n739, n736, n733, n730, n727, n724, 
        n721, n719}), .current_value({\regs_matrix[9][16] , 
        \regs_matrix[9][15] , \regs_matrix[9][14] , \regs_matrix[9][13] , 
        \regs_matrix[9][12] , \regs_matrix[9][11] , \regs_matrix[9][10] , 
        \regs_matrix[9][9] , \regs_matrix[9][8] , \regs_matrix[9][7] , 
        \regs_matrix[9][6] , \regs_matrix[9][5] , \regs_matrix[9][4] , 
        \regs_matrix[9][3] , \regs_matrix[9][2] , \regs_matrix[9][1] , 
        \regs_matrix[9][0] }) );
  flex_sreg_NUM_BITS17_5 \genblk1[10].REGX  ( .clk(clk), .n_reset(n766), 
        .write_enable(write_enables[10]), .new_value({w_data[16], n759, n757, 
        n754, n752, n749, n746, n743, n741, n739, n737, n734, n731, n728, n725, 
        n722, w_data[0]}), .current_value({\regs_matrix[10][16] , 
        \regs_matrix[10][15] , \regs_matrix[10][14] , \regs_matrix[10][13] , 
        \regs_matrix[10][12] , \regs_matrix[10][11] , \regs_matrix[10][10] , 
        \regs_matrix[10][9] , \regs_matrix[10][8] , \regs_matrix[10][7] , 
        \regs_matrix[10][6] , \regs_matrix[10][5] , \regs_matrix[10][4] , 
        \regs_matrix[10][3] , \regs_matrix[10][2] , \regs_matrix[10][1] , 
        \regs_matrix[10][0] }) );
  flex_sreg_NUM_BITS17_4 \genblk1[11].REGX  ( .clk(clk), .n_reset(n767), 
        .write_enable(write_enables[11]), .new_value({w_data[16], n759, n756, 
        n754, n751, n748, n745, n743, n741, n739, n736, n733, n730, n727, n724, 
        n721, n719}), .current_value({\regs_matrix[11][16] , 
        \regs_matrix[11][15] , \regs_matrix[11][14] , \regs_matrix[11][13] , 
        \regs_matrix[11][12] , \regs_matrix[11][11] , \regs_matrix[11][10] , 
        \regs_matrix[11][9] , \regs_matrix[11][8] , \regs_matrix[11][7] , 
        \regs_matrix[11][6] , \regs_matrix[11][5] , \regs_matrix[11][4] , 
        \regs_matrix[11][3] , \regs_matrix[11][2] , \regs_matrix[11][1] , 
        \regs_matrix[11][0] }) );
  flex_sreg_NUM_BITS17_3 \genblk1[12].REGX  ( .clk(clk), .n_reset(n767), 
        .write_enable(write_enables[12]), .new_value({w_data[16], n759, n757, 
        n754, n752, n749, n746, n743, n741, n739, n737, n734, n731, n728, n725, 
        n722, w_data[0]}), .current_value({\regs_matrix[12][16] , 
        \regs_matrix[12][15] , \regs_matrix[12][14] , \regs_matrix[12][13] , 
        \regs_matrix[12][12] , \regs_matrix[12][11] , \regs_matrix[12][10] , 
        \regs_matrix[12][9] , \regs_matrix[12][8] , \regs_matrix[12][7] , 
        \regs_matrix[12][6] , \regs_matrix[12][5] , \regs_matrix[12][4] , 
        \regs_matrix[12][3] , \regs_matrix[12][2] , \regs_matrix[12][1] , 
        \regs_matrix[12][0] }) );
  flex_sreg_NUM_BITS17_2 \genblk1[13].REGX  ( .clk(clk), .n_reset(n768), 
        .write_enable(write_enables[13]), .new_value({w_data[16], n759, n756, 
        n754, n751, n748, n745, n743, n741, n739, n736, n733, n730, n727, n724, 
        n721, n719}), .current_value({\regs_matrix[13][16] , 
        \regs_matrix[13][15] , \regs_matrix[13][14] , \regs_matrix[13][13] , 
        \regs_matrix[13][12] , \regs_matrix[13][11] , \regs_matrix[13][10] , 
        \regs_matrix[13][9] , \regs_matrix[13][8] , \regs_matrix[13][7] , 
        \regs_matrix[13][6] , \regs_matrix[13][5] , \regs_matrix[13][4] , 
        \regs_matrix[13][3] , \regs_matrix[13][2] , \regs_matrix[13][1] , 
        \regs_matrix[13][0] }) );
  flex_sreg_NUM_BITS17_1 \genblk1[14].REGX  ( .clk(clk), .n_reset(n768), 
        .write_enable(write_enables[14]), .new_value({w_data[16], n759, n757, 
        n754, n752, n749, n746, n743, n741, n739, n737, n734, n731, n728, n725, 
        n722, w_data[0]}), .current_value({\regs_matrix[14][16] , 
        \regs_matrix[14][15] , \regs_matrix[14][14] , \regs_matrix[14][13] , 
        \regs_matrix[14][12] , \regs_matrix[14][11] , \regs_matrix[14][10] , 
        \regs_matrix[14][9] , \regs_matrix[14][8] , \regs_matrix[14][7] , 
        \regs_matrix[14][6] , \regs_matrix[14][5] , \regs_matrix[14][4] , 
        \regs_matrix[14][3] , \regs_matrix[14][2] , \regs_matrix[14][1] , 
        \regs_matrix[14][0] }) );
  flex_sreg_NUM_BITS17_0 \genblk1[15].REGX  ( .clk(clk), .n_reset(n769), 
        .write_enable(write_enables[15]), .new_value({w_data[16], n759, n756, 
        n754, n751, n748, n745, n743, n741, n739, n736, n733, n730, n727, n724, 
        n721, n719}), .current_value({\regs_matrix[15][16] , 
        \regs_matrix[15][15] , \regs_matrix[15][14] , \regs_matrix[15][13] , 
        \regs_matrix[15][12] , \regs_matrix[15][11] , \regs_matrix[15][10] , 
        \regs_matrix[15][9] , \regs_matrix[15][8] , \regs_matrix[15][7] , 
        \regs_matrix[15][6] , \regs_matrix[15][5] , \regs_matrix[15][4] , 
        \regs_matrix[15][3] , \regs_matrix[15][2] , \regs_matrix[15][1] , 
        \regs_matrix[15][0] }) );
  INVX4 U2 ( .A(n159), .Y(r1_data[2]) );
  AND2X2 U3 ( .A(N15), .B(N14), .Y(n109) );
  INVX4 U4 ( .A(n99), .Y(n100) );
  INVX1 U5 ( .A(n427), .Y(n444) );
  INVX1 U31 ( .A(n427), .Y(n446) );
  INVX2 U32 ( .A(n107), .Y(n1) );
  BUFX4 U33 ( .A(n107), .Y(n2) );
  BUFX2 U34 ( .A(n107), .Y(n3) );
  BUFX2 U35 ( .A(n107), .Y(n4) );
  BUFX2 U36 ( .A(n107), .Y(n14) );
  INVX2 U37 ( .A(n2), .Y(n15) );
  INVX2 U38 ( .A(n2), .Y(n16) );
  INVX1 U39 ( .A(n2), .Y(n17) );
  INVX1 U40 ( .A(n2), .Y(n18) );
  INVX1 U41 ( .A(n2), .Y(n19) );
  INVX1 U42 ( .A(n3), .Y(n20) );
  INVX1 U43 ( .A(n3), .Y(n21) );
  INVX1 U44 ( .A(n3), .Y(n22) );
  INVX1 U45 ( .A(n3), .Y(n23) );
  INVX1 U46 ( .A(n3), .Y(n24) );
  INVX1 U47 ( .A(n4), .Y(n25) );
  INVX1 U48 ( .A(n4), .Y(n26) );
  INVX1 U49 ( .A(n4), .Y(n27) );
  INVX1 U50 ( .A(n4), .Y(n28) );
  INVX1 U51 ( .A(n4), .Y(n29) );
  INVX2 U52 ( .A(n14), .Y(n30) );
  INVX1 U53 ( .A(n14), .Y(n31) );
  INVX1 U54 ( .A(n14), .Y(n32) );
  INVX1 U55 ( .A(n14), .Y(n33) );
  INVX1 U56 ( .A(n14), .Y(n34) );
  INVX2 U57 ( .A(n1), .Y(n35) );
  INVX2 U58 ( .A(n1), .Y(n36) );
  INVX2 U59 ( .A(n1), .Y(n37) );
  INVX1 U60 ( .A(n35), .Y(n38) );
  INVX1 U61 ( .A(n35), .Y(n39) );
  INVX1 U62 ( .A(n35), .Y(n40) );
  INVX1 U63 ( .A(n35), .Y(n41) );
  INVX1 U64 ( .A(n35), .Y(n42) );
  INVX1 U65 ( .A(n36), .Y(n43) );
  INVX1 U66 ( .A(n36), .Y(n44) );
  INVX1 U67 ( .A(n36), .Y(n45) );
  INVX1 U68 ( .A(n36), .Y(n46) );
  INVX1 U69 ( .A(n36), .Y(n47) );
  INVX1 U70 ( .A(n37), .Y(n48) );
  INVX1 U71 ( .A(n37), .Y(n49) );
  INVX1 U72 ( .A(n37), .Y(n50) );
  INVX1 U73 ( .A(n37), .Y(n51) );
  INVX4 U74 ( .A(n709), .Y(n711) );
  INVX4 U75 ( .A(n464), .Y(n709) );
  AND2X1 U76 ( .A(n93), .B(n441), .Y(n445) );
  INVX4 U77 ( .A(n427), .Y(n430) );
  INVX4 U78 ( .A(n428), .Y(n429) );
  INVX4 U79 ( .A(n142), .Y(r1_data[1]) );
  INVX4 U80 ( .A(n465), .Y(n712) );
  INVX4 U81 ( .A(w_data[10]), .Y(n744) );
  INVX4 U82 ( .A(w_data[6]), .Y(n735) );
  INVX2 U83 ( .A(N10), .Y(n409) );
  INVX2 U84 ( .A(n461), .Y(n706) );
  BUFX2 U85 ( .A(n695), .Y(n696) );
  BUFX2 U86 ( .A(n695), .Y(n697) );
  BUFX2 U87 ( .A(n698), .Y(n699) );
  INVX2 U88 ( .A(n458), .Y(n695) );
  BUFX2 U89 ( .A(n426), .Y(n427) );
  INVX2 U90 ( .A(n460), .Y(n703) );
  INVX4 U91 ( .A(n416), .Y(n418) );
  INVX2 U92 ( .A(n176), .Y(r1_data[3]) );
  INVX2 U93 ( .A(n193), .Y(r1_data[4]) );
  INVX2 U94 ( .A(n210), .Y(r1_data[5]) );
  INVX2 U95 ( .A(n227), .Y(r1_data[6]) );
  INVX2 U96 ( .A(n295), .Y(r1_data[10]) );
  INVX2 U97 ( .A(n312), .Y(r1_data[11]) );
  INVX2 U98 ( .A(n128), .Y(n421) );
  INVX2 U99 ( .A(n134), .Y(n431) );
  INVX2 U100 ( .A(n123), .Y(n412) );
  INVX2 U101 ( .A(n125), .Y(n419) );
  INVX4 U102 ( .A(n99), .Y(n101) );
  INVX2 U103 ( .A(n717), .Y(n715) );
  INVX2 U104 ( .A(n244), .Y(r1_data[7]) );
  INVX2 U105 ( .A(n278), .Y(r1_data[9]) );
  INVX2 U106 ( .A(n329), .Y(r1_data[12]) );
  INVX2 U107 ( .A(n346), .Y(r1_data[13]) );
  INVX2 U108 ( .A(n103), .Y(n434) );
  BUFX2 U109 ( .A(n426), .Y(n428) );
  INVX2 U110 ( .A(w_data[4]), .Y(n729) );
  NAND2X1 U111 ( .A(n452), .B(n52), .Y(n53) );
  NAND2X1 U112 ( .A(n453), .B(n715), .Y(n54) );
  NAND2X1 U113 ( .A(n53), .B(n54), .Y(n55) );
  INVX1 U114 ( .A(n715), .Y(n52) );
  INVX4 U115 ( .A(n55), .Y(r2_data[0]) );
  INVX2 U116 ( .A(n706), .Y(n56) );
  INVX2 U117 ( .A(n706), .Y(n57) );
  INVX2 U118 ( .A(n706), .Y(n58) );
  INVX2 U119 ( .A(n706), .Y(n59) );
  INVX2 U120 ( .A(n706), .Y(n60) );
  INVX2 U121 ( .A(n706), .Y(n61) );
  INVX1 U122 ( .A(n706), .Y(n62) );
  BUFX2 U123 ( .A(n461), .Y(n63) );
  BUFX2 U124 ( .A(n461), .Y(n64) );
  BUFX2 U125 ( .A(n461), .Y(n65) );
  BUFX2 U126 ( .A(n461), .Y(n66) );
  BUFX2 U127 ( .A(n461), .Y(n67) );
  BUFX2 U128 ( .A(n461), .Y(n68) );
  BUFX2 U129 ( .A(n461), .Y(n69) );
  INVX1 U130 ( .A(n695), .Y(n70) );
  INVX1 U131 ( .A(n695), .Y(n71) );
  INVX1 U132 ( .A(n695), .Y(n72) );
  INVX1 U133 ( .A(n695), .Y(n73) );
  INVX1 U134 ( .A(n695), .Y(n74) );
  INVX1 U135 ( .A(n695), .Y(n75) );
  INVX1 U136 ( .A(n696), .Y(n76) );
  INVX1 U137 ( .A(n696), .Y(n77) );
  INVX1 U138 ( .A(n696), .Y(n78) );
  INVX1 U139 ( .A(n696), .Y(n79) );
  INVX1 U140 ( .A(n696), .Y(n80) );
  INVX2 U141 ( .A(n696), .Y(n81) );
  INVX1 U142 ( .A(n697), .Y(n82) );
  INVX1 U143 ( .A(n697), .Y(n83) );
  INVX1 U144 ( .A(n697), .Y(n84) );
  INVX1 U145 ( .A(n697), .Y(n85) );
  INVX1 U146 ( .A(n697), .Y(n86) );
  INVX2 U147 ( .A(n697), .Y(n87) );
  INVX1 U148 ( .A(n458), .Y(n88) );
  INVX4 U149 ( .A(n412), .Y(n413) );
  INVX4 U150 ( .A(n412), .Y(n414) );
  BUFX2 U151 ( .A(n130), .Y(n89) );
  BUFX2 U152 ( .A(n130), .Y(n90) );
  INVX2 U153 ( .A(n397), .Y(n130) );
  INVX2 U154 ( .A(n98), .Y(n438) );
  INVX1 U155 ( .A(n425), .Y(n437) );
  AND2X2 U156 ( .A(N14), .B(N16), .Y(n91) );
  INVX2 U157 ( .A(n437), .Y(n92) );
  INVX2 U158 ( .A(N12), .Y(n93) );
  INVX2 U159 ( .A(n408), .Y(n94) );
  INVX8 U160 ( .A(n416), .Y(n417) );
  INVX4 U161 ( .A(n732), .Y(n733) );
  INVX4 U162 ( .A(n732), .Y(n734) );
  INVX8 U163 ( .A(n703), .Y(n705) );
  INVX8 U164 ( .A(n753), .Y(n754) );
  INVX4 U165 ( .A(n712), .Y(n95) );
  NAND2X1 U166 ( .A(n690), .B(n91), .Y(n465) );
  INVX4 U167 ( .A(n723), .Y(n724) );
  INVX4 U168 ( .A(n723), .Y(n725) );
  INVX2 U169 ( .A(n407), .Y(n96) );
  INVX4 U170 ( .A(N11), .Y(n407) );
  BUFX2 U171 ( .A(n420), .Y(n97) );
  INVX4 U172 ( .A(n726), .Y(n728) );
  INVX4 U173 ( .A(n726), .Y(n727) );
  BUFX2 U174 ( .A(n397), .Y(n98) );
  INVX4 U175 ( .A(n729), .Y(n730) );
  INVX4 U176 ( .A(n729), .Y(n731) );
  INVX4 U177 ( .A(n703), .Y(n704) );
  INVX4 U178 ( .A(n261), .Y(r1_data[8]) );
  INVX4 U179 ( .A(n712), .Y(n713) );
  INVX8 U180 ( .A(n738), .Y(n739) );
  INVX4 U181 ( .A(n108), .Y(n707) );
  INVX8 U182 ( .A(n709), .Y(n710) );
  INVX2 U183 ( .A(N12), .Y(n408) );
  INVX4 U184 ( .A(n108), .Y(n708) );
  AND2X2 U185 ( .A(n109), .B(n691), .Y(n108) );
  INVX4 U186 ( .A(n712), .Y(n714) );
  INVX8 U187 ( .A(n431), .Y(n433) );
  INVX2 U188 ( .A(n412), .Y(n415) );
  AND2X2 U189 ( .A(n441), .B(n93), .Y(n103) );
  INVX8 U190 ( .A(n708), .Y(n99) );
  INVX8 U191 ( .A(n99), .Y(n102) );
  AND2X2 U192 ( .A(N16), .B(n109), .Y(n107) );
  INVX4 U193 ( .A(n700), .Y(n701) );
  INVX8 U194 ( .A(n699), .Y(n702) );
  INVX2 U195 ( .A(N17), .Y(n717) );
  MUX2X1 U196 ( .B(n105), .A(n106), .S(n716), .Y(r2_data[15]) );
  NAND2X1 U197 ( .A(n674), .B(n675), .Y(n105) );
  NAND2X1 U198 ( .A(n668), .B(n669), .Y(n106) );
  INVX2 U199 ( .A(w_data[3]), .Y(n726) );
  INVX2 U200 ( .A(w_data[2]), .Y(n723) );
  INVX2 U201 ( .A(w_data[5]), .Y(n732) );
  INVX2 U202 ( .A(w_data[1]), .Y(n720) );
  INVX2 U203 ( .A(w_data[0]), .Y(n718) );
  BUFX2 U204 ( .A(n698), .Y(n700) );
  INVX2 U205 ( .A(n717), .Y(n716) );
  INVX2 U206 ( .A(n459), .Y(n698) );
  INVX4 U207 ( .A(n445), .Y(n436) );
  INVX4 U208 ( .A(n735), .Y(n737) );
  INVX4 U209 ( .A(n747), .Y(n748) );
  INVX4 U210 ( .A(n747), .Y(n749) );
  INVX4 U211 ( .A(n755), .Y(n756) );
  INVX4 U212 ( .A(n744), .Y(n745) );
  INVX4 U213 ( .A(n755), .Y(n757) );
  INVX4 U214 ( .A(n744), .Y(n746) );
  INVX4 U215 ( .A(n735), .Y(n736) );
  INVX4 U216 ( .A(n750), .Y(n752) );
  INVX4 U217 ( .A(n750), .Y(n751) );
  INVX2 U218 ( .A(n720), .Y(n722) );
  INVX2 U219 ( .A(n720), .Y(n721) );
  INVX2 U220 ( .A(n718), .Y(n719) );
  INVX2 U221 ( .A(n761), .Y(outreg_data[16]) );
  INVX2 U222 ( .A(n774), .Y(n761) );
  BUFX2 U223 ( .A(n_reset), .Y(n762) );
  BUFX2 U224 ( .A(n_reset), .Y(n763) );
  BUFX2 U225 ( .A(n_reset), .Y(n764) );
  BUFX2 U226 ( .A(n_reset), .Y(n765) );
  BUFX2 U227 ( .A(n_reset), .Y(n766) );
  BUFX2 U228 ( .A(n_reset), .Y(n767) );
  BUFX2 U229 ( .A(n_reset), .Y(n768) );
  BUFX2 U230 ( .A(n_reset), .Y(n769) );
  AOI22X1 U231 ( .A(n113), .B(n112), .C(n111), .D(n110), .Y(n114) );
  INVX2 U232 ( .A(N13), .Y(n115) );
  INVX2 U233 ( .A(n114), .Y(r1_data[16]) );
  AOI22X1 U234 ( .A(n117), .B(n118), .C(n119), .D(n120), .Y(n116) );
  NOR2X1 U235 ( .A(n121), .B(n122), .Y(n120) );
  OAI22X1 U236 ( .A(\regs_matrix[6][0] ), .B(n413), .C(outreg_data[0]), .D(
        n418), .Y(n122) );
  OAI21X1 U237 ( .A(\regs_matrix[4][0] ), .B(n420), .C(n115), .Y(n121) );
  NOR2X1 U238 ( .A(n126), .B(n127), .Y(n119) );
  OAI21X1 U239 ( .A(\regs_matrix[7][0] ), .B(n422), .C(n129), .Y(n127) );
  AOI22X1 U240 ( .A(n425), .B(n131), .C(n103), .D(n132), .Y(n129) );
  INVX2 U241 ( .A(\regs_matrix[3][0] ), .Y(n132) );
  INVX2 U242 ( .A(\regs_matrix[1][0] ), .Y(n131) );
  OAI22X1 U243 ( .A(\regs_matrix[2][0] ), .B(n429), .C(\regs_matrix[5][0] ), 
        .D(n433), .Y(n126) );
  NOR2X1 U244 ( .A(n135), .B(n136), .Y(n118) );
  OAI22X1 U245 ( .A(\regs_matrix[14][0] ), .B(n415), .C(\regs_matrix[8][0] ), 
        .D(n417), .Y(n136) );
  OAI21X1 U246 ( .A(\regs_matrix[12][0] ), .B(n442), .C(N13), .Y(n135) );
  NOR2X1 U247 ( .A(n137), .B(n138), .Y(n117) );
  OAI21X1 U248 ( .A(\regs_matrix[15][0] ), .B(n423), .C(n139), .Y(n138) );
  AOI22X1 U249 ( .A(n92), .B(n140), .C(n103), .D(n141), .Y(n139) );
  INVX2 U250 ( .A(\regs_matrix[11][0] ), .Y(n141) );
  INVX2 U251 ( .A(\regs_matrix[9][0] ), .Y(n140) );
  OAI22X1 U252 ( .A(\regs_matrix[10][0] ), .B(n439), .C(\regs_matrix[13][0] ), 
        .D(n433), .Y(n137) );
  AOI22X1 U253 ( .A(n143), .B(n144), .C(n145), .D(n146), .Y(n142) );
  NOR2X1 U254 ( .A(n147), .B(n148), .Y(n146) );
  OAI22X1 U255 ( .A(outreg_data[1]), .B(n418), .C(\regs_matrix[2][1] ), .D(
        n430), .Y(n148) );
  OAI22X1 U256 ( .A(\regs_matrix[4][1] ), .B(n420), .C(\regs_matrix[6][1] ), 
        .D(n414), .Y(n147) );
  NOR2X1 U257 ( .A(n149), .B(n150), .Y(n145) );
  OAI21X1 U258 ( .A(\regs_matrix[3][1] ), .B(n435), .C(n151), .Y(n150) );
  AOI21X1 U259 ( .A(n89), .B(n152), .C(N13), .Y(n151) );
  INVX2 U260 ( .A(\regs_matrix[1][1] ), .Y(n152) );
  OAI22X1 U261 ( .A(\regs_matrix[5][1] ), .B(n432), .C(\regs_matrix[7][1] ), 
        .D(n424), .Y(n149) );
  NOR2X1 U262 ( .A(n153), .B(n154), .Y(n144) );
  OAI22X1 U263 ( .A(\regs_matrix[8][1] ), .B(n417), .C(\regs_matrix[10][1] ), 
        .D(n439), .Y(n154) );
  OAI22X1 U264 ( .A(\regs_matrix[12][1] ), .B(n442), .C(\regs_matrix[14][1] ), 
        .D(n415), .Y(n153) );
  NOR2X1 U265 ( .A(n155), .B(n156), .Y(n143) );
  OAI21X1 U266 ( .A(\regs_matrix[11][1] ), .B(n436), .C(n157), .Y(n156) );
  AOI21X1 U267 ( .A(n92), .B(n158), .C(n115), .Y(n157) );
  INVX2 U268 ( .A(\regs_matrix[9][1] ), .Y(n158) );
  OAI22X1 U269 ( .A(\regs_matrix[13][1] ), .B(n433), .C(\regs_matrix[15][1] ), 
        .D(n440), .Y(n155) );
  AOI22X1 U270 ( .A(n160), .B(n161), .C(n162), .D(n163), .Y(n159) );
  NOR2X1 U271 ( .A(n164), .B(n165), .Y(n163) );
  OAI22X1 U272 ( .A(outreg_data[2]), .B(n417), .C(\regs_matrix[2][2] ), .D(
        n429), .Y(n165) );
  OAI22X1 U273 ( .A(\regs_matrix[4][2] ), .B(n420), .C(\regs_matrix[6][2] ), 
        .D(n413), .Y(n164) );
  NOR2X1 U274 ( .A(n166), .B(n167), .Y(n162) );
  OAI21X1 U275 ( .A(\regs_matrix[3][2] ), .B(n436), .C(n168), .Y(n167) );
  AOI21X1 U276 ( .A(n425), .B(n169), .C(N13), .Y(n168) );
  INVX2 U277 ( .A(\regs_matrix[1][2] ), .Y(n169) );
  OAI22X1 U278 ( .A(\regs_matrix[5][2] ), .B(n432), .C(\regs_matrix[7][2] ), 
        .D(n422), .Y(n166) );
  NOR2X1 U279 ( .A(n170), .B(n171), .Y(n161) );
  OAI22X1 U280 ( .A(\regs_matrix[8][2] ), .B(n417), .C(\regs_matrix[10][2] ), 
        .D(n439), .Y(n171) );
  OAI22X1 U281 ( .A(\regs_matrix[12][2] ), .B(n442), .C(\regs_matrix[14][2] ), 
        .D(n415), .Y(n170) );
  NOR2X1 U282 ( .A(n172), .B(n173), .Y(n160) );
  OAI21X1 U283 ( .A(\regs_matrix[11][2] ), .B(n436), .C(n174), .Y(n173) );
  AOI21X1 U284 ( .A(n92), .B(n175), .C(n115), .Y(n174) );
  INVX2 U285 ( .A(\regs_matrix[9][2] ), .Y(n175) );
  OAI22X1 U286 ( .A(\regs_matrix[13][2] ), .B(n433), .C(\regs_matrix[15][2] ), 
        .D(n440), .Y(n172) );
  AOI22X1 U287 ( .A(n177), .B(n178), .C(n179), .D(n180), .Y(n176) );
  NOR2X1 U288 ( .A(n181), .B(n182), .Y(n180) );
  OAI22X1 U289 ( .A(outreg_data[3]), .B(n418), .C(\regs_matrix[2][3] ), .D(
        n429), .Y(n182) );
  OAI22X1 U290 ( .A(\regs_matrix[4][3] ), .B(n420), .C(\regs_matrix[6][3] ), 
        .D(n414), .Y(n181) );
  NOR2X1 U291 ( .A(n184), .B(n183), .Y(n179) );
  OAI21X1 U292 ( .A(\regs_matrix[3][3] ), .B(n436), .C(n185), .Y(n184) );
  AOI21X1 U293 ( .A(n90), .B(n186), .C(N13), .Y(n185) );
  INVX2 U294 ( .A(\regs_matrix[1][3] ), .Y(n186) );
  OAI22X1 U295 ( .A(\regs_matrix[5][3] ), .B(n432), .C(\regs_matrix[7][3] ), 
        .D(n424), .Y(n183) );
  NOR2X1 U296 ( .A(n187), .B(n188), .Y(n178) );
  OAI22X1 U297 ( .A(\regs_matrix[8][3] ), .B(n417), .C(\regs_matrix[10][3] ), 
        .D(n439), .Y(n188) );
  OAI22X1 U298 ( .A(\regs_matrix[12][3] ), .B(n442), .C(\regs_matrix[14][3] ), 
        .D(n415), .Y(n187) );
  NOR2X1 U299 ( .A(n189), .B(n190), .Y(n177) );
  OAI21X1 U300 ( .A(\regs_matrix[11][3] ), .B(n436), .C(n191), .Y(n190) );
  AOI21X1 U301 ( .A(n92), .B(n192), .C(n115), .Y(n191) );
  INVX2 U302 ( .A(\regs_matrix[9][3] ), .Y(n192) );
  OAI22X1 U303 ( .A(\regs_matrix[13][3] ), .B(n433), .C(\regs_matrix[15][3] ), 
        .D(n440), .Y(n189) );
  AOI22X1 U304 ( .A(n194), .B(n195), .C(n196), .D(n197), .Y(n193) );
  NOR2X1 U305 ( .A(n198), .B(n199), .Y(n197) );
  OAI22X1 U306 ( .A(outreg_data[4]), .B(n418), .C(\regs_matrix[2][4] ), .D(
        n446), .Y(n199) );
  OAI22X1 U307 ( .A(\regs_matrix[4][4] ), .B(n420), .C(\regs_matrix[6][4] ), 
        .D(n413), .Y(n198) );
  NOR2X1 U308 ( .A(n201), .B(n200), .Y(n196) );
  OAI21X1 U309 ( .A(\regs_matrix[3][4] ), .B(n436), .C(n202), .Y(n201) );
  AOI21X1 U310 ( .A(n438), .B(n203), .C(N13), .Y(n202) );
  INVX2 U311 ( .A(\regs_matrix[1][4] ), .Y(n203) );
  OAI22X1 U312 ( .A(\regs_matrix[5][4] ), .B(n433), .C(\regs_matrix[7][4] ), 
        .D(n423), .Y(n200) );
  NOR2X1 U313 ( .A(n204), .B(n205), .Y(n195) );
  OAI22X1 U314 ( .A(\regs_matrix[8][4] ), .B(n417), .C(\regs_matrix[10][4] ), 
        .D(n439), .Y(n205) );
  OAI22X1 U315 ( .A(\regs_matrix[12][4] ), .B(n442), .C(\regs_matrix[14][4] ), 
        .D(n415), .Y(n204) );
  NOR2X1 U316 ( .A(n206), .B(n207), .Y(n194) );
  OAI21X1 U317 ( .A(\regs_matrix[11][4] ), .B(n436), .C(n208), .Y(n207) );
  AOI21X1 U318 ( .A(n92), .B(n209), .C(n115), .Y(n208) );
  INVX2 U319 ( .A(\regs_matrix[9][4] ), .Y(n209) );
  OAI22X1 U320 ( .A(\regs_matrix[13][4] ), .B(n433), .C(\regs_matrix[15][4] ), 
        .D(n440), .Y(n206) );
  AOI22X1 U321 ( .A(n211), .B(n212), .C(n213), .D(n214), .Y(n210) );
  NOR2X1 U322 ( .A(n215), .B(n216), .Y(n214) );
  OAI22X1 U323 ( .A(outreg_data[5]), .B(n418), .C(\regs_matrix[2][5] ), .D(
        n444), .Y(n216) );
  OAI22X1 U324 ( .A(\regs_matrix[4][5] ), .B(n420), .C(\regs_matrix[6][5] ), 
        .D(n413), .Y(n215) );
  NOR2X1 U325 ( .A(n217), .B(n218), .Y(n213) );
  OAI21X1 U326 ( .A(\regs_matrix[3][5] ), .B(n436), .C(n219), .Y(n218) );
  AOI21X1 U327 ( .A(n90), .B(n220), .C(N13), .Y(n219) );
  INVX2 U328 ( .A(\regs_matrix[1][5] ), .Y(n220) );
  OAI22X1 U329 ( .A(\regs_matrix[5][5] ), .B(n432), .C(\regs_matrix[7][5] ), 
        .D(n424), .Y(n217) );
  NOR2X1 U330 ( .A(n221), .B(n222), .Y(n212) );
  OAI22X1 U331 ( .A(\regs_matrix[8][5] ), .B(n417), .C(\regs_matrix[10][5] ), 
        .D(n439), .Y(n222) );
  OAI22X1 U332 ( .A(\regs_matrix[12][5] ), .B(n442), .C(\regs_matrix[14][5] ), 
        .D(n415), .Y(n221) );
  NOR2X1 U333 ( .A(n223), .B(n224), .Y(n211) );
  OAI21X1 U334 ( .A(\regs_matrix[11][5] ), .B(n436), .C(n225), .Y(n224) );
  AOI21X1 U335 ( .A(n92), .B(n226), .C(n115), .Y(n225) );
  INVX2 U336 ( .A(\regs_matrix[9][5] ), .Y(n226) );
  OAI22X1 U337 ( .A(\regs_matrix[13][5] ), .B(n433), .C(\regs_matrix[15][5] ), 
        .D(n440), .Y(n223) );
  AOI22X1 U338 ( .A(n228), .B(n229), .C(n230), .D(n231), .Y(n227) );
  NOR2X1 U339 ( .A(n232), .B(n233), .Y(n231) );
  OAI22X1 U340 ( .A(outreg_data[6]), .B(n417), .C(\regs_matrix[2][6] ), .D(
        n444), .Y(n233) );
  OAI22X1 U341 ( .A(\regs_matrix[4][6] ), .B(n420), .C(\regs_matrix[6][6] ), 
        .D(n413), .Y(n232) );
  NOR2X1 U342 ( .A(n234), .B(n235), .Y(n230) );
  OAI21X1 U343 ( .A(\regs_matrix[3][6] ), .B(n436), .C(n236), .Y(n235) );
  AOI21X1 U344 ( .A(n89), .B(n237), .C(N13), .Y(n236) );
  INVX2 U345 ( .A(\regs_matrix[1][6] ), .Y(n237) );
  OAI22X1 U346 ( .A(\regs_matrix[5][6] ), .B(n433), .C(\regs_matrix[7][6] ), 
        .D(n422), .Y(n234) );
  NOR2X1 U347 ( .A(n238), .B(n239), .Y(n229) );
  OAI22X1 U348 ( .A(\regs_matrix[8][6] ), .B(n417), .C(\regs_matrix[10][6] ), 
        .D(n439), .Y(n239) );
  OAI22X1 U349 ( .A(\regs_matrix[12][6] ), .B(n442), .C(\regs_matrix[14][6] ), 
        .D(n415), .Y(n238) );
  NOR2X1 U350 ( .A(n240), .B(n241), .Y(n228) );
  OAI21X1 U351 ( .A(\regs_matrix[11][6] ), .B(n436), .C(n242), .Y(n241) );
  AOI21X1 U352 ( .A(n92), .B(n243), .C(n115), .Y(n242) );
  INVX2 U353 ( .A(\regs_matrix[9][6] ), .Y(n243) );
  OAI22X1 U354 ( .A(\regs_matrix[13][6] ), .B(n433), .C(\regs_matrix[15][6] ), 
        .D(n440), .Y(n240) );
  AOI22X1 U355 ( .A(n245), .B(n246), .C(n247), .D(n248), .Y(n244) );
  NOR2X1 U356 ( .A(n249), .B(n250), .Y(n248) );
  OAI22X1 U357 ( .A(outreg_data[7]), .B(n418), .C(\regs_matrix[2][7] ), .D(
        n429), .Y(n250) );
  OAI22X1 U358 ( .A(\regs_matrix[4][7] ), .B(n420), .C(\regs_matrix[6][7] ), 
        .D(n414), .Y(n249) );
  NOR2X1 U359 ( .A(n251), .B(n252), .Y(n247) );
  OAI21X1 U360 ( .A(\regs_matrix[3][7] ), .B(n435), .C(n253), .Y(n252) );
  AOI21X1 U361 ( .A(n90), .B(n254), .C(N13), .Y(n253) );
  INVX2 U362 ( .A(\regs_matrix[1][7] ), .Y(n254) );
  OAI22X1 U363 ( .A(\regs_matrix[5][7] ), .B(n432), .C(\regs_matrix[7][7] ), 
        .D(n424), .Y(n251) );
  NOR2X1 U364 ( .A(n255), .B(n256), .Y(n246) );
  OAI22X1 U365 ( .A(\regs_matrix[8][7] ), .B(n417), .C(\regs_matrix[10][7] ), 
        .D(n439), .Y(n256) );
  OAI22X1 U366 ( .A(\regs_matrix[12][7] ), .B(n442), .C(\regs_matrix[14][7] ), 
        .D(n415), .Y(n255) );
  NOR2X1 U367 ( .A(n257), .B(n258), .Y(n245) );
  OAI21X1 U368 ( .A(\regs_matrix[11][7] ), .B(n435), .C(n259), .Y(n258) );
  AOI21X1 U369 ( .A(n92), .B(n260), .C(n115), .Y(n259) );
  INVX2 U370 ( .A(\regs_matrix[9][7] ), .Y(n260) );
  OAI22X1 U371 ( .A(\regs_matrix[13][7] ), .B(n433), .C(\regs_matrix[15][7] ), 
        .D(n440), .Y(n257) );
  AOI22X1 U372 ( .A(n262), .B(n263), .C(n264), .D(n265), .Y(n261) );
  NOR2X1 U373 ( .A(n266), .B(n267), .Y(n265) );
  OAI22X1 U374 ( .A(outreg_data[8]), .B(n417), .C(\regs_matrix[2][8] ), .D(
        n446), .Y(n267) );
  OAI22X1 U375 ( .A(\regs_matrix[4][8] ), .B(n420), .C(\regs_matrix[6][8] ), 
        .D(n413), .Y(n266) );
  NOR2X1 U376 ( .A(n268), .B(n269), .Y(n264) );
  OAI21X1 U377 ( .A(\regs_matrix[3][8] ), .B(n435), .C(n270), .Y(n269) );
  AOI21X1 U378 ( .A(n438), .B(n271), .C(N13), .Y(n270) );
  INVX2 U379 ( .A(\regs_matrix[1][8] ), .Y(n271) );
  OAI22X1 U380 ( .A(\regs_matrix[5][8] ), .B(n433), .C(\regs_matrix[7][8] ), 
        .D(n422), .Y(n268) );
  NOR2X1 U381 ( .A(n272), .B(n273), .Y(n263) );
  OAI22X1 U382 ( .A(\regs_matrix[8][8] ), .B(n417), .C(\regs_matrix[10][8] ), 
        .D(n439), .Y(n273) );
  OAI22X1 U383 ( .A(\regs_matrix[12][8] ), .B(n442), .C(\regs_matrix[14][8] ), 
        .D(n415), .Y(n272) );
  NOR2X1 U384 ( .A(n274), .B(n275), .Y(n262) );
  OAI21X1 U385 ( .A(\regs_matrix[11][8] ), .B(n435), .C(n276), .Y(n275) );
  AOI21X1 U386 ( .A(n92), .B(n277), .C(n115), .Y(n276) );
  INVX2 U387 ( .A(\regs_matrix[9][8] ), .Y(n277) );
  OAI22X1 U388 ( .A(\regs_matrix[13][8] ), .B(n433), .C(\regs_matrix[15][8] ), 
        .D(n440), .Y(n274) );
  AOI22X1 U389 ( .A(n279), .B(n280), .C(n281), .D(n282), .Y(n278) );
  NOR2X1 U390 ( .A(n283), .B(n284), .Y(n282) );
  OAI22X1 U391 ( .A(outreg_data[9]), .B(n418), .C(\regs_matrix[2][9] ), .D(
        n430), .Y(n284) );
  OAI22X1 U392 ( .A(\regs_matrix[4][9] ), .B(n420), .C(\regs_matrix[6][9] ), 
        .D(n414), .Y(n283) );
  NOR2X1 U393 ( .A(n285), .B(n286), .Y(n281) );
  OAI21X1 U394 ( .A(\regs_matrix[3][9] ), .B(n435), .C(n287), .Y(n286) );
  AOI21X1 U395 ( .A(n438), .B(n288), .C(N13), .Y(n287) );
  INVX2 U396 ( .A(\regs_matrix[1][9] ), .Y(n288) );
  OAI22X1 U397 ( .A(\regs_matrix[5][9] ), .B(n432), .C(\regs_matrix[7][9] ), 
        .D(n423), .Y(n285) );
  NOR2X1 U398 ( .A(n289), .B(n290), .Y(n280) );
  OAI22X1 U399 ( .A(\regs_matrix[8][9] ), .B(n417), .C(\regs_matrix[10][9] ), 
        .D(n439), .Y(n290) );
  OAI22X1 U400 ( .A(\regs_matrix[12][9] ), .B(n442), .C(\regs_matrix[14][9] ), 
        .D(n415), .Y(n289) );
  NOR2X1 U401 ( .A(n291), .B(n292), .Y(n279) );
  OAI21X1 U402 ( .A(\regs_matrix[11][9] ), .B(n435), .C(n293), .Y(n292) );
  AOI21X1 U403 ( .A(n92), .B(n294), .C(n115), .Y(n293) );
  INVX2 U404 ( .A(\regs_matrix[9][9] ), .Y(n294) );
  OAI22X1 U405 ( .A(\regs_matrix[13][9] ), .B(n433), .C(\regs_matrix[15][9] ), 
        .D(n440), .Y(n291) );
  AOI22X1 U406 ( .A(n296), .B(n297), .C(n298), .D(n299), .Y(n295) );
  NOR2X1 U407 ( .A(n301), .B(n300), .Y(n299) );
  OAI22X1 U408 ( .A(outreg_data[10]), .B(n418), .C(\regs_matrix[2][10] ), .D(
        n430), .Y(n301) );
  OAI22X1 U409 ( .A(\regs_matrix[4][10] ), .B(n420), .C(\regs_matrix[6][10] ), 
        .D(n413), .Y(n300) );
  NOR2X1 U410 ( .A(n303), .B(n302), .Y(n298) );
  OAI21X1 U411 ( .A(\regs_matrix[3][10] ), .B(n435), .C(n304), .Y(n303) );
  AOI21X1 U412 ( .A(n438), .B(n305), .C(N13), .Y(n304) );
  INVX2 U413 ( .A(\regs_matrix[1][10] ), .Y(n305) );
  OAI22X1 U414 ( .A(\regs_matrix[5][10] ), .B(n433), .C(\regs_matrix[7][10] ), 
        .D(n423), .Y(n302) );
  NOR2X1 U415 ( .A(n306), .B(n307), .Y(n297) );
  OAI22X1 U416 ( .A(\regs_matrix[8][10] ), .B(n417), .C(\regs_matrix[10][10] ), 
        .D(n439), .Y(n307) );
  OAI22X1 U417 ( .A(\regs_matrix[12][10] ), .B(n442), .C(\regs_matrix[14][10] ), .D(n415), .Y(n306) );
  NOR2X1 U418 ( .A(n308), .B(n309), .Y(n296) );
  OAI21X1 U419 ( .A(\regs_matrix[11][10] ), .B(n435), .C(n310), .Y(n309) );
  AOI21X1 U420 ( .A(n92), .B(n311), .C(n115), .Y(n310) );
  INVX2 U421 ( .A(\regs_matrix[9][10] ), .Y(n311) );
  OAI22X1 U422 ( .A(\regs_matrix[13][10] ), .B(n433), .C(\regs_matrix[15][10] ), .D(n440), .Y(n308) );
  AOI22X1 U423 ( .A(n313), .B(n314), .C(n315), .D(n316), .Y(n312) );
  NOR2X1 U424 ( .A(n317), .B(n318), .Y(n316) );
  OAI22X1 U425 ( .A(outreg_data[11]), .B(n418), .C(\regs_matrix[2][11] ), .D(
        n430), .Y(n318) );
  OAI22X1 U426 ( .A(\regs_matrix[4][11] ), .B(n420), .C(\regs_matrix[6][11] ), 
        .D(n414), .Y(n317) );
  NOR2X1 U427 ( .A(n319), .B(n320), .Y(n315) );
  OAI21X1 U428 ( .A(\regs_matrix[3][11] ), .B(n435), .C(n321), .Y(n320) );
  AOI21X1 U429 ( .A(n89), .B(n322), .C(N13), .Y(n321) );
  INVX2 U430 ( .A(\regs_matrix[1][11] ), .Y(n322) );
  OAI22X1 U431 ( .A(\regs_matrix[5][11] ), .B(n432), .C(\regs_matrix[7][11] ), 
        .D(n424), .Y(n319) );
  NOR2X1 U432 ( .A(n323), .B(n324), .Y(n314) );
  OAI22X1 U433 ( .A(\regs_matrix[8][11] ), .B(n417), .C(\regs_matrix[10][11] ), 
        .D(n439), .Y(n324) );
  OAI22X1 U434 ( .A(\regs_matrix[12][11] ), .B(n442), .C(\regs_matrix[14][11] ), .D(n415), .Y(n323) );
  NOR2X1 U435 ( .A(n325), .B(n326), .Y(n313) );
  OAI21X1 U436 ( .A(\regs_matrix[11][11] ), .B(n435), .C(n327), .Y(n326) );
  AOI21X1 U437 ( .A(n92), .B(n328), .C(n115), .Y(n327) );
  INVX2 U438 ( .A(\regs_matrix[9][11] ), .Y(n328) );
  OAI22X1 U439 ( .A(\regs_matrix[13][11] ), .B(n433), .C(\regs_matrix[15][11] ), .D(n440), .Y(n325) );
  AOI22X1 U440 ( .A(n330), .B(n331), .C(n332), .D(n333), .Y(n329) );
  NOR2X1 U441 ( .A(n334), .B(n335), .Y(n333) );
  OAI22X1 U442 ( .A(outreg_data[12]), .B(n417), .C(\regs_matrix[2][12] ), .D(
        n444), .Y(n335) );
  OAI22X1 U443 ( .A(\regs_matrix[4][12] ), .B(n420), .C(\regs_matrix[6][12] ), 
        .D(n413), .Y(n334) );
  NOR2X1 U444 ( .A(n336), .B(n337), .Y(n332) );
  OAI21X1 U445 ( .A(\regs_matrix[3][12] ), .B(n435), .C(n338), .Y(n337) );
  AOI21X1 U446 ( .A(n90), .B(n339), .C(N13), .Y(n338) );
  INVX2 U447 ( .A(\regs_matrix[1][12] ), .Y(n339) );
  OAI22X1 U448 ( .A(\regs_matrix[5][12] ), .B(n433), .C(\regs_matrix[7][12] ), 
        .D(n422), .Y(n336) );
  NOR2X1 U449 ( .A(n340), .B(n341), .Y(n331) );
  OAI22X1 U450 ( .A(\regs_matrix[8][12] ), .B(n417), .C(\regs_matrix[10][12] ), 
        .D(n439), .Y(n341) );
  OAI22X1 U451 ( .A(\regs_matrix[12][12] ), .B(n442), .C(\regs_matrix[14][12] ), .D(n415), .Y(n340) );
  NOR2X1 U452 ( .A(n342), .B(n343), .Y(n330) );
  OAI21X1 U453 ( .A(\regs_matrix[11][12] ), .B(n434), .C(n344), .Y(n343) );
  AOI21X1 U454 ( .A(n92), .B(n345), .C(n115), .Y(n344) );
  INVX2 U455 ( .A(\regs_matrix[9][12] ), .Y(n345) );
  OAI22X1 U456 ( .A(\regs_matrix[13][12] ), .B(n433), .C(\regs_matrix[15][12] ), .D(n440), .Y(n342) );
  AOI22X1 U457 ( .A(n347), .B(n348), .C(n349), .D(n350), .Y(n346) );
  NOR2X1 U458 ( .A(n351), .B(n352), .Y(n350) );
  OAI22X1 U459 ( .A(outreg_data[13]), .B(n418), .C(\regs_matrix[2][13] ), .D(
        n429), .Y(n352) );
  OAI22X1 U460 ( .A(\regs_matrix[4][13] ), .B(n420), .C(\regs_matrix[6][13] ), 
        .D(n413), .Y(n351) );
  NOR2X1 U461 ( .A(n353), .B(n354), .Y(n349) );
  OAI21X1 U462 ( .A(\regs_matrix[3][13] ), .B(n434), .C(n355), .Y(n354) );
  AOI21X1 U463 ( .A(n438), .B(n356), .C(N13), .Y(n355) );
  INVX2 U464 ( .A(\regs_matrix[1][13] ), .Y(n356) );
  OAI22X1 U465 ( .A(\regs_matrix[5][13] ), .B(n432), .C(\regs_matrix[7][13] ), 
        .D(n422), .Y(n353) );
  NOR2X1 U466 ( .A(n357), .B(n358), .Y(n348) );
  OAI22X1 U467 ( .A(\regs_matrix[8][13] ), .B(n417), .C(\regs_matrix[10][13] ), 
        .D(n439), .Y(n358) );
  OAI22X1 U468 ( .A(\regs_matrix[12][13] ), .B(n442), .C(\regs_matrix[14][13] ), .D(n415), .Y(n357) );
  NOR2X1 U469 ( .A(n359), .B(n360), .Y(n347) );
  OAI21X1 U470 ( .A(\regs_matrix[11][13] ), .B(n434), .C(n361), .Y(n360) );
  AOI21X1 U471 ( .A(n92), .B(n362), .C(n115), .Y(n361) );
  INVX2 U472 ( .A(\regs_matrix[9][13] ), .Y(n362) );
  OAI22X1 U473 ( .A(\regs_matrix[13][13] ), .B(n433), .C(\regs_matrix[15][13] ), .D(n423), .Y(n359) );
  AOI22X1 U474 ( .A(n364), .B(n365), .C(n366), .D(n367), .Y(n363) );
  NOR2X1 U475 ( .A(n368), .B(n369), .Y(n367) );
  OAI22X1 U476 ( .A(outreg_data[14]), .B(n417), .C(\regs_matrix[2][14] ), .D(
        n429), .Y(n369) );
  OAI22X1 U477 ( .A(\regs_matrix[4][14] ), .B(n420), .C(\regs_matrix[6][14] ), 
        .D(n413), .Y(n368) );
  NOR2X1 U478 ( .A(n370), .B(n371), .Y(n366) );
  OAI21X1 U479 ( .A(\regs_matrix[3][14] ), .B(n434), .C(n372), .Y(n371) );
  AOI21X1 U480 ( .A(n438), .B(n373), .C(N13), .Y(n372) );
  INVX2 U481 ( .A(\regs_matrix[1][14] ), .Y(n373) );
  OAI22X1 U482 ( .A(\regs_matrix[5][14] ), .B(n433), .C(\regs_matrix[7][14] ), 
        .D(n422), .Y(n370) );
  NOR2X1 U483 ( .A(n374), .B(n375), .Y(n365) );
  OAI22X1 U484 ( .A(\regs_matrix[8][14] ), .B(n417), .C(\regs_matrix[10][14] ), 
        .D(n439), .Y(n375) );
  OAI22X1 U485 ( .A(\regs_matrix[12][14] ), .B(n442), .C(\regs_matrix[14][14] ), .D(n415), .Y(n374) );
  NOR2X1 U486 ( .A(n376), .B(n377), .Y(n364) );
  OAI21X1 U487 ( .A(\regs_matrix[11][14] ), .B(n434), .C(n378), .Y(n377) );
  AOI21X1 U488 ( .A(n92), .B(n379), .C(n115), .Y(n378) );
  INVX2 U489 ( .A(\regs_matrix[9][14] ), .Y(n379) );
  OAI22X1 U490 ( .A(\regs_matrix[13][14] ), .B(n433), .C(\regs_matrix[15][14] ), .D(n423), .Y(n376) );
  AOI22X1 U491 ( .A(n381), .B(n382), .C(n383), .D(n384), .Y(n380) );
  NOR2X1 U492 ( .A(n385), .B(n386), .Y(n384) );
  OAI22X1 U493 ( .A(outreg_data[15]), .B(n417), .C(\regs_matrix[2][15] ), .D(
        n429), .Y(n386) );
  OAI22X1 U494 ( .A(\regs_matrix[4][15] ), .B(n420), .C(\regs_matrix[6][15] ), 
        .D(n413), .Y(n385) );
  NOR2X1 U495 ( .A(n387), .B(n388), .Y(n383) );
  OAI21X1 U496 ( .A(\regs_matrix[3][15] ), .B(n434), .C(n389), .Y(n388) );
  AOI21X1 U497 ( .A(n90), .B(n390), .C(N13), .Y(n389) );
  INVX2 U498 ( .A(\regs_matrix[1][15] ), .Y(n390) );
  OAI22X1 U499 ( .A(\regs_matrix[5][15] ), .B(n433), .C(\regs_matrix[7][15] ), 
        .D(n422), .Y(n387) );
  NOR2X1 U500 ( .A(n391), .B(n392), .Y(n382) );
  OAI22X1 U501 ( .A(\regs_matrix[8][15] ), .B(n417), .C(\regs_matrix[10][15] ), 
        .D(n439), .Y(n392) );
  OAI22X1 U502 ( .A(\regs_matrix[12][15] ), .B(n442), .C(\regs_matrix[14][15] ), .D(n415), .Y(n391) );
  NOR2X1 U503 ( .A(n393), .B(n394), .Y(n381) );
  OAI21X1 U504 ( .A(\regs_matrix[11][15] ), .B(n434), .C(n395), .Y(n394) );
  AOI21X1 U505 ( .A(n92), .B(n396), .C(n115), .Y(n395) );
  INVX2 U506 ( .A(\regs_matrix[9][15] ), .Y(n396) );
  OAI22X1 U507 ( .A(\regs_matrix[13][15] ), .B(n433), .C(\regs_matrix[15][15] ), .D(n423), .Y(n393) );
  NOR2X1 U508 ( .A(n398), .B(n399), .Y(n110) );
  OAI21X1 U509 ( .A(outreg_data[16]), .B(n417), .C(n400), .Y(n399) );
  AOI21X1 U510 ( .A(n428), .B(n401), .C(N13), .Y(n400) );
  INVX2 U511 ( .A(\regs_matrix[2][16] ), .Y(n401) );
  OAI22X1 U512 ( .A(\regs_matrix[4][16] ), .B(n97), .C(\regs_matrix[6][16] ), 
        .D(n413), .Y(n398) );
  NOR2X1 U513 ( .A(n402), .B(n403), .Y(n111) );
  OAI22X1 U514 ( .A(\regs_matrix[3][16] ), .B(n434), .C(\regs_matrix[1][16] ), 
        .D(n437), .Y(n403) );
  OAI22X1 U515 ( .A(\regs_matrix[5][16] ), .B(n433), .C(\regs_matrix[7][16] ), 
        .D(n422), .Y(n402) );
  NOR3X1 U516 ( .A(n404), .B(n405), .C(n406), .Y(n112) );
  OAI22X1 U517 ( .A(\regs_matrix[10][16] ), .B(n439), .C(\regs_matrix[8][16] ), 
        .D(n417), .Y(n406) );
  NAND3X1 U518 ( .A(n407), .B(n93), .C(n409), .Y(n124) );
  NAND3X1 U519 ( .A(n96), .B(n93), .C(n409), .Y(n133) );
  NOR2X1 U520 ( .A(\regs_matrix[12][16] ), .B(n442), .Y(n405) );
  NAND3X1 U521 ( .A(n94), .B(n409), .C(n407), .Y(n125) );
  OAI22X1 U522 ( .A(\regs_matrix[9][16] ), .B(n437), .C(\regs_matrix[14][16] ), 
        .D(n415), .Y(n404) );
  NAND3X1 U523 ( .A(n94), .B(n96), .C(n409), .Y(n123) );
  NAND3X1 U524 ( .A(N10), .B(n408), .C(n407), .Y(n397) );
  NOR2X1 U525 ( .A(n410), .B(n411), .Y(n113) );
  OAI21X1 U526 ( .A(\regs_matrix[11][16] ), .B(n436), .C(N13), .Y(n411) );
  OAI22X1 U527 ( .A(\regs_matrix[15][16] ), .B(n423), .C(\regs_matrix[13][16] ), .D(n433), .Y(n410) );
  NAND3X1 U528 ( .A(N12), .B(N10), .C(n407), .Y(n134) );
  NAND2X1 U529 ( .A(N12), .B(n441), .Y(n128) );
  INVX8 U530 ( .A(n419), .Y(n420) );
  INVX8 U531 ( .A(n443), .Y(n435) );
  INVX2 U532 ( .A(n133), .Y(n426) );
  INVX4 U533 ( .A(n421), .Y(n422) );
  INVX4 U534 ( .A(n124), .Y(n416) );
  INVX1 U535 ( .A(n98), .Y(n425) );
  BUFX2 U536 ( .A(n446), .Y(n439) );
  INVX4 U537 ( .A(n421), .Y(n423) );
  BUFX2 U538 ( .A(n423), .Y(n440) );
  AND2X2 U539 ( .A(N10), .B(N11), .Y(n441) );
  INVX4 U540 ( .A(n116), .Y(r1_data[0]) );
  INVX4 U541 ( .A(n380), .Y(r1_data[15]) );
  BUFX2 U542 ( .A(n97), .Y(n442) );
  INVX4 U543 ( .A(n421), .Y(n424) );
  AND2X2 U544 ( .A(n441), .B(n93), .Y(n443) );
  INVX4 U545 ( .A(n363), .Y(r1_data[14]) );
  INVX4 U546 ( .A(n431), .Y(n432) );
  AOI22X1 U547 ( .A(n450), .B(n449), .C(n448), .D(n447), .Y(n451) );
  INVX2 U548 ( .A(n451), .Y(r2_data[16]) );
  NAND2X1 U549 ( .A(n454), .B(n455), .Y(n453) );
  NOR2X1 U550 ( .A(n457), .B(n456), .Y(n455) );
  OAI22X1 U551 ( .A(\regs_matrix[8][0] ), .B(n72), .C(\regs_matrix[10][0] ), 
        .D(n701), .Y(n457) );
  OAI22X1 U552 ( .A(\regs_matrix[12][0] ), .B(n704), .C(\regs_matrix[14][0] ), 
        .D(n64), .Y(n456) );
  NOR2X1 U553 ( .A(n462), .B(n463), .Y(n454) );
  OAI22X1 U554 ( .A(\regs_matrix[11][0] ), .B(n102), .C(\regs_matrix[9][0] ), 
        .D(n711), .Y(n463) );
  OAI22X1 U555 ( .A(\regs_matrix[13][0] ), .B(n95), .C(\regs_matrix[15][0] ), 
        .D(n15), .Y(n462) );
  NAND2X1 U556 ( .A(n467), .B(n466), .Y(n452) );
  NOR2X1 U557 ( .A(n468), .B(n469), .Y(n467) );
  OAI22X1 U558 ( .A(outreg_data[0]), .B(n73), .C(\regs_matrix[2][0] ), .D(n701), .Y(n469) );
  OAI22X1 U559 ( .A(\regs_matrix[4][0] ), .B(n704), .C(\regs_matrix[6][0] ), 
        .D(n63), .Y(n468) );
  NOR2X1 U560 ( .A(n470), .B(n471), .Y(n466) );
  OAI22X1 U561 ( .A(\regs_matrix[3][0] ), .B(n102), .C(\regs_matrix[1][0] ), 
        .D(n711), .Y(n471) );
  OAI22X1 U562 ( .A(\regs_matrix[5][0] ), .B(n713), .C(\regs_matrix[7][0] ), 
        .D(n16), .Y(n470) );
  MUX2X1 U563 ( .B(n472), .A(n473), .S(n716), .Y(r2_data[1]) );
  NAND2X1 U564 ( .A(n474), .B(n475), .Y(n473) );
  NOR2X1 U565 ( .A(n476), .B(n477), .Y(n475) );
  OAI22X1 U566 ( .A(\regs_matrix[8][1] ), .B(n73), .C(\regs_matrix[10][1] ), 
        .D(n701), .Y(n477) );
  OAI22X1 U567 ( .A(\regs_matrix[12][1] ), .B(n704), .C(\regs_matrix[14][1] ), 
        .D(n65), .Y(n476) );
  NOR2X1 U568 ( .A(n478), .B(n479), .Y(n474) );
  OAI22X1 U569 ( .A(\regs_matrix[11][1] ), .B(n100), .C(\regs_matrix[9][1] ), 
        .D(n711), .Y(n479) );
  OAI22X1 U570 ( .A(\regs_matrix[13][1] ), .B(n95), .C(\regs_matrix[15][1] ), 
        .D(n22), .Y(n478) );
  NAND2X1 U571 ( .A(n480), .B(n481), .Y(n472) );
  NOR2X1 U572 ( .A(n482), .B(n483), .Y(n481) );
  OAI22X1 U573 ( .A(outreg_data[1]), .B(n74), .C(\regs_matrix[2][1] ), .D(n701), .Y(n483) );
  OAI22X1 U574 ( .A(\regs_matrix[4][1] ), .B(n704), .C(\regs_matrix[6][1] ), 
        .D(n68), .Y(n482) );
  NOR2X1 U575 ( .A(n484), .B(n485), .Y(n480) );
  OAI22X1 U576 ( .A(\regs_matrix[3][1] ), .B(n100), .C(\regs_matrix[1][1] ), 
        .D(n711), .Y(n485) );
  OAI22X1 U577 ( .A(\regs_matrix[5][1] ), .B(n714), .C(\regs_matrix[7][1] ), 
        .D(n30), .Y(n484) );
  MUX2X1 U578 ( .B(n486), .A(n487), .S(n715), .Y(r2_data[2]) );
  NAND2X1 U579 ( .A(n488), .B(n489), .Y(n487) );
  NOR2X1 U580 ( .A(n490), .B(n491), .Y(n489) );
  OAI22X1 U581 ( .A(\regs_matrix[8][2] ), .B(n81), .C(\regs_matrix[10][2] ), 
        .D(n701), .Y(n491) );
  OAI22X1 U582 ( .A(\regs_matrix[12][2] ), .B(n704), .C(\regs_matrix[14][2] ), 
        .D(n62), .Y(n490) );
  NOR2X1 U583 ( .A(n492), .B(n493), .Y(n488) );
  OAI22X1 U584 ( .A(\regs_matrix[11][2] ), .B(n101), .C(\regs_matrix[9][2] ), 
        .D(n711), .Y(n493) );
  OAI22X1 U585 ( .A(\regs_matrix[13][2] ), .B(n95), .C(\regs_matrix[15][2] ), 
        .D(n31), .Y(n492) );
  NAND2X1 U586 ( .A(n494), .B(n495), .Y(n486) );
  NOR2X1 U587 ( .A(n496), .B(n497), .Y(n495) );
  OAI22X1 U588 ( .A(outreg_data[2]), .B(n78), .C(\regs_matrix[2][2] ), .D(n701), .Y(n497) );
  OAI22X1 U589 ( .A(\regs_matrix[4][2] ), .B(n704), .C(\regs_matrix[6][2] ), 
        .D(n59), .Y(n496) );
  NOR2X1 U590 ( .A(n498), .B(n499), .Y(n494) );
  OAI22X1 U591 ( .A(\regs_matrix[3][2] ), .B(n101), .C(\regs_matrix[1][2] ), 
        .D(n711), .Y(n499) );
  OAI22X1 U592 ( .A(\regs_matrix[5][2] ), .B(n714), .C(\regs_matrix[7][2] ), 
        .D(n26), .Y(n498) );
  MUX2X1 U593 ( .B(n500), .A(n501), .S(n716), .Y(r2_data[3]) );
  NAND2X1 U594 ( .A(n502), .B(n503), .Y(n501) );
  NOR2X1 U595 ( .A(n504), .B(n505), .Y(n503) );
  OAI22X1 U596 ( .A(\regs_matrix[8][3] ), .B(n75), .C(\regs_matrix[10][3] ), 
        .D(n701), .Y(n505) );
  OAI22X1 U597 ( .A(\regs_matrix[12][3] ), .B(n704), .C(\regs_matrix[14][3] ), 
        .D(n66), .Y(n504) );
  NOR2X1 U598 ( .A(n506), .B(n507), .Y(n502) );
  OAI22X1 U599 ( .A(\regs_matrix[11][3] ), .B(n101), .C(\regs_matrix[9][3] ), 
        .D(n711), .Y(n507) );
  OAI22X1 U600 ( .A(\regs_matrix[13][3] ), .B(n95), .C(\regs_matrix[15][3] ), 
        .D(n32), .Y(n506) );
  NAND2X1 U601 ( .A(n508), .B(n509), .Y(n500) );
  NOR2X1 U602 ( .A(n510), .B(n511), .Y(n509) );
  OAI22X1 U603 ( .A(outreg_data[3]), .B(n74), .C(\regs_matrix[2][3] ), .D(n701), .Y(n511) );
  OAI22X1 U604 ( .A(\regs_matrix[4][3] ), .B(n704), .C(\regs_matrix[6][3] ), 
        .D(n65), .Y(n510) );
  NOR2X1 U605 ( .A(n512), .B(n513), .Y(n508) );
  OAI22X1 U606 ( .A(\regs_matrix[3][3] ), .B(n101), .C(\regs_matrix[1][3] ), 
        .D(n711), .Y(n513) );
  OAI22X1 U607 ( .A(\regs_matrix[5][3] ), .B(n714), .C(\regs_matrix[7][3] ), 
        .D(n29), .Y(n512) );
  MUX2X1 U608 ( .B(n514), .A(n515), .S(n715), .Y(r2_data[4]) );
  NAND2X1 U609 ( .A(n516), .B(n517), .Y(n515) );
  NOR2X1 U610 ( .A(n518), .B(n519), .Y(n517) );
  OAI22X1 U611 ( .A(\regs_matrix[8][4] ), .B(n77), .C(\regs_matrix[10][4] ), 
        .D(n702), .Y(n519) );
  OAI22X1 U612 ( .A(\regs_matrix[12][4] ), .B(n705), .C(\regs_matrix[14][4] ), 
        .D(n63), .Y(n518) );
  NOR2X1 U613 ( .A(n521), .B(n520), .Y(n516) );
  OAI22X1 U614 ( .A(\regs_matrix[11][4] ), .B(n707), .C(\regs_matrix[9][4] ), 
        .D(n711), .Y(n521) );
  OAI22X1 U615 ( .A(\regs_matrix[13][4] ), .B(n714), .C(\regs_matrix[15][4] ), 
        .D(n49), .Y(n520) );
  NAND2X1 U616 ( .A(n523), .B(n522), .Y(n514) );
  NOR2X1 U617 ( .A(n524), .B(n525), .Y(n523) );
  OAI22X1 U618 ( .A(outreg_data[4]), .B(n76), .C(\regs_matrix[2][4] ), .D(n702), .Y(n525) );
  OAI22X1 U619 ( .A(\regs_matrix[4][4] ), .B(n705), .C(\regs_matrix[6][4] ), 
        .D(n69), .Y(n524) );
  NOR2X1 U620 ( .A(n526), .B(n527), .Y(n522) );
  OAI22X1 U621 ( .A(\regs_matrix[3][4] ), .B(n707), .C(\regs_matrix[1][4] ), 
        .D(n711), .Y(n527) );
  OAI22X1 U622 ( .A(\regs_matrix[5][4] ), .B(n714), .C(\regs_matrix[7][4] ), 
        .D(n48), .Y(n526) );
  MUX2X1 U623 ( .B(n528), .A(n529), .S(n716), .Y(r2_data[5]) );
  NAND2X1 U624 ( .A(n530), .B(n531), .Y(n529) );
  NOR2X1 U625 ( .A(n532), .B(n533), .Y(n531) );
  OAI22X1 U626 ( .A(\regs_matrix[8][5] ), .B(n82), .C(\regs_matrix[10][5] ), 
        .D(n702), .Y(n533) );
  OAI22X1 U627 ( .A(\regs_matrix[12][5] ), .B(n705), .C(\regs_matrix[14][5] ), 
        .D(n56), .Y(n532) );
  NOR2X1 U628 ( .A(n534), .B(n535), .Y(n530) );
  OAI22X1 U629 ( .A(\regs_matrix[11][5] ), .B(n707), .C(\regs_matrix[9][5] ), 
        .D(n711), .Y(n535) );
  OAI22X1 U630 ( .A(\regs_matrix[13][5] ), .B(n713), .C(\regs_matrix[15][5] ), 
        .D(n45), .Y(n534) );
  NAND2X1 U631 ( .A(n536), .B(n537), .Y(n528) );
  NOR2X1 U632 ( .A(n538), .B(n539), .Y(n537) );
  OAI22X1 U633 ( .A(outreg_data[5]), .B(n79), .C(\regs_matrix[2][5] ), .D(n702), .Y(n539) );
  OAI22X1 U634 ( .A(\regs_matrix[4][5] ), .B(n705), .C(\regs_matrix[6][5] ), 
        .D(n60), .Y(n538) );
  NOR2X1 U635 ( .A(n540), .B(n541), .Y(n536) );
  OAI22X1 U636 ( .A(\regs_matrix[3][5] ), .B(n707), .C(\regs_matrix[1][5] ), 
        .D(n711), .Y(n541) );
  OAI22X1 U637 ( .A(\regs_matrix[5][5] ), .B(n714), .C(\regs_matrix[7][5] ), 
        .D(n42), .Y(n540) );
  MUX2X1 U638 ( .B(n542), .A(n543), .S(n715), .Y(r2_data[6]) );
  NAND2X1 U639 ( .A(n544), .B(n545), .Y(n543) );
  NOR2X1 U640 ( .A(n546), .B(n547), .Y(n545) );
  OAI22X1 U641 ( .A(\regs_matrix[8][6] ), .B(n70), .C(\regs_matrix[10][6] ), 
        .D(n702), .Y(n547) );
  OAI22X1 U642 ( .A(\regs_matrix[12][6] ), .B(n705), .C(\regs_matrix[14][6] ), 
        .D(n69), .Y(n546) );
  NOR2X1 U643 ( .A(n548), .B(n549), .Y(n544) );
  OAI22X1 U644 ( .A(\regs_matrix[11][6] ), .B(n707), .C(\regs_matrix[9][6] ), 
        .D(n710), .Y(n549) );
  OAI22X1 U645 ( .A(\regs_matrix[13][6] ), .B(n95), .C(\regs_matrix[15][6] ), 
        .D(n38), .Y(n548) );
  NAND2X1 U646 ( .A(n550), .B(n551), .Y(n542) );
  NOR2X1 U647 ( .A(n552), .B(n553), .Y(n551) );
  OAI22X1 U648 ( .A(outreg_data[6]), .B(n76), .C(\regs_matrix[2][6] ), .D(n702), .Y(n553) );
  OAI22X1 U649 ( .A(\regs_matrix[4][6] ), .B(n705), .C(\regs_matrix[6][6] ), 
        .D(n66), .Y(n552) );
  NOR2X1 U650 ( .A(n554), .B(n555), .Y(n550) );
  OAI22X1 U651 ( .A(\regs_matrix[3][6] ), .B(n707), .C(\regs_matrix[1][6] ), 
        .D(n710), .Y(n555) );
  OAI22X1 U652 ( .A(\regs_matrix[5][6] ), .B(n714), .C(\regs_matrix[7][6] ), 
        .D(n39), .Y(n554) );
  MUX2X1 U653 ( .B(n556), .A(n557), .S(n716), .Y(r2_data[7]) );
  NAND2X1 U654 ( .A(n558), .B(n559), .Y(n557) );
  NOR2X1 U655 ( .A(n560), .B(n561), .Y(n559) );
  OAI22X1 U656 ( .A(\regs_matrix[8][7] ), .B(n83), .C(\regs_matrix[10][7] ), 
        .D(n702), .Y(n561) );
  OAI22X1 U657 ( .A(\regs_matrix[12][7] ), .B(n705), .C(\regs_matrix[14][7] ), 
        .D(n58), .Y(n560) );
  NOR2X1 U658 ( .A(n562), .B(n563), .Y(n558) );
  OAI22X1 U659 ( .A(\regs_matrix[11][7] ), .B(n707), .C(\regs_matrix[9][7] ), 
        .D(n710), .Y(n563) );
  OAI22X1 U660 ( .A(\regs_matrix[13][7] ), .B(n713), .C(\regs_matrix[15][7] ), 
        .D(n41), .Y(n562) );
  NAND2X1 U661 ( .A(n564), .B(n565), .Y(n556) );
  NOR2X1 U662 ( .A(n566), .B(n567), .Y(n565) );
  OAI22X1 U663 ( .A(outreg_data[7]), .B(n80), .C(\regs_matrix[2][7] ), .D(n702), .Y(n567) );
  OAI22X1 U664 ( .A(\regs_matrix[4][7] ), .B(n705), .C(\regs_matrix[6][7] ), 
        .D(n57), .Y(n566) );
  NOR2X1 U665 ( .A(n568), .B(n569), .Y(n564) );
  OAI22X1 U666 ( .A(\regs_matrix[3][7] ), .B(n707), .C(\regs_matrix[1][7] ), 
        .D(n710), .Y(n569) );
  OAI22X1 U667 ( .A(\regs_matrix[5][7] ), .B(n714), .C(\regs_matrix[7][7] ), 
        .D(n34), .Y(n568) );
  MUX2X1 U668 ( .B(n570), .A(n571), .S(n715), .Y(r2_data[8]) );
  NAND2X1 U669 ( .A(n572), .B(n573), .Y(n571) );
  NOR2X1 U670 ( .A(n574), .B(n575), .Y(n573) );
  OAI22X1 U671 ( .A(\regs_matrix[8][8] ), .B(n75), .C(\regs_matrix[10][8] ), 
        .D(n702), .Y(n575) );
  OAI22X1 U672 ( .A(\regs_matrix[12][8] ), .B(n705), .C(\regs_matrix[14][8] ), 
        .D(n68), .Y(n574) );
  NOR2X1 U673 ( .A(n576), .B(n577), .Y(n572) );
  OAI22X1 U674 ( .A(\regs_matrix[11][8] ), .B(n707), .C(\regs_matrix[9][8] ), 
        .D(n710), .Y(n577) );
  OAI22X1 U675 ( .A(\regs_matrix[13][8] ), .B(n713), .C(\regs_matrix[15][8] ), 
        .D(n18), .Y(n576) );
  NAND2X1 U676 ( .A(n578), .B(n579), .Y(n570) );
  NOR2X1 U677 ( .A(n580), .B(n581), .Y(n579) );
  OAI22X1 U678 ( .A(outreg_data[8]), .B(n72), .C(\regs_matrix[2][8] ), .D(n702), .Y(n581) );
  OAI22X1 U679 ( .A(\regs_matrix[4][8] ), .B(n705), .C(\regs_matrix[6][8] ), 
        .D(n67), .Y(n580) );
  NOR2X1 U680 ( .A(n582), .B(n583), .Y(n578) );
  OAI22X1 U681 ( .A(\regs_matrix[3][8] ), .B(n707), .C(\regs_matrix[1][8] ), 
        .D(n710), .Y(n583) );
  OAI22X1 U682 ( .A(\regs_matrix[5][8] ), .B(n95), .C(\regs_matrix[7][8] ), 
        .D(n17), .Y(n582) );
  MUX2X1 U683 ( .B(n584), .A(n585), .S(n716), .Y(r2_data[9]) );
  NAND2X1 U684 ( .A(n586), .B(n587), .Y(n585) );
  NOR2X1 U685 ( .A(n588), .B(n589), .Y(n587) );
  OAI22X1 U686 ( .A(\regs_matrix[8][9] ), .B(n84), .C(\regs_matrix[10][9] ), 
        .D(n702), .Y(n589) );
  OAI22X1 U687 ( .A(\regs_matrix[12][9] ), .B(n705), .C(\regs_matrix[14][9] ), 
        .D(n62), .Y(n588) );
  NOR2X1 U688 ( .A(n590), .B(n591), .Y(n586) );
  OAI22X1 U689 ( .A(\regs_matrix[11][9] ), .B(n707), .C(\regs_matrix[9][9] ), 
        .D(n710), .Y(n591) );
  OAI22X1 U690 ( .A(\regs_matrix[13][9] ), .B(n713), .C(\regs_matrix[15][9] ), 
        .D(n28), .Y(n590) );
  NAND2X1 U691 ( .A(n592), .B(n593), .Y(n584) );
  NOR2X1 U692 ( .A(n594), .B(n595), .Y(n593) );
  OAI22X1 U693 ( .A(outreg_data[9]), .B(n83), .C(\regs_matrix[2][9] ), .D(n702), .Y(n595) );
  OAI22X1 U694 ( .A(\regs_matrix[4][9] ), .B(n705), .C(\regs_matrix[6][9] ), 
        .D(n60), .Y(n594) );
  NOR2X1 U695 ( .A(n596), .B(n597), .Y(n592) );
  OAI22X1 U696 ( .A(\regs_matrix[3][9] ), .B(n707), .C(\regs_matrix[1][9] ), 
        .D(n710), .Y(n597) );
  OAI22X1 U697 ( .A(\regs_matrix[5][9] ), .B(n714), .C(\regs_matrix[7][9] ), 
        .D(n25), .Y(n596) );
  MUX2X1 U698 ( .B(n598), .A(n599), .S(n715), .Y(r2_data[10]) );
  NAND2X1 U699 ( .A(n600), .B(n601), .Y(n599) );
  NOR2X1 U700 ( .A(n602), .B(n603), .Y(n601) );
  OAI22X1 U701 ( .A(\regs_matrix[8][10] ), .B(n85), .C(\regs_matrix[10][10] ), 
        .D(n702), .Y(n603) );
  OAI22X1 U702 ( .A(\regs_matrix[12][10] ), .B(n705), .C(\regs_matrix[14][10] ), .D(n61), .Y(n602) );
  NOR2X1 U703 ( .A(n604), .B(n605), .Y(n600) );
  OAI22X1 U704 ( .A(\regs_matrix[11][10] ), .B(n707), .C(\regs_matrix[9][10] ), 
        .D(n710), .Y(n605) );
  OAI22X1 U705 ( .A(\regs_matrix[13][10] ), .B(n95), .C(\regs_matrix[15][10] ), 
        .D(n24), .Y(n604) );
  NAND2X1 U706 ( .A(n606), .B(n607), .Y(n598) );
  NOR2X1 U707 ( .A(n608), .B(n609), .Y(n607) );
  OAI22X1 U708 ( .A(outreg_data[10]), .B(n81), .C(\regs_matrix[2][10] ), .D(
        n702), .Y(n609) );
  OAI22X1 U709 ( .A(\regs_matrix[4][10] ), .B(n705), .C(\regs_matrix[6][10] ), 
        .D(n59), .Y(n608) );
  NOR2X1 U710 ( .A(n610), .B(n611), .Y(n606) );
  OAI22X1 U711 ( .A(\regs_matrix[3][10] ), .B(n102), .C(\regs_matrix[1][10] ), 
        .D(n710), .Y(n611) );
  OAI22X1 U712 ( .A(\regs_matrix[5][10] ), .B(n95), .C(\regs_matrix[7][10] ), 
        .D(n21), .Y(n610) );
  MUX2X1 U713 ( .B(n612), .A(n613), .S(n716), .Y(r2_data[11]) );
  NAND2X1 U714 ( .A(n614), .B(n615), .Y(n613) );
  NOR2X1 U715 ( .A(n616), .B(n617), .Y(n615) );
  OAI22X1 U716 ( .A(\regs_matrix[8][11] ), .B(n86), .C(\regs_matrix[10][11] ), 
        .D(n702), .Y(n617) );
  OAI22X1 U717 ( .A(\regs_matrix[12][11] ), .B(n705), .C(\regs_matrix[14][11] ), .D(n65), .Y(n616) );
  NOR2X1 U718 ( .A(n618), .B(n619), .Y(n614) );
  OAI22X1 U719 ( .A(\regs_matrix[11][11] ), .B(n102), .C(\regs_matrix[9][11] ), 
        .D(n710), .Y(n619) );
  OAI22X1 U720 ( .A(\regs_matrix[13][11] ), .B(n713), .C(\regs_matrix[15][11] ), .D(n27), .Y(n618) );
  NAND2X1 U721 ( .A(n620), .B(n621), .Y(n612) );
  NOR2X1 U722 ( .A(n622), .B(n623), .Y(n621) );
  OAI22X1 U723 ( .A(outreg_data[11]), .B(n70), .C(\regs_matrix[2][11] ), .D(
        n702), .Y(n623) );
  OAI22X1 U724 ( .A(\regs_matrix[4][11] ), .B(n705), .C(\regs_matrix[6][11] ), 
        .D(n63), .Y(n622) );
  NOR2X1 U725 ( .A(n624), .B(n625), .Y(n620) );
  OAI22X1 U726 ( .A(\regs_matrix[3][11] ), .B(n102), .C(\regs_matrix[1][11] ), 
        .D(n710), .Y(n625) );
  OAI22X1 U727 ( .A(\regs_matrix[5][11] ), .B(n714), .C(\regs_matrix[7][11] ), 
        .D(n23), .Y(n624) );
  MUX2X1 U728 ( .B(n626), .A(n627), .S(n715), .Y(r2_data[12]) );
  NAND2X1 U729 ( .A(n628), .B(n629), .Y(n627) );
  NOR2X1 U730 ( .A(n630), .B(n631), .Y(n629) );
  OAI22X1 U731 ( .A(\regs_matrix[8][12] ), .B(n87), .C(\regs_matrix[10][12] ), 
        .D(n702), .Y(n631) );
  OAI22X1 U732 ( .A(\regs_matrix[12][12] ), .B(n705), .C(\regs_matrix[14][12] ), .D(n66), .Y(n630) );
  NOR2X1 U733 ( .A(n632), .B(n633), .Y(n628) );
  OAI22X1 U734 ( .A(\regs_matrix[11][12] ), .B(n101), .C(\regs_matrix[9][12] ), 
        .D(n710), .Y(n633) );
  OAI22X1 U735 ( .A(\regs_matrix[13][12] ), .B(n714), .C(\regs_matrix[15][12] ), .D(n20), .Y(n632) );
  NAND2X1 U736 ( .A(n634), .B(n635), .Y(n626) );
  NOR2X1 U737 ( .A(n636), .B(n637), .Y(n635) );
  OAI22X1 U738 ( .A(outreg_data[12]), .B(n71), .C(\regs_matrix[2][12] ), .D(
        n702), .Y(n637) );
  OAI22X1 U739 ( .A(\regs_matrix[4][12] ), .B(n705), .C(\regs_matrix[6][12] ), 
        .D(n64), .Y(n636) );
  NOR2X1 U740 ( .A(n638), .B(n639), .Y(n634) );
  OAI22X1 U741 ( .A(\regs_matrix[3][12] ), .B(n101), .C(\regs_matrix[1][12] ), 
        .D(n710), .Y(n639) );
  OAI22X1 U742 ( .A(\regs_matrix[5][12] ), .B(n714), .C(\regs_matrix[7][12] ), 
        .D(n19), .Y(n638) );
  MUX2X1 U743 ( .B(n640), .A(n641), .S(n716), .Y(r2_data[13]) );
  NAND2X1 U744 ( .A(n642), .B(n643), .Y(n641) );
  NOR2X1 U745 ( .A(n644), .B(n645), .Y(n643) );
  OAI22X1 U746 ( .A(\regs_matrix[8][13] ), .B(n82), .C(\regs_matrix[10][13] ), 
        .D(n702), .Y(n645) );
  OAI22X1 U747 ( .A(\regs_matrix[12][13] ), .B(n705), .C(\regs_matrix[14][13] ), .D(n57), .Y(n644) );
  NOR2X1 U748 ( .A(n646), .B(n647), .Y(n642) );
  OAI22X1 U749 ( .A(\regs_matrix[11][13] ), .B(n102), .C(\regs_matrix[9][13] ), 
        .D(n710), .Y(n647) );
  OAI22X1 U750 ( .A(\regs_matrix[13][13] ), .B(n95), .C(\regs_matrix[15][13] ), 
        .D(n46), .Y(n646) );
  NAND2X1 U751 ( .A(n648), .B(n649), .Y(n640) );
  NOR2X1 U752 ( .A(n650), .B(n651), .Y(n649) );
  OAI22X1 U753 ( .A(outreg_data[13]), .B(n78), .C(\regs_matrix[2][13] ), .D(
        n702), .Y(n651) );
  OAI22X1 U754 ( .A(\regs_matrix[4][13] ), .B(n705), .C(\regs_matrix[6][13] ), 
        .D(n56), .Y(n650) );
  NOR2X1 U755 ( .A(n652), .B(n653), .Y(n648) );
  OAI22X1 U756 ( .A(\regs_matrix[3][13] ), .B(n102), .C(\regs_matrix[1][13] ), 
        .D(n710), .Y(n653) );
  OAI22X1 U757 ( .A(\regs_matrix[5][13] ), .B(n714), .C(\regs_matrix[7][13] ), 
        .D(n43), .Y(n652) );
  MUX2X1 U758 ( .B(n654), .A(n655), .S(n715), .Y(r2_data[14]) );
  NAND2X1 U759 ( .A(n656), .B(n657), .Y(n655) );
  NOR2X1 U760 ( .A(n658), .B(n659), .Y(n657) );
  OAI22X1 U761 ( .A(\regs_matrix[8][14] ), .B(n71), .C(\regs_matrix[10][14] ), 
        .D(n702), .Y(n659) );
  OAI22X1 U762 ( .A(\regs_matrix[12][14] ), .B(n705), .C(\regs_matrix[14][14] ), .D(n67), .Y(n658) );
  NOR2X1 U763 ( .A(n660), .B(n661), .Y(n656) );
  OAI22X1 U764 ( .A(\regs_matrix[11][14] ), .B(n101), .C(\regs_matrix[9][14] ), 
        .D(n710), .Y(n661) );
  OAI22X1 U765 ( .A(\regs_matrix[13][14] ), .B(n713), .C(\regs_matrix[15][14] ), .D(n33), .Y(n660) );
  NAND2X1 U766 ( .A(n662), .B(n663), .Y(n654) );
  NOR2X1 U767 ( .A(n664), .B(n665), .Y(n663) );
  OAI22X1 U768 ( .A(outreg_data[14]), .B(n77), .C(\regs_matrix[2][14] ), .D(
        n702), .Y(n665) );
  OAI22X1 U769 ( .A(\regs_matrix[4][14] ), .B(n705), .C(\regs_matrix[6][14] ), 
        .D(n64), .Y(n664) );
  NOR2X1 U770 ( .A(n666), .B(n667), .Y(n662) );
  OAI22X1 U771 ( .A(\regs_matrix[3][14] ), .B(n101), .C(\regs_matrix[1][14] ), 
        .D(n710), .Y(n667) );
  OAI22X1 U772 ( .A(\regs_matrix[5][14] ), .B(n714), .C(\regs_matrix[7][14] ), 
        .D(n40), .Y(n666) );
  NOR2X1 U773 ( .A(n670), .B(n671), .Y(n669) );
  OAI22X1 U774 ( .A(\regs_matrix[8][15] ), .B(n79), .C(\regs_matrix[10][15] ), 
        .D(n702), .Y(n671) );
  OAI22X1 U775 ( .A(\regs_matrix[12][15] ), .B(n705), .C(\regs_matrix[14][15] ), .D(n61), .Y(n670) );
  NOR2X1 U776 ( .A(n672), .B(n673), .Y(n668) );
  OAI22X1 U777 ( .A(\regs_matrix[11][15] ), .B(n101), .C(\regs_matrix[9][15] ), 
        .D(n710), .Y(n673) );
  OAI22X1 U778 ( .A(\regs_matrix[13][15] ), .B(n713), .C(\regs_matrix[15][15] ), .D(n47), .Y(n672) );
  NOR2X1 U779 ( .A(n676), .B(n677), .Y(n675) );
  OAI22X1 U780 ( .A(outreg_data[15]), .B(n80), .C(\regs_matrix[2][15] ), .D(
        n702), .Y(n677) );
  OAI22X1 U781 ( .A(\regs_matrix[4][15] ), .B(n705), .C(\regs_matrix[6][15] ), 
        .D(n58), .Y(n676) );
  NOR2X1 U782 ( .A(n678), .B(n679), .Y(n674) );
  OAI22X1 U783 ( .A(\regs_matrix[3][15] ), .B(n102), .C(\regs_matrix[1][15] ), 
        .D(n710), .Y(n679) );
  OAI22X1 U784 ( .A(\regs_matrix[5][15] ), .B(n713), .C(\regs_matrix[7][15] ), 
        .D(n44), .Y(n678) );
  NOR2X1 U785 ( .A(n680), .B(n681), .Y(n447) );
  OAI21X1 U786 ( .A(\regs_matrix[6][16] ), .B(n68), .C(n682), .Y(n681) );
  AOI22X1 U787 ( .A(n700), .B(n401), .C(n88), .D(n761), .Y(n682) );
  OAI21X1 U788 ( .A(\regs_matrix[4][16] ), .B(n705), .C(n717), .Y(n680) );
  NOR2X1 U789 ( .A(n683), .B(n684), .Y(n448) );
  OAI22X1 U790 ( .A(\regs_matrix[3][16] ), .B(n100), .C(\regs_matrix[1][16] ), 
        .D(n710), .Y(n684) );
  OAI22X1 U791 ( .A(\regs_matrix[5][16] ), .B(n713), .C(\regs_matrix[7][16] ), 
        .D(n51), .Y(n683) );
  NOR2X1 U792 ( .A(n685), .B(n686), .Y(n449) );
  OAI21X1 U793 ( .A(\regs_matrix[12][16] ), .B(n705), .C(n687), .Y(n686) );
  AOI22X1 U794 ( .A(n700), .B(n688), .C(n88), .D(n689), .Y(n687) );
  INVX2 U795 ( .A(\regs_matrix[8][16] ), .Y(n689) );
  NAND3X1 U796 ( .A(n692), .B(n691), .C(n690), .Y(n458) );
  INVX2 U797 ( .A(\regs_matrix[10][16] ), .Y(n688) );
  NAND3X1 U798 ( .A(N15), .B(n691), .C(n692), .Y(n459) );
  NAND3X1 U799 ( .A(N16), .B(n690), .C(n692), .Y(n460) );
  OAI22X1 U800 ( .A(\regs_matrix[9][16] ), .B(n710), .C(\regs_matrix[14][16] ), 
        .D(n67), .Y(n685) );
  NAND3X1 U801 ( .A(N16), .B(N15), .C(n692), .Y(n461) );
  INVX2 U802 ( .A(N14), .Y(n692) );
  NAND3X1 U803 ( .A(N14), .B(n691), .C(n690), .Y(n464) );
  NOR2X1 U804 ( .A(n693), .B(n694), .Y(n450) );
  OAI21X1 U805 ( .A(\regs_matrix[11][16] ), .B(n101), .C(n715), .Y(n694) );
  INVX2 U806 ( .A(N16), .Y(n691) );
  OAI22X1 U807 ( .A(\regs_matrix[15][16] ), .B(n50), .C(\regs_matrix[13][16] ), 
        .D(n713), .Y(n693) );
  INVX2 U808 ( .A(N15), .Y(n690) );
  INVX4 U809 ( .A(w_data[8]), .Y(n740) );
  INVX4 U810 ( .A(w_data[9]), .Y(n742) );
  INVX4 U811 ( .A(w_data[14]), .Y(n755) );
  INVX4 U812 ( .A(w_data[11]), .Y(n747) );
  INVX4 U813 ( .A(w_data[12]), .Y(n750) );
  INVX4 U814 ( .A(w_data[7]), .Y(n738) );
  INVX4 U815 ( .A(w_data[13]), .Y(n753) );
  INVX4 U816 ( .A(w_data[15]), .Y(n758) );
  INVX8 U817 ( .A(n740), .Y(n741) );
  INVX8 U818 ( .A(n742), .Y(n743) );
  INVX8 U819 ( .A(n758), .Y(n759) );
  INVX2 U820 ( .A(w_en), .Y(n770) );
  INVX2 U821 ( .A(w_sel[3]), .Y(n771) );
  INVX2 U822 ( .A(w_sel[1]), .Y(n772) );
  INVX2 U823 ( .A(w_sel[2]), .Y(n773) );
endmodule


module datapath ( clk, n_reset, op, src1, src2, dest, ext_data1, ext_data2, 
        outreg_data, overflow );
  input [2:0] op;
  input [3:0] src1;
  input [3:0] src2;
  input [3:0] dest;
  input [15:0] ext_data1;
  input [15:0] ext_data2;
  output [16:0] outreg_data;
  input clk, n_reset;
  output overflow;
  wire   w_en, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, n13, n14,
         n15, n16, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n33, n34, n35, n36;
  wire   [1:0] w_data_sel;
  wire   [1:0] alu_op;
  wire   [16:0] src1_data;
  wire   [16:0] src2_data;
  wire   [16:0] alu_result;
  wire   [16:0] dest_data;

  datapath_decode DEC ( .op(op), .w_en(w_en), .w_data_sel(w_data_sel), 
        .alu_op(alu_op) );
  alu CORE ( .src1_data(src1_data), .src2_data(src2_data), .alu_op(alu_op), 
        .result(alu_result), .overflow(overflow) );
  register_file RF ( .clk(clk), .n_reset(n_reset), .w_en(w_en), .r1_sel(src1), 
        .r2_sel(src2), .w_sel(dest), .w_data(dest_data), .r1_data(src1_data), 
        .r2_data(src2_data), .outreg_data(outreg_data) );
  INVX2 U2 ( .A(w_data_sel[1]), .Y(n36) );
  AND2X2 U3 ( .A(n36), .B(n3), .Y(n1) );
  AND2X2 U4 ( .A(w_data_sel[0]), .B(n36), .Y(n2) );
  AND2X2 U5 ( .A(alu_result[16]), .B(w_data_sel[1]), .Y(dest_data[16]) );
  INVX2 U6 ( .A(alu_result[15]), .Y(n5) );
  INVX2 U7 ( .A(w_data_sel[0]), .Y(n3) );
  AOI22X1 U8 ( .A(ext_data2[15]), .B(n2), .C(ext_data1[15]), .D(n1), .Y(n4) );
  OAI21X1 U9 ( .A(n36), .B(n5), .C(n4), .Y(dest_data[15]) );
  INVX2 U10 ( .A(alu_result[14]), .Y(n7) );
  AOI22X1 U11 ( .A(ext_data2[14]), .B(n2), .C(ext_data1[14]), .D(n1), .Y(n6)
         );
  OAI21X1 U12 ( .A(n36), .B(n7), .C(n6), .Y(dest_data[14]) );
  INVX2 U13 ( .A(alu_result[13]), .Y(n9) );
  AOI22X1 U14 ( .A(ext_data2[13]), .B(n2), .C(ext_data1[13]), .D(n1), .Y(n8)
         );
  OAI21X1 U15 ( .A(n36), .B(n9), .C(n8), .Y(dest_data[13]) );
  INVX2 U16 ( .A(alu_result[12]), .Y(n11) );
  AOI22X1 U17 ( .A(ext_data2[12]), .B(n2), .C(ext_data1[12]), .D(n1), .Y(n10)
         );
  OAI21X1 U18 ( .A(n36), .B(n11), .C(n10), .Y(dest_data[12]) );
  INVX2 U19 ( .A(alu_result[11]), .Y(n13) );
  AOI22X1 U20 ( .A(ext_data2[11]), .B(n2), .C(ext_data1[11]), .D(n1), .Y(n12)
         );
  OAI21X1 U21 ( .A(n36), .B(n13), .C(n12), .Y(dest_data[11]) );
  INVX2 U22 ( .A(alu_result[10]), .Y(n15) );
  AOI22X1 U23 ( .A(ext_data2[10]), .B(n2), .C(ext_data1[10]), .D(n1), .Y(n14)
         );
  OAI21X1 U24 ( .A(n36), .B(n15), .C(n14), .Y(dest_data[10]) );
  INVX2 U25 ( .A(alu_result[9]), .Y(n17) );
  AOI22X1 U26 ( .A(ext_data2[9]), .B(n2), .C(ext_data1[9]), .D(n1), .Y(n16) );
  OAI21X1 U27 ( .A(n36), .B(n17), .C(n16), .Y(dest_data[9]) );
  INVX2 U28 ( .A(alu_result[8]), .Y(n19) );
  AOI22X1 U29 ( .A(ext_data2[8]), .B(n2), .C(ext_data1[8]), .D(n1), .Y(n18) );
  OAI21X1 U30 ( .A(n36), .B(n19), .C(n18), .Y(dest_data[8]) );
  INVX2 U31 ( .A(alu_result[7]), .Y(n21) );
  AOI22X1 U32 ( .A(ext_data2[7]), .B(n2), .C(ext_data1[7]), .D(n1), .Y(n20) );
  OAI21X1 U33 ( .A(n36), .B(n21), .C(n20), .Y(dest_data[7]) );
  INVX2 U34 ( .A(alu_result[6]), .Y(n23) );
  AOI22X1 U35 ( .A(ext_data2[6]), .B(n2), .C(ext_data1[6]), .D(n1), .Y(n22) );
  OAI21X1 U36 ( .A(n36), .B(n23), .C(n22), .Y(dest_data[6]) );
  INVX2 U37 ( .A(alu_result[5]), .Y(n25) );
  AOI22X1 U38 ( .A(ext_data2[5]), .B(n2), .C(ext_data1[5]), .D(n1), .Y(n24) );
  OAI21X1 U39 ( .A(n36), .B(n25), .C(n24), .Y(dest_data[5]) );
  INVX2 U40 ( .A(alu_result[4]), .Y(n27) );
  AOI22X1 U41 ( .A(ext_data2[4]), .B(n2), .C(ext_data1[4]), .D(n1), .Y(n26) );
  OAI21X1 U42 ( .A(n36), .B(n27), .C(n26), .Y(dest_data[4]) );
  INVX2 U43 ( .A(alu_result[3]), .Y(n29) );
  AOI22X1 U44 ( .A(ext_data2[3]), .B(n2), .C(ext_data1[3]), .D(n1), .Y(n28) );
  OAI21X1 U45 ( .A(n36), .B(n29), .C(n28), .Y(dest_data[3]) );
  INVX2 U46 ( .A(alu_result[2]), .Y(n31) );
  AOI22X1 U47 ( .A(ext_data2[2]), .B(n2), .C(ext_data1[2]), .D(n1), .Y(n30) );
  OAI21X1 U48 ( .A(n36), .B(n31), .C(n30), .Y(dest_data[2]) );
  INVX2 U49 ( .A(alu_result[1]), .Y(n33) );
  AOI22X1 U50 ( .A(ext_data2[1]), .B(n2), .C(ext_data1[1]), .D(n1), .Y(n32) );
  OAI21X1 U51 ( .A(n36), .B(n33), .C(n32), .Y(dest_data[1]) );
  INVX2 U52 ( .A(alu_result[0]), .Y(n35) );
  AOI22X1 U53 ( .A(ext_data2[0]), .B(n2), .C(ext_data1[0]), .D(n1), .Y(n34) );
  OAI21X1 U54 ( .A(n36), .B(n35), .C(n34), .Y(dest_data[0]) );
endmodule


module flex_counter_NUM_CNT_BITS10_DW01_inc_0 ( A, SUM );
  input [10:0] A;
  output [10:0] SUM;

  wire   [10:2] carry;

  HAX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .YC(SUM[10]), .YS(SUM[9]) );
  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
endmodule


module flex_counter_NUM_CNT_BITS10_DW01_inc_1 ( A, SUM );
  input [9:0] A;
  output [9:0] SUM;

  wire   [9:2] carry;

  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  XOR2X1 U1 ( .A(carry[9]), .B(A[9]), .Y(SUM[9]) );
endmodule


module flex_counter_NUM_CNT_BITS10 ( clk, n_rst, clear, count_enable, 
        rollover_val, count_out, rollover_flag );
  input [9:0] rollover_val;
  output [9:0] count_out;
  input clk, n_rst, clear, count_enable;
  output rollover_flag;
  wire   next_roll_flag, N6, N7, N8, N9, N10, N11, N12, N13, N14, N15, N16,
         N17, N18, N19, N20, N21, N22, N23, N24, N25, n43, n44, n45, n46, n47,
         n48, n49, n50, n51, n52, n53, n54, n55, n56, n57, n58, n59, n60, n61,
         n62, n63, n64, n65, n66, n67, n68, n69, n70, n71, n72, n73, n74, n75,
         n76, n77, n78, n79, n80, n81, n82, n83, n84, n85, n86, n87, n88, n89,
         n90, n91, n92, n93, n94, n95, n96, n97, n98, n99, n100, n101, n102,
         n103, n104, n105, n106, n107, n108, n109, n110, n1, n2, n3, n4, n6,
         n7, n8, n9, n10, n22, n23, n24, n25, n26, n27, n28, n29, n30, n31,
         n32, n33;
  wire   SYNOPSYS_UNCONNECTED__0;

  DFFSR \curr_count_reg[0]  ( .D(n110), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[0]) );
  DFFSR \curr_count_reg[8]  ( .D(n102), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[8]) );
  DFFSR \curr_count_reg[7]  ( .D(n103), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[7]) );
  DFFSR \curr_count_reg[6]  ( .D(n104), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[6]) );
  DFFSR \curr_count_reg[5]  ( .D(n105), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[5]) );
  DFFSR \curr_count_reg[4]  ( .D(n106), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[4]) );
  DFFSR \curr_count_reg[3]  ( .D(n107), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[3]) );
  DFFSR \curr_count_reg[2]  ( .D(n108), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[2]) );
  DFFSR \curr_count_reg[1]  ( .D(n109), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[1]) );
  DFFSR \curr_count_reg[9]  ( .D(n101), .CLK(clk), .R(n_rst), .S(1'b1), .Q(
        count_out[9]) );
  DFFSR curr_roll_flag_reg ( .D(next_roll_flag), .CLK(clk), .R(n_rst), .S(1'b1), .Q(rollover_flag) );
  AND2X2 U15 ( .A(n50), .B(n51), .Y(n46) );
  NOR2X1 U37 ( .A(n43), .B(n44), .Y(next_roll_flag) );
  NAND3X1 U38 ( .A(n45), .B(n46), .C(n47), .Y(n44) );
  NOR2X1 U39 ( .A(n48), .B(n49), .Y(n47) );
  OAI21X1 U40 ( .A(N9), .B(n33), .C(count_enable), .Y(n49) );
  OAI22X1 U41 ( .A(N8), .B(n32), .C(N7), .D(n28), .Y(n48) );
  OAI21X1 U42 ( .A(n52), .B(n53), .C(n54), .Y(n51) );
  OAI22X1 U43 ( .A(rollover_val[4]), .B(n22), .C(rollover_val[3]), .D(n23), 
        .Y(n53) );
  OAI21X1 U44 ( .A(rollover_val[2]), .B(n24), .C(n55), .Y(n52) );
  AOI22X1 U45 ( .A(rollover_val[0]), .B(count_out[0]), .C(N6), .D(n27), .Y(n55) );
  OAI21X1 U46 ( .A(n56), .B(n57), .C(n4), .Y(n50) );
  NAND2X1 U47 ( .A(n27), .B(n28), .Y(n57) );
  NAND2X1 U48 ( .A(n32), .B(n33), .Y(n56) );
  AOI22X1 U49 ( .A(n58), .B(n26), .C(rollover_val[1]), .D(n25), .Y(n45) );
  NAND3X1 U50 ( .A(n59), .B(n60), .C(n61), .Y(n43) );
  NOR2X1 U51 ( .A(n62), .B(n63), .Y(n61) );
  OAI21X1 U52 ( .A(N10), .B(n29), .C(n64), .Y(n63) );
  OAI21X1 U53 ( .A(n31), .B(n65), .C(n4), .Y(n64) );
  NAND2X1 U54 ( .A(n29), .B(n30), .Y(n65) );
  NOR3X1 U55 ( .A(rollover_val[8]), .B(rollover_val[9]), .C(rollover_val[7]), 
        .Y(n66) );
  NAND2X1 U56 ( .A(n67), .B(n2), .Y(n62) );
  OAI21X1 U57 ( .A(n68), .B(n69), .C(n54), .Y(n67) );
  OAI22X1 U58 ( .A(rollover_val[9]), .B(n6), .C(rollover_val[8]), .D(n7), .Y(
        n69) );
  OAI21X1 U59 ( .A(rollover_val[7]), .B(n8), .C(n70), .Y(n68) );
  AOI22X1 U60 ( .A(N10), .B(n29), .C(N11), .D(n30), .Y(n70) );
  AOI22X1 U61 ( .A(rollover_val[6]), .B(n9), .C(rollover_val[7]), .D(n8), .Y(
        n60) );
  AOI22X1 U62 ( .A(rollover_val[8]), .B(n7), .C(rollover_val[9]), .D(n6), .Y(
        n59) );
  OAI21X1 U63 ( .A(n6), .B(n71), .C(n72), .Y(n101) );
  NAND2X1 U64 ( .A(count_out[9]), .B(n1), .Y(n72) );
  OAI21X1 U65 ( .A(n7), .B(n71), .C(n74), .Y(n102) );
  NAND2X1 U66 ( .A(count_out[8]), .B(n1), .Y(n74) );
  OAI21X1 U67 ( .A(n8), .B(n71), .C(n75), .Y(n103) );
  NAND2X1 U68 ( .A(count_out[7]), .B(n1), .Y(n75) );
  OAI21X1 U69 ( .A(n9), .B(n71), .C(n76), .Y(n104) );
  NAND2X1 U70 ( .A(count_out[6]), .B(n1), .Y(n76) );
  OAI21X1 U71 ( .A(n10), .B(n71), .C(n77), .Y(n105) );
  NAND2X1 U72 ( .A(count_out[5]), .B(n1), .Y(n77) );
  OAI21X1 U73 ( .A(n22), .B(n71), .C(n78), .Y(n106) );
  NAND2X1 U74 ( .A(count_out[4]), .B(n1), .Y(n78) );
  OAI21X1 U75 ( .A(n23), .B(n71), .C(n79), .Y(n107) );
  NAND2X1 U76 ( .A(count_out[3]), .B(n1), .Y(n79) );
  OAI21X1 U77 ( .A(n24), .B(n71), .C(n80), .Y(n108) );
  NAND2X1 U78 ( .A(count_out[2]), .B(n1), .Y(n80) );
  OAI21X1 U79 ( .A(n25), .B(n71), .C(n81), .Y(n109) );
  NAND2X1 U80 ( .A(count_out[1]), .B(n1), .Y(n81) );
  NAND3X1 U81 ( .A(n54), .B(n2), .C(n3), .Y(n71) );
  OAI21X1 U82 ( .A(n1), .B(n82), .C(n83), .Y(n110) );
  NAND2X1 U83 ( .A(count_out[0]), .B(n1), .Y(n83) );
  NAND2X1 U84 ( .A(n58), .B(n2), .Y(n82) );
  NAND2X1 U85 ( .A(count_out[0]), .B(n54), .Y(n58) );
  NAND3X1 U86 ( .A(n84), .B(n85), .C(n86), .Y(n54) );
  NOR2X1 U87 ( .A(n87), .B(n88), .Y(n86) );
  NAND3X1 U88 ( .A(n89), .B(n90), .C(n91), .Y(n88) );
  XNOR2X1 U89 ( .A(N8), .B(N18), .Y(n91) );
  XNOR2X1 U90 ( .A(N13), .B(N23), .Y(n90) );
  XNOR2X1 U91 ( .A(N10), .B(N20), .Y(n89) );
  NAND2X1 U92 ( .A(n92), .B(n93), .Y(n87) );
  XNOR2X1 U93 ( .A(N14), .B(N24), .Y(n93) );
  NOR2X1 U94 ( .A(N25), .B(n94), .Y(n92) );
  XNOR2X1 U95 ( .A(N22), .B(n8), .Y(n94) );
  NOR2X1 U96 ( .A(n95), .B(n96), .Y(n85) );
  NAND2X1 U97 ( .A(n97), .B(n98), .Y(n96) );
  XNOR2X1 U98 ( .A(N9), .B(N19), .Y(n98) );
  XNOR2X1 U99 ( .A(N11), .B(N21), .Y(n97) );
  XNOR2X1 U100 ( .A(n24), .B(N17), .Y(n95) );
  NOR2X1 U101 ( .A(n99), .B(n100), .Y(n84) );
  XNOR2X1 U102 ( .A(count_out[0]), .B(N15), .Y(n100) );
  XNOR2X1 U103 ( .A(n25), .B(N16), .Y(n99) );
  NOR2X1 U104 ( .A(count_enable), .B(clear), .Y(n73) );
  flex_counter_NUM_CNT_BITS10_DW01_inc_0 add_62 ( .A({1'b0, rollover_val}), 
        .SUM({N25, N24, N23, N22, N21, N20, N19, N18, N17, N16, N15}) );
  flex_counter_NUM_CNT_BITS10_DW01_inc_1 add_60 ( .A(count_out), .SUM({N14, 
        N13, N12, N11, N10, N9, N8, N7, N6, SYNOPSYS_UNCONNECTED__0}) );
  BUFX2 U16 ( .A(n73), .Y(n1) );
  INVX2 U17 ( .A(clear), .Y(n2) );
  INVX2 U18 ( .A(n1), .Y(n3) );
  INVX2 U19 ( .A(n54), .Y(n4) );
  INVX2 U20 ( .A(N14), .Y(n6) );
  INVX2 U21 ( .A(N13), .Y(n7) );
  INVX2 U22 ( .A(N12), .Y(n8) );
  INVX2 U23 ( .A(N11), .Y(n9) );
  INVX2 U24 ( .A(N10), .Y(n10) );
  INVX2 U25 ( .A(N9), .Y(n22) );
  INVX2 U26 ( .A(N8), .Y(n23) );
  INVX2 U27 ( .A(N7), .Y(n24) );
  INVX2 U28 ( .A(N6), .Y(n25) );
  INVX2 U29 ( .A(rollover_val[0]), .Y(n26) );
  INVX2 U30 ( .A(rollover_val[1]), .Y(n27) );
  INVX2 U31 ( .A(rollover_val[2]), .Y(n28) );
  INVX2 U32 ( .A(rollover_val[5]), .Y(n29) );
  INVX2 U33 ( .A(rollover_val[6]), .Y(n30) );
  INVX2 U34 ( .A(n66), .Y(n31) );
  INVX2 U35 ( .A(rollover_val[3]), .Y(n32) );
  INVX2 U36 ( .A(rollover_val[4]), .Y(n33) );
endmodule


module counter ( clk, n_reset, cnt_up, clear, one_k_samples );
  input clk, n_reset, cnt_up, clear;
  output one_k_samples;


  flex_counter_NUM_CNT_BITS10 CT ( .clk(clk), .n_rst(n_reset), .clear(clear), 
        .count_enable(cnt_up), .rollover_val({1'b1, 1'b1, 1'b1, 1'b1, 1'b1, 
        1'b0, 1'b0, 1'b1, 1'b1, 1'b1}), .rollover_flag(one_k_samples) );
endmodule


module magnitude_DW01_inc_0 ( A, SUM );
  input [15:0] A;
  output [15:0] SUM;

  wire   [15:2] carry;

  HAX1 U1_1_14 ( .A(A[14]), .B(carry[14]), .YC(carry[15]), .YS(SUM[14]) );
  HAX1 U1_1_13 ( .A(A[13]), .B(carry[13]), .YC(carry[14]), .YS(SUM[13]) );
  HAX1 U1_1_12 ( .A(A[12]), .B(carry[12]), .YC(carry[13]), .YS(SUM[12]) );
  HAX1 U1_1_11 ( .A(A[11]), .B(carry[11]), .YC(carry[12]), .YS(SUM[11]) );
  HAX1 U1_1_10 ( .A(A[10]), .B(carry[10]), .YC(carry[11]), .YS(SUM[10]) );
  HAX1 U1_1_9 ( .A(A[9]), .B(carry[9]), .YC(carry[10]), .YS(SUM[9]) );
  HAX1 U1_1_8 ( .A(A[8]), .B(carry[8]), .YC(carry[9]), .YS(SUM[8]) );
  HAX1 U1_1_7 ( .A(A[7]), .B(carry[7]), .YC(carry[8]), .YS(SUM[7]) );
  HAX1 U1_1_6 ( .A(A[6]), .B(carry[6]), .YC(carry[7]), .YS(SUM[6]) );
  HAX1 U1_1_5 ( .A(A[5]), .B(carry[5]), .YC(carry[6]), .YS(SUM[5]) );
  HAX1 U1_1_4 ( .A(A[4]), .B(carry[4]), .YC(carry[5]), .YS(SUM[4]) );
  HAX1 U1_1_3 ( .A(A[3]), .B(carry[3]), .YC(carry[4]), .YS(SUM[3]) );
  HAX1 U1_1_2 ( .A(A[2]), .B(carry[2]), .YC(carry[3]), .YS(SUM[2]) );
  HAX1 U1_1_1 ( .A(A[1]), .B(A[0]), .YC(carry[2]), .YS(SUM[1]) );
  INVX2 U1 ( .A(A[0]), .Y(SUM[0]) );
  XOR2X1 U2 ( .A(carry[15]), .B(A[15]), .Y(SUM[15]) );
endmodule


module magnitude ( in, out );
  input [16:0] in;
  output [15:0] out;
  wire   N18, N19, N20, N21, N22, N23, N24, N25, N26, N27, N28, N29, N30, N31,
         N32, N33, n17, n18, n19, n20, n21, n22, n23, n24, n25, n26, n27, n28,
         n29, n30, n31, n32, n1, n2, n3, n4, n5, n6, n7, n8, n9, n10, n11, n12,
         n13, n14, n15, n16, n33, n34;

  OAI21X1 U18 ( .A(n1), .B(n9), .C(n17), .Y(out[9]) );
  NAND2X1 U19 ( .A(in[16]), .B(N27), .Y(n17) );
  OAI21X1 U20 ( .A(n1), .B(n10), .C(n18), .Y(out[8]) );
  NAND2X1 U21 ( .A(N26), .B(in[16]), .Y(n18) );
  OAI21X1 U22 ( .A(n1), .B(n11), .C(n19), .Y(out[7]) );
  NAND2X1 U23 ( .A(N25), .B(in[16]), .Y(n19) );
  OAI21X1 U24 ( .A(n1), .B(n12), .C(n20), .Y(out[6]) );
  NAND2X1 U25 ( .A(N24), .B(in[16]), .Y(n20) );
  OAI21X1 U26 ( .A(n1), .B(n13), .C(n21), .Y(out[5]) );
  NAND2X1 U27 ( .A(N23), .B(in[16]), .Y(n21) );
  OAI21X1 U28 ( .A(n1), .B(n14), .C(n22), .Y(out[4]) );
  NAND2X1 U29 ( .A(N22), .B(in[16]), .Y(n22) );
  OAI21X1 U30 ( .A(n1), .B(n15), .C(n23), .Y(out[3]) );
  NAND2X1 U31 ( .A(N21), .B(in[16]), .Y(n23) );
  OAI21X1 U32 ( .A(n1), .B(n16), .C(n24), .Y(out[2]) );
  NAND2X1 U33 ( .A(N20), .B(n1), .Y(n24) );
  OAI21X1 U34 ( .A(n1), .B(n33), .C(n25), .Y(out[1]) );
  NAND2X1 U35 ( .A(N19), .B(n1), .Y(n25) );
  OAI21X1 U36 ( .A(n1), .B(n3), .C(n26), .Y(out[15]) );
  NAND2X1 U37 ( .A(N33), .B(in[16]), .Y(n26) );
  OAI21X1 U38 ( .A(n1), .B(n4), .C(n27), .Y(out[14]) );
  NAND2X1 U39 ( .A(N32), .B(n1), .Y(n27) );
  OAI21X1 U40 ( .A(n1), .B(n5), .C(n28), .Y(out[13]) );
  NAND2X1 U41 ( .A(N31), .B(in[16]), .Y(n28) );
  OAI21X1 U42 ( .A(n1), .B(n6), .C(n29), .Y(out[12]) );
  NAND2X1 U43 ( .A(N30), .B(in[16]), .Y(n29) );
  OAI21X1 U44 ( .A(in[16]), .B(n7), .C(n30), .Y(out[11]) );
  NAND2X1 U45 ( .A(N29), .B(in[16]), .Y(n30) );
  OAI21X1 U46 ( .A(in[16]), .B(n8), .C(n31), .Y(out[10]) );
  NAND2X1 U47 ( .A(N28), .B(in[16]), .Y(n31) );
  OAI21X1 U48 ( .A(in[16]), .B(n34), .C(n32), .Y(out[0]) );
  NAND2X1 U49 ( .A(N18), .B(in[16]), .Y(n32) );
  magnitude_DW01_inc_0 add_14 ( .A({n3, n4, n5, n6, n7, n8, n9, n10, n11, n12, 
        n13, n14, n15, n16, n33, n34}), .SUM({N33, N32, N31, N30, N29, N28, 
        N27, N26, N25, N24, N23, N22, N21, N20, N19, N18}) );
  INVX2 U2 ( .A(n2), .Y(n1) );
  INVX2 U3 ( .A(in[16]), .Y(n2) );
  INVX1 U4 ( .A(in[7]), .Y(n11) );
  INVX2 U5 ( .A(in[15]), .Y(n3) );
  INVX2 U6 ( .A(in[14]), .Y(n4) );
  INVX2 U7 ( .A(in[13]), .Y(n5) );
  INVX2 U8 ( .A(in[12]), .Y(n6) );
  INVX2 U9 ( .A(in[11]), .Y(n7) );
  INVX2 U10 ( .A(in[10]), .Y(n8) );
  INVX2 U11 ( .A(in[9]), .Y(n9) );
  INVX2 U12 ( .A(in[8]), .Y(n10) );
  INVX2 U13 ( .A(in[6]), .Y(n12) );
  INVX2 U14 ( .A(in[5]), .Y(n13) );
  INVX2 U15 ( .A(in[4]), .Y(n14) );
  INVX2 U16 ( .A(in[3]), .Y(n15) );
  INVX2 U17 ( .A(in[2]), .Y(n16) );
  INVX2 U50 ( .A(in[1]), .Y(n33) );
  INVX2 U51 ( .A(in[0]), .Y(n34) );
endmodule


module fir_filter ( clk, n_reset, sample_data, fir_coefficient, load_coeff, 
        data_ready, one_k_samples, modwait, fir_out, err );
  input [15:0] sample_data;
  input [15:0] fir_coefficient;
  output [15:0] fir_out;
  input clk, n_reset, load_coeff, data_ready;
  output one_k_samples, modwait, err;
  wire   dr, lc, clear, cnt_up, overflow;
  wire   [2:0] op;
  wire   [3:0] src1;
  wire   [3:0] src2;
  wire   [3:0] dest;
  wire   [16:0] outreg_data;
  wire   SYNOPSYS_UNCONNECTED__0;

  sync_1 SYN0 ( .clk(clk), .n_reset(n_reset), .data_ready(data_ready), .out(dr) );
  sync_0 SYN1 ( .clk(clk), .n_reset(n_reset), .data_ready(load_coeff), .out(lc) );
  controller CTL ( .clk(clk), .n_reset(n_reset), .dr(dr), .lc(lc), .overflow(
        overflow), .cnt_up(cnt_up), .clear(clear), .modwait(modwait), .op(op), 
        .src1({SYNOPSYS_UNCONNECTED__0, src1[2:0]}), .src2(src2), .dest(dest), 
        .err(err) );
  datapath DPT ( .clk(clk), .n_reset(n_reset), .op(op), .src1({1'b0, src1[2:0]}), .src2(src2), .dest(dest), .ext_data1(sample_data), .ext_data2(
        fir_coefficient), .outreg_data(outreg_data), .overflow(overflow) );
  counter CTR ( .clk(clk), .n_reset(n_reset), .cnt_up(cnt_up), .clear(clear), 
        .one_k_samples(one_k_samples) );
  magnitude MAG ( .in(outreg_data), .out(fir_out) );
endmodule

