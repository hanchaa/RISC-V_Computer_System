#
# Copyright (C) 2015-2019 ETH Zurich, University of Bologna
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.
#

IP=axi
IP_PATH=$(IPS_PATH)/axi/axi
LIB_NAME=$(IP)_lib

include ncompile/build.mk

.PHONY: ncompile-$(IP) ncompile-subip-axi 

ncompile-$(IP): $(LIB_PATH)/_nmake

$(LIB_PATH)/_nmake : $(LIB_PATH)/axi.nmake 
	echo $(LIB_PATH)/_nmake


# axi component
INCDIR_AXI=+incdir+$(IP_PATH)/include+$(IP_PATH)/../../common_cells/include
SRC_SVLOG_AXI=\
	$(IP_PATH)/src/axi_pkg.sv\
	$(IP_PATH)/src/axi_intf.sv\
	$(IP_PATH)/src/axi_atop_filter.sv\
	$(IP_PATH)/src/axi_burst_splitter.sv\
	$(IP_PATH)/src/axi_cdc.sv\
	$(IP_PATH)/src/axi_cut.sv\
	$(IP_PATH)/src/axi_delayer.sv\
	$(IP_PATH)/src/axi_demux.sv\
	$(IP_PATH)/src/axi_dw_downsizer.sv\
	$(IP_PATH)/src/axi_dw_upsizer.sv\
	$(IP_PATH)/src/axi_id_prepend.sv\
	$(IP_PATH)/src/axi_isolate.sv\
	$(IP_PATH)/src/axi_join.sv\
	$(IP_PATH)/src/axi_lite_demux.sv\
	$(IP_PATH)/src/axi_lite_join.sv\
	$(IP_PATH)/src/axi_lite_mailbox.sv\
	$(IP_PATH)/src/axi_lite_mux.sv\
	$(IP_PATH)/src/axi_lite_regs.sv\
	$(IP_PATH)/src/axi_lite_to_apb.sv\
	$(IP_PATH)/src/axi_lite_to_axi.sv\
	$(IP_PATH)/src/axi_modify_address.sv\
	$(IP_PATH)/src/axi_mux.sv\
	$(IP_PATH)/src/axi_serializer.sv\
	$(IP_PATH)/src/axi_err_slv.sv\
	$(IP_PATH)/src/axi_dw_converter.sv\
	$(IP_PATH)/src/axi_multicut.sv\
	$(IP_PATH)/src/axi_to_axi_lite.sv\
	$(IP_PATH)/src/axi_lite_xbar.sv\
	$(IP_PATH)/src/axi_xbar.sv
SRC_VHDL_AXI=

ncompile-subip-axi: $(LIB_PATH)/axi.nmake

$(LIB_PATH)/axi.nmake: $(SRC_SVLOG_AXI) $(SRC_VHDL_AXI)
	$(call subip_echo,axi)
	$(SVLOG_CC) -makelib ./ncsim_libs    $(INCDIR_AXI) $(SRC_SVLOG_AXI) -endlib

	echo $(LIB_PATH)/axi.nmake


