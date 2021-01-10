#
# Copyright (C) 2015-2019 ETH Zurich, University of Bologna
# All rights reserved.
#
# This software may be modified and distributed under the terms
# of the BSD license.  See the LICENSE file for details.
#

IP=register_interface
IP_PATH=$(IPS_PATH)/register_interface
LIB_NAME=$(IP)_lib

include ncompile/build.mk

.PHONY: ncompile-$(IP) ncompile-subip-register_interface ncompile-subip-reggen_primitives ncompile-subip-register_interface_test 

ncompile-$(IP): $(LIB_PATH)/_nmake

$(LIB_PATH)/_nmake : $(LIB_PATH)/register_interface.nmake $(LIB_PATH)/reggen_primitives.nmake $(LIB_PATH)/register_interface_test.nmake 
	echo $(LIB_PATH)/_nmake


# register_interface component
INCDIR_REGISTER_INTERFACE=+incdir+$(IP_PATH)/include+$(IP_PATH)/../axi/axi/include+$(IP_PATH)/../common_cells/include
SRC_SVLOG_REGISTER_INTERFACE=\
	$(IP_PATH)/src/reg_intf_pkg.sv\
	$(IP_PATH)/src/reg_intf.sv\
	$(IP_PATH)/src/apb_to_reg.sv\
	$(IP_PATH)/src/axi_to_reg.sv\
	$(IP_PATH)/src/reg_cdc.sv\
	$(IP_PATH)/src/reg_demux.sv\
	$(IP_PATH)/src/reg_mux.sv\
	$(IP_PATH)/src/reg_to_mem.sv\
	$(IP_PATH)/src/reg_uniform.sv\
	$(IP_PATH)/src/axi_lite_to_reg.sv
SRC_VHDL_REGISTER_INTERFACE=

ncompile-subip-register_interface: $(LIB_PATH)/register_interface.nmake

$(LIB_PATH)/register_interface.nmake: $(SRC_SVLOG_REGISTER_INTERFACE) $(SRC_VHDL_REGISTER_INTERFACE)
	$(call subip_echo,register_interface)
	$(SVLOG_CC) -makelib ./ncsim_libs    $(INCDIR_REGISTER_INTERFACE) $(SRC_SVLOG_REGISTER_INTERFACE) -endlib

	echo $(LIB_PATH)/register_interface.nmake

# reggen_primitives component
INCDIR_REGGEN_PRIMITIVES=+incdir+$(IP_PATH)/include+$(IP_PATH)/../axi/axi/include+$(IP_PATH)/../common_cells/include
SRC_SVLOG_REGGEN_PRIMITIVES=\
	$(IP_PATH)/vendor/lowrisc_opentitan/src/prim_subreg.sv\
	$(IP_PATH)/vendor/lowrisc_opentitan/src/prim_subreg_arb.sv\
	$(IP_PATH)/vendor/lowrisc_opentitan/src/prim_subreg_ext.sv\
	$(IP_PATH)/vendor/lowrisc_opentitan/src/prim_subreg_shadow.sv
SRC_VHDL_REGGEN_PRIMITIVES=

ncompile-subip-reggen_primitives: $(LIB_PATH)/reggen_primitives.nmake

$(LIB_PATH)/reggen_primitives.nmake: $(SRC_SVLOG_REGGEN_PRIMITIVES) $(SRC_VHDL_REGGEN_PRIMITIVES)
	$(call subip_echo,reggen_primitives)
	$(SVLOG_CC) -makelib ./ncsim_libs    $(INCDIR_REGGEN_PRIMITIVES) $(SRC_SVLOG_REGGEN_PRIMITIVES) -endlib

	echo $(LIB_PATH)/reggen_primitives.nmake

# register_interface_test component
INCDIR_REGISTER_INTERFACE_TEST=+incdir+$(IP_PATH)/include
SRC_SVLOG_REGISTER_INTERFACE_TEST=\
	$(IP_PATH)/src/reg_test.sv
SRC_VHDL_REGISTER_INTERFACE_TEST=

ncompile-subip-register_interface_test: $(LIB_PATH)/register_interface_test.nmake

$(LIB_PATH)/register_interface_test.nmake: $(SRC_SVLOG_REGISTER_INTERFACE_TEST) $(SRC_VHDL_REGISTER_INTERFACE_TEST)
	$(call subip_echo,register_interface_test)
	$(SVLOG_CC) -makelib ./ncsim_libs    $(INCDIR_REGISTER_INTERFACE_TEST) $(SRC_SVLOG_REGISTER_INTERFACE_TEST) -endlib

	echo $(LIB_PATH)/register_interface_test.nmake

