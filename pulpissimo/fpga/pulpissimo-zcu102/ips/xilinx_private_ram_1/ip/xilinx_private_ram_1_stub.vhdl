-- Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2018.3 (lin64) Build 2405991 Thu Dec  6 23:36:41 MST 2018
-- Date        : Fri Mar  5 17:58:51 2021
-- Host        : hanchaa running 64-bit Ubuntu 16.04.7 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/hanchaa/Desktop/RISC-V_Computer_System/pulpissimo/fpga/pulpissimo-zcu102/ips/xilinx_private_ram_1/xilinx_private_ram_1.srcs/sources_1/ip/xilinx_private_ram_1/xilinx_private_ram_1_stub.vhdl
-- Design      : xilinx_private_ram_1
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xczu9eg-ffvb1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity xilinx_private_ram_1 is
  Port ( 
    clka : in STD_LOGIC;
    ena : in STD_LOGIC;
    wea : in STD_LOGIC_VECTOR ( 3 downto 0 );
    addra : in STD_LOGIC_VECTOR ( 12 downto 0 );
    dina : in STD_LOGIC_VECTOR ( 31 downto 0 );
    douta : out STD_LOGIC_VECTOR ( 31 downto 0 )
  );

end xilinx_private_ram_1;

architecture stub of xilinx_private_ram_1 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "clka,ena,wea[3:0],addra[12:0],dina[31:0],douta[31:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "blk_mem_gen_v8_4_2,Vivado 2018.3";
begin
end;
