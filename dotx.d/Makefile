# Copyright (C) The IETF Trust (2007-2008)

FORE_OPS_AS_IS1 = \
		access_args.x \
		access_res.x \
		close_args.x \
		close_res.x \
		commit_args.x \
		commit_res.x \
		create_args.x \
		create_res.x \
		delegpurge_args.x \
		delegpurge_res.x \
		delegreturn_args.x \
		delegreturn_res.x \
		getattr_args.x \
		getattr_res.x \
		getfh_res.x \
		link_args.x \
		link_res.x \
		lock_args.x \
		lock_res.x \
		lockt_args.x \
		lockt_res.x \
		locku_args.x \
		locku_res.x \
		lookup_args.x \
		lookup_res.x \
		lookupp_res.x \
		nverify_args.x \
		nverify_res.x

FORE_OPS_AS_IS2 = \
		open_res.x \
		openattr_args.x \
		openattr_res.x \
		open_confirm_args.x \
		open_confirm_res.x \
		open_downgrade_args.x \
		open_downgrade_res.x \
		putfh_args.x \
		putfh_res.x \
		putpubfh_res.x \
		putrootfh_res.x \
		read_args.x \
		read_res.x \
		readdir_args.x \
		readdir_res.x \
		readlink_res.x \
		remove_args.x \
		remove_res.x \
		rename_args.x \
		rename_res.x \
		renew_args.x \
		renew_res.x \
		restorefh_res.x \
		savefh_res.x \
		secinfo_args.x \
		secinfo_res.x \
		setattr_args.x \
		setattr_res.x \
		setclientid_args.x \
		setclientid_res.x \
		setclientid_confirm_args.x \
		setclientid_confirm_res.x \
		verify_args.x \
		verify_res.x \
		write_args.x \
		write_res.x \
		release_lockowner_args.x \
		release_lockowner_res.x \
		illegal_res.x

FORE_OPS = $(FORE_OPS_AS_IS1) open_args_gen.x $(FORE_OPS_AS_IS2)

FORE_OPS_SRC =  $(FORE_OPS_AS_IS1) open_args.x $(FORE_OPS_AS_IS2)

BACK_OPS =	cb_getattr_args.x \
		cb_getattr_res.x \
		cb_recall_args.x \
		cb_recall_res.x \
		cb_illegal_res.x

SPITGEN =	basic_types.x \
		type_nfstime4.x \
		type_time_how4.x \
		type_settime4.x \
		type_fsid4.x \
		type_specdata4.x \
		type_fs_location4.x \
		type_fs_locations4.x \
		type_fattr4.x \
		type_change_info4.x \
		type_cb_client4.x \
		type_nfs_client_id4.x \
		type_open_owner4.x \
		type_lock_owner4.x \
		type_nfs_lock_type4.x \
		type_clientaddr4.x \
		type_state_owner4.x \
		type_open_to_lock_owner4.x \
		type_stateid4.x \
		type_acetype4.x \
		type_aceflag4.x \
		type_acemask4.x \
		type_nfsace4.x \
		const_acetype4.x \
		const_aceflag4.x \
		const_aclsupport4.x \
		const_acemask4.x \
		const_mode4.x \
		const_access_deny.x \
		const_sizes.x \
		type_nfs_cb_opnum4.x \
		type_nfs_cb_argop4.x \
		type_CB_COMPOUND4args.x \
		type_nfs_cb_resop4.x \
		type_CB_COMPOUND4res.x \
                type_nfs_opnum4.x \
                type_nfs_argop4.x \
		type_nfs_resop4.x \
		type_COMPOUND4args.x \
		type_COMPOUND4res.x

AUTOGEN =	hand_edit_warning.x \
		fore_ops.x \
		back_ops.x \
		$(SPITGEN) \
		open_args_gen.x

all:	nfsv4.x filelist

nfsv4.x: $(AUTOGEN) hand_edit_warning.x head.x fore_ops.x fore_prog.x back_ops.x back_prog.x
	m4 hand_edit_warning.x head.x fore_ops.x fore_prog.x back_ops.x back_prog.x | expand | tr -d "\r" > nfsv4.tmp
	mv nfsv4.tmp nfsv4.x

hand_edit_warning.x: Makefile ../Makefile head.x $(FORE_OPS) fore_prog.x $(BACK_OPS) back_prog.x
	( \
		echo "/*" ; \
		echo " * This file was machine generated for" ; \
                echo " *  draft-ietf-nfsv4-rfc3530bis-$(VERS)" ; \
		echo " * Last updated `date`" ; \
		echo " */" ; \
	)  > hand_edit_warning.x

open_args_gen.x: open_args.x const_access_deny.x
		rm -f $@ $@.tmp $@.m4
		cat const_access_deny.x open_args.x > $@.m4
		m4 $@.m4 > $@.tmp
		mv $@.tmp $@

fore_ops.x: $(FORE_OPS) Makefile
	cat $(FORE_OPS) > fore_ops.x

back_ops.x: $(BACK_OPS) Makefile
	cat $(BACK_OPS) > back_ops.x

$(SPITGEN): spit_types.sh
	sh spit_types.sh $@

clean:
	$(RM) $(AUTOGEN) tmp.filelist

clobber:
	$(RM) nfsv4.x

filelist: Makefile
	echo "" > tmp.filelist ; \
	for f in Makefile spit_types.sh head.x fore_prog.x back_prog.x $(FORE_OPS_SRC) $(BACK_OPS) ; do \
	echo dotx.d/$$f >> tmp.filelist ; \
	done
