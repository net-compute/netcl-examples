	apply {
		P.emit(H);
	}
	apply {
		ncvm_and_32_32_32(_tmp__0_and, H.ncp_data_1_0[0].value, 5);
		if ((_tmp__0_and == 0)) {
			ncvm_action_drop(M);
		}
		else {
			mem_rmw_o_0_mem_Round(call_i, ((bit<16>) H.ncp_data_1_1[0].value));
			ncvm_sub_16_16_16(_tmp__3_icmp_conv_0_sub, H.ncp_data_1_2[0].value, call_i);
			if (((bool) _tmp__3_icmp_conv_0_sub[15:15])) {
				ncvm_action_drop(M);
			}
			else {
				H.ncp_data_1_4[0].value = 1;
				if ((H.ncp_data_1_0[0].value == 1)) {
					H.ncp_data_1_0[0].value = 2;
					H.ncp_data_1_3[0].value = _mem__ZZ8acceptorR8msg_typeRjtRtRhPjE6VRound.read(((bit<16>) H.ncp_data_1_1[0].value));
					H.ncp_data_1_5[0].value = _mem_Value_fragment_0_.read(((bit<16>) H.ncp_data_1_1[0].value));
					H.ncp_data_1_5[1].value = _mem_Value_fragment_1_.read(((bit<16>) H.ncp_data_1_1[0].value));
					H.ncp_data_1_5[2].value = _mem_Value_fragment_2_.read(((bit<16>) H.ncp_data_1_1[0].value));
					H.ncp_data_1_5[3].value = _mem_Value_fragment_3_.read(((bit<16>) H.ncp_data_1_1[0].value));
					H.ncp_data_1_5[4].value = _mem_Value_fragment_4_.read(((bit<16>) H.ncp_data_1_1[0].value));
					H.ncp_data_1_5[5].value = _mem_Value_fragment_5_.read(((bit<16>) H.ncp_data_1_1[0].value));
					H.ncp_data_1_5[6].value = _mem_Value_fragment_6_.read(((bit<16>) H.ncp_data_1_1[0].value));
					H.ncp_data_1_5[7].value = _mem_Value_fragment_7_.read(((bit<16>) H.ncp_data_1_1[0].value));
					ncvm_action_send_to_device(M, 4);
				}
				else {
					H.ncp_data_1_0[0].value = 8;
					mem_rmw_0_mem__ZZ8acceptorR8msg_typeRjtRtRhPjE6VRound(((bit<16>) H.ncp_data_1_1[0].value));
					mem_rmw_1_mem_Value_fragment_0_(((bit<16>) H.ncp_data_1_1[0].value));
					mem_rmw_2_mem_Value_fragment_1_(((bit<16>) H.ncp_data_1_1[0].value));
					mem_rmw_3_mem_Value_fragment_2_(((bit<16>) H.ncp_data_1_1[0].value));
					mem_rmw_4_mem_Value_fragment_3_(((bit<16>) H.ncp_data_1_1[0].value));
					mem_rmw_5_mem_Value_fragment_4_(((bit<16>) H.ncp_data_1_1[0].value));
					mem_rmw_6_mem_Value_fragment_5_(((bit<16>) H.ncp_data_1_1[0].value));
					mem_rmw_7_mem_Value_fragment_6_(((bit<16>) H.ncp_data_1_1[0].value));
					mem_rmw_8_mem_Value_fragment_7_(((bit<16>) H.ncp_data_1_1[0].value));
					ncvm_action_multicast(M, 12);
				}
			}
		}
		return;
	}
	apply {
		if ((M.ncl_act == _ncl_action_multicast_)) {
			ncl_forward_multicast_tbl.apply();
		}
		else
			if ((M.ncl_act == _ncl_action_repeat_)) {
				ncl_repeat();
			}
			else
				if ((M.ncl_act == _ncl_action_reflect_)) {
					ncl_forward_reflect_tbl.apply();
				}
				else
					if ((M.ncl_act == _ncl_action_send_to_device_)) {
						ncl_forward_device_tbl.apply();
					}
					else {
						ncl_forward_host_tbl.apply();
					}
	}
	apply {
		if (H.ncp.isValid()) {
			if (!M.ncl_no_op) {
				M.ncl_act = _ncl_default_action_;
				M.ncl_act_arg = _ncl_default_action_arg_;
				ncl_compute.apply(H, M, IM);
			}
			ncl_network.apply(H, M, IM, IDM, ITM);
		}
	}
	apply {
		H.ip4.checksum = ip4_checksum.update({H.ip4.version,H.ip4.ihl,H.ip4.tos,H.ip4.total_len,H.ip4.identification,H.ip4.flags,H.ip4.frag_offset,H.ip4.ttl,H.ip4.protocol,H.ip4.src_addr,H.ip4.dst_addr});
		P.emit(H.eth);
		P.emit(H.ip4);
		P.emit(H.udp);
		P.emit(H.ncp);
	}
	apply {
		if (H.ncp.isValid()) {
			if ((H.ncp.act == _ncl_action_repeat_)) { }
			else {
				ncl_port_tbl.apply();
				if ((((H.ncp.act == _ncl_action_multicast_) || (H.ncp.act == _ncl_action_multicast_long_)) || (H.ip4.src_addr == H.ip4.dst_addr)))
					ncl_use_implicit_ip4_src_addr(H);
			}
		}
	}