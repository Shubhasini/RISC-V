//16_bit_counter.tlv

//https://myth1.makerchip.com/sandbox/02kfkhByV/0y8hrN2#

\m4_TLV_version 1d: tl-x.org
\SV
   // Design : Adder
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m4_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
  $count[15:0] = *reset ? 0 : >>1$count + 1;
   // Assert these to end simulation (before Makerchip cycle limit).
   *passed = *cyc_cnt > 25;
   *failed = 1'b0;
\SV
   endmodule