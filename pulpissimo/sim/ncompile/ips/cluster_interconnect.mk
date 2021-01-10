#
# Copyright (C) 2015-2019 ETH Zurich, University of Bologna
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.
#

IP=cluster_interconnect
IP_PATH=$(IPS_PATH)/cluster_interconnect
LIB_NAME=$(IP)_lib

include ncompile/build.mk

.PHONY: ncompile-$(IP) ncompile-subip-low_latency_interco ncompile-subip-peripheral_interco ncompile-subip-tcdm_interconnect 

ncompile-$(IP): $(LIB_PATH)/_nmake

$(LIB_PATH)/_nmake : $(LIB_PATH)/low_latency_interco.nmake $(LIB_PATH)/peripheral_interco.nmake $(LIB_PATH)/tcdm_interconnect.nmake 
	echo $(LIB_PATH)/_nmake


# low_latency_interco component
INCDIR_LOW_LATENCY_INTERCO=+incdir+$(IP_PATH)/rtl/low_latency_interco
SRC_SVLOG_LOW_LATENCY_INTERCO=\
	$(IP_PATH)/rtl/low_latency_interco/FanInPrimitive_Req.sv\
	$(IP_PATH)/rtl/low_latency_interco/ArbitrationTree.sv\
	$(IP_PATH)/rtl/low_latency_interco/MUX2_REQ.sv\
	$(IP_PATH)/rtl/low_latency_interco/AddressDecoder_Resp.sv\
	$(IP_PATH)/rtl/low_latency_interco/TestAndSet.sv\
	$(IP_PATH)/rtl/low_latency_interco/RequestBlock2CH.sv\
	$(IP_PATH)/rtl/low_latency_interco/RequestBlock1CH.sv\
	$(IP_PATH)/rtl/low_latency_interco/FanInPrimitive_Resp.sv\
	$(IP_PATH)/rtl/low_latency_interco/ResponseTree.sv\
	$(IP_PATH)/rtl/low_latency_interco/ResponseBlock.sv\
	$(IP_PATH)/rtl/low_latency_interco/AddressDecoder_Req.sv\
	$(IP_PATH)/rtl/low_latency_interco/XBAR_TCDM.sv\
	$(IP_PATH)/rtl/low_latency_interco/XBAR_TCDM_WRAPPER.sv\
	$(IP_PATH)/rtl/low_latency_interco/TCDM_PIPE_REQ.sv\
	$(IP_PATH)/rtl/low_latency_interco/TCDM_PIPE_RESP.sv\
	$(IP_PATH)/rtl/low_latency_interco/grant_mask.sv\
	$(IP_PATH)/rtl/low_latency_interco/priority_Flag_Req.sv
SRC_VHDL_LOW_LATENCY_INTERCO=

ncompile-subip-low_latency_interco: $(LIB_PATH)/low_latency_interco.nmake

$(LIB_PATH)/low_latency_interco.nmake: $(SRC_SVLOG_LOW_LATENCY_INTERCO) $(SRC_VHDL_LOW_LATENCY_INTERCO)
	$(call subip_echo,low_latency_interco)
	$(SVLOG_CC) -makelib ./ncsim_libs    $(INCDIR_LOW_LATENCY_INTERCO) $(SRC_SVLOG_LOW_LATENCY_INTERCO) -endlib

	echo $(LIB_PATH)/low_latency_interco.nmake

# peripheral_interco component
INCDIR_PERIPHERAL_INTERCO=+incdir+$(IP_PATH)/rtl/peripheral_interco+$(IP_PATH)/../../rtl/includes
SRC_SVLOG_PERIPHERAL_INTERCO=\
	$(IP_PATH)/rtl/peripheral_interco/AddressDecoder_PE_Req.sv\
	$(IP_PATH)/rtl/peripheral_interco/AddressDecoder_Resp_PE.sv\
	$(IP_PATH)/rtl/peripheral_interco/ArbitrationTree_PE.sv\
	$(IP_PATH)/rtl/peripheral_interco/FanInPrimitive_Req_PE.sv\
	$(IP_PATH)/rtl/peripheral_interco/RR_Flag_Req_PE.sv\
	$(IP_PATH)/rtl/peripheral_interco/MUX2_REQ_PE.sv\
	$(IP_PATH)/rtl/peripheral_interco/FanInPrimitive_PE_Resp.sv\
	$(IP_PATH)/rtl/peripheral_interco/RequestBlock1CH_PE.sv\
	$(IP_PATH)/rtl/peripheral_interco/RequestBlock2CH_PE.sv\
	$(IP_PATH)/rtl/peripheral_interco/ResponseBlock_PE.sv\
	$(IP_PATH)/rtl/peripheral_interco/ResponseTree_PE.sv\
	$(IP_PATH)/rtl/peripheral_interco/XBAR_PE.sv
SRC_VHDL_PERIPHERAL_INTERCO=

ncompile-subip-peripheral_interco: $(LIB_PATH)/peripheral_interco.nmake

$(LIB_PATH)/peripheral_interco.nmake: $(SRC_SVLOG_PERIPHERAL_INTERCO) $(SRC_VHDL_PERIPHERAL_INTERCO)
	$(call subip_echo,peripheral_interco)
	$(SVLOG_CC) -makelib ./ncsim_libs    $(INCDIR_PERIPHERAL_INTERCO) $(SRC_SVLOG_PERIPHERAL_INTERCO) -endlib

	echo $(LIB_PATH)/peripheral_interco.nmake

SRC_SVLOG_TCDM_INTERCONNECT=\
	$(IP_PATH)/rtl/tcdm_interconnect/tcdm_interconnect_pkg.sv\
	$(IP_PATH)/rtl/tcdm_interconnect/addr_dec_resp_mux.sv\
	$(IP_PATH)/rtl/tcdm_interconnect/amo_shim.sv\
	$(IP_PATH)/rtl/tcdm_interconnect/xbar.sv\
	$(IP_PATH)/rtl/tcdm_interconnect/clos_net.sv\
	$(IP_PATH)/rtl/tcdm_interconnect/bfly_net.sv\
	$(IP_PATH)/rtl/tcdm_interconnect/tcdm_interconnect.sv
SRC_VHDL_TCDM_INTERCONNECT=

ncompile-subip-tcdm_interconnect: $(LIB_PATH)/tcdm_interconnect.nmake

$(LIB_PATH)/tcdm_interconnect.nmake: $(SRC_SVLOG_TCDM_INTERCONNECT) $(SRC_VHDL_TCDM_INTERCONNECT)
	$(call subip_echo,tcdm_interconnect)
	$(SVLOG_CC) -makelib ./ncsim_libs    $(INCDIR_TCDM_INTERCONNECT) $(SRC_SVLOG_TCDM_INTERCONNECT) -endlib

	echo $(LIB_PATH)/tcdm_interconnect.nmake

