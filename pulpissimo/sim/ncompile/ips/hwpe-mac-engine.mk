#
# Copyright (C) 2015-2019 ETH Zurich, University of Bologna
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.
#

IP=hwpe_mac_engine
IP_PATH=$(IPS_PATH)/hwpe-mac-engine
LIB_NAME=$(IP)_lib

include ncompile/build.mk

.PHONY: ncompile-$(IP) ncompile-subip-hw-mac-engine 

ncompile-$(IP): $(LIB_PATH)/_nmake

$(LIB_PATH)/_nmake : $(LIB_PATH)/hw-mac-engine.nmake 
	echo $(LIB_PATH)/_nmake


# hw-mac-engine component
INCDIR_HW-MAC-ENGINE=+incdir+$(IP_PATH)/rtl
SRC_SVLOG_HW-MAC-ENGINE=\
	$(IP_PATH)/rtl/mac_package.sv\
	$(IP_PATH)/rtl/mac_fsm.sv\
	$(IP_PATH)/rtl/mac_ctrl.sv\
	$(IP_PATH)/rtl/mac_streamer.sv\
	$(IP_PATH)/rtl/mac_engine.sv\
	$(IP_PATH)/rtl/mac_top.sv\
	$(IP_PATH)/wrap/mac_top_wrap.sv
SRC_VHDL_HW-MAC-ENGINE=

ncompile-subip-hw-mac-engine: $(LIB_PATH)/hw-mac-engine.nmake

$(LIB_PATH)/hw-mac-engine.nmake: $(SRC_SVLOG_HW-MAC-ENGINE) $(SRC_VHDL_HW-MAC-ENGINE)
	$(call subip_echo,hw-mac-engine)
	$(SVLOG_CC) -makelib ./ncsim_libs    $(INCDIR_HW-MAC-ENGINE) $(SRC_SVLOG_HW-MAC-ENGINE) -endlib

	echo $(LIB_PATH)/hw-mac-engine.nmake

