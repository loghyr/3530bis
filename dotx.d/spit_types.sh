#!/bin/sh
# Copyright (C) The IETF Trust (2007-2011)

for i in $* ;
do
	case $i in

	autogen/basic_types.xml | basic_types.x )

	if [ "$tmp" = "" ]
	then
		tmp=t$$

cat << EOF > $tmp
typedef :int:int32_t
typedef :unsigned int:uint32_t
typedef :hyper:int64_t
typedef :unsigned hyper:uint64_t
typedef :opaque  :attrlist4<>:Used for file/directory attributes.
typedef :uint32_t:bitmap4<>:Used in attribute array encoding.
typedef :uint64_t:changeid4:Used in the definition of change_info4.
typedef :uint64_t:clientid4:Shorthand reference to client identification.
typedef :uint32_t:count4:Various count parameters (READ, WRITE, COMMIT).
typedef :uint64_t:length4:Describes LOCK lengths.
typedef :uint32_t:mode4:Mode attribute data type.
typedef :uint64_t:nfs_cookie4:Opaque cookie value for READDIR.
typedef :opaque  :nfs_fh4<NFS4_FHSIZE>:Filehandle definition.
:enum:nfs_ftype4:Various defined file types.
:enum:nfsstat4:Return value for operations.
typedef :uint64_t:offset4:Various offset designations (READ, WRITE, LOCK, COMMIT).
typedef :uint32_t:qop4:Quality of protection designation in SECINFO.
typedef :opaque  :sec_oid4<>:Security Object Identifier. The sec_oid4 data type is not really opaque. Instead it contains an ASN.1 OBJECT IDENTIFIER as used by GSS-API in the mech_type argument to GSS_Init_sec_context. See <xref target="RFC2743" /> for details.
typedef :uint32_t:seqid4:Sequence identifier used for file locking.
typedef :opaque  :utf8string<>:UTF-8 encoding for strings.
typedef :utf8string:utf8_expected:String expected to be UTF-8 but no validation
typedef :utf8string:utf8val_RECOMMENDED4:String SHOULD be sent UTF-8 and SHOULD be validated
typedef :utf8string:utf8val_REQUIRED4:String MUST be sent UTF-8 and MUST be validated
typedef :utf8string:ascii_REQUIRED4:String MUST be sent as ASCII and thus is automatically UTF.8
typedef :utf8_expected:comptag4:Tag should be UTF.8 but is not checked
typedef :utf8val_RECOMMENDED4:component4:Represents path name components.
typedef :utf8val_RECOMMENDED4:linktext4:Symbolic link contents.
typedef :component4:pathname4<>:Represents path name for fs_locations.
typedef :uint64_t:nfs_lockid4
typedef :opaque  :verifier4[NFS4_VERIFIER_SIZE]:Verifier used for various operations (COMMIT, CREATE, EXCHANGE_ID, OPEN, READDIR, WRITE) NFS4_VERIFIER_SIZE is defined as 8.
EOF

	fi

	if [ $i = autogen/basic_types.xml ]
	then
		mkdir -p autogen

		cat $tmp | sed 's/<xref/qdfuixref/g' | sed 's/</\&lt;/g' |
		awk -F: '
			{
				i = index($3, "&lt;");
				if (i == 0) {
					i = index($3, "[");
				};
				if (i != 0) {
					type_name = substr($3, 1, i - 1);
				} else {
					type_name = $3;
				}

				printf "\t<c>%s</c>\t\t<c>%s%s %s;</c>\n", type_name, $1, $2, $3 ;
				if (NF > 3) {
					printf "\t<c/>\t<c>%s</c>\n", $4 ;
				}
				printf "\n";
			}

		' | sed 's/qdfuixref/<xref/g' > $i
	else
		cat $tmp | awk -F: '
			NR >= 5 {
				if ($1 != "") {
					printf "%s%s\t%s;\n", $1, $2, $3;
				}
			}
		' > $@

	fi


	;;

	const_sizes.x )

cat << EOF > $i
const NFS4_FHSIZE		= 128;
const NFS4_VERIFIER_SIZE	= 8;
const NFS4_OPAQUE_LIMIT		= 1024;

EOF

	;;

	type_nfstime4.x )

cat << EOF > $i
struct nfstime4 {
	int64_t		seconds;
	uint32_t	nseconds;
};
EOF
	;;

	type_time_how4.x )

cat << EOF > $i
enum time_how4 {
	SET_TO_SERVER_TIME4 = 0,
	SET_TO_CLIENT_TIME4 = 1
};
EOF
	;;

	type_settime4.x )


cat << EOF > $i
union settime4 switch (time_how4 set_it) {
 case SET_TO_CLIENT_TIME4:
	 nfstime4	time;
 default:
	 void;
};
EOF
	;;

	type_fsid4.x )


cat << EOF > $i
struct fsid4 {
	uint64_t	major;
	uint64_t	minor;
};
EOF
	;;

	type_specdata4.x )


cat << EOF > $i
struct specdata4 {
 uint32_t specdata1; /* major device number */
 uint32_t specdata2; /* minor device number */
};
EOF
	;;

	type_fs_location4.x )


cat << EOF > $i
struct fs_location4 {
	utf8val_REQUIRED4	server<>;
	pathname4		rootpath;
};
EOF
	;;

	type_fs_locations4.x )


cat << EOF > $i
struct fs_locations4 {
	pathname4	fs_root;
	fs_location4	locations<>;
};
EOF
	;;

	type_fattr4.x )


cat << EOF > $i
struct fattr4 {
	bitmap4		attrmask;
	attrlist4	attr_vals;
};
EOF
	;;

	type_change_info4.x )


cat << EOF > $i
struct change_info4 {
	bool		atomic;
	changeid4	before;
	changeid4	after;
};
EOF
	;;

	type_cb_client4.x )


cat << EOF > $i
struct cb_client4 {
	unsigned int	cb_program;
	clientaddr4	cb_location;
};
EOF
	;;

	type_nfs_client_id4.x )


cat << EOF > $i
struct nfs_client_id4 {
	verifier4	verifier;
	opaque		id<NFS4_OPAQUE_LIMIT>;
};
EOF
	;;

	type_open_owner4.x )


cat << EOF > $i
struct open_owner4 {
	clientid4	clientid;
	opaque		owner<NFS4_OPAQUE_LIMIT>;
};
EOF
	;;

	type_lock_owner4.x )


cat << EOF > $i
struct lock_owner4 {
	clientid4	clientid;
	opaque		owner<NFS4_OPAQUE_LIMIT>;
};
EOF
	;;

	type_nfs_lock_type4.x )

cat << EOF > $i
enum nfs_lock_type4 {
	READ_LT		= 1,
	WRITE_LT	= 2,
	READW_LT	= 3,	/* blocking read */
	WRITEW_LT	= 4	/* blocking write */
};
EOF

	;;

	type_clientaddr4.x )


cat << EOF > $i
struct clientaddr4 {
	/* see struct rpcb in RFC 1833 */
	string r_netid<>;	/* network id */
	string r_addr<>;	/* universal address */
};
EOF
	;;

	type_state_owner4.x )


cat << EOF > $i
struct state_owner4 {
	clientid4	clientid;
	opaque		owner<NFS4_OPAQUE_LIMIT>;
};

EOF
	;;

	type_open_to_lock_owner4.x )


cat << EOF > $i
struct open_to_lock_owner4 {
	seqid4		open_seqid;
	stateid4	open_stateid;
	seqid4		lock_seqid;
	lock_owner4	lock_owner;
};
EOF
	;;

	type_stateid4.x )

cat << EOF > $i
struct stateid4 {
	uint32_t	seqid;
	opaque		other[12];
};
EOF
	;;

	type_acetype4.x )

cat << EOF > $i
typedef uint32_t	acetype4;
EOF
	;;

	type_aceflag4.x )

cat << EOF > $i
typedef uint32_t aceflag4;
EOF
	;;

	type_acemask4.x )

cat << EOF > $i
typedef uint32_t	acemask4;
EOF
	;;

	type_nfsace4.x )

cat << EOF > $i
struct nfsace4 {
	acetype4		type;
	aceflag4		flag;
	acemask4		access_mask;
	utf8val_REQUIRED4	who;
};
EOF
	;;

	const_acetype4.x )

cat << EOF > $i
const ACE4_ACCESS_ALLOWED_ACE_TYPE	= 0x00000000;
const ACE4_ACCESS_DENIED_ACE_TYPE	= 0x00000001;
const ACE4_SYSTEM_AUDIT_ACE_TYPE	= 0x00000002;
const ACE4_SYSTEM_ALARM_ACE_TYPE	= 0x00000003;
EOF
	;;

	const_aceflag4.x )

cat << EOF > $i
const ACE4_FILE_INHERIT_ACE		= 0x00000001;
const ACE4_DIRECTORY_INHERIT_ACE	= 0x00000002;
const ACE4_NO_PROPAGATE_INHERIT_ACE	= 0x00000004;
const ACE4_INHERIT_ONLY_ACE		= 0x00000008;
const ACE4_SUCCESSFUL_ACCESS_ACE_FLAG	= 0x00000010;
const ACE4_FAILED_ACCESS_ACE_FLAG	= 0x00000020;
const ACE4_IDENTIFIER_GROUP		= 0x00000040;
EOF
	;;

	const_aclsupport4.x )

cat << EOF > $i
const ACL4_SUPPORT_ALLOW_ACL	= 0x00000001;
const ACL4_SUPPORT_DENY_ACL	= 0x00000002;
const ACL4_SUPPORT_AUDIT_ACL	= 0x00000004;
const ACL4_SUPPORT_ALARM_ACL	= 0x00000008;
EOF
	;;

	const_acemask4.x )

cat << EOF > $i
const ACE4_READ_DATA		= 0x00000001;
const ACE4_LIST_DIRECTORY	= 0x00000001;
const ACE4_WRITE_DATA		= 0x00000002;
const ACE4_ADD_FILE		= 0x00000002;
const ACE4_APPEND_DATA		= 0x00000004;
const ACE4_ADD_SUBDIRECTORY	= 0x00000004;
const ACE4_READ_NAMED_ATTRS	= 0x00000008;
const ACE4_WRITE_NAMED_ATTRS	= 0x00000010;
const ACE4_EXECUTE		= 0x00000020;
const ACE4_DELETE_CHILD		= 0x00000040;
const ACE4_READ_ATTRIBUTES	= 0x00000080;
const ACE4_WRITE_ATTRIBUTES	= 0x00000100;

const ACE4_DELETE		= 0x00010000;
const ACE4_READ_ACL		= 0x00020000;
const ACE4_WRITE_ACL		= 0x00040000;
const ACE4_WRITE_OWNER		= 0x00080000;
const ACE4_SYNCHRONIZE		= 0x00100000;
EOF
	;;

	const_mode4.x )

cat << EOF > $i
const MODE4_SUID = 0x800;  /* set user id on execution */
const MODE4_SGID = 0x400;  /* set group id on execution */
const MODE4_SVTX = 0x200;  /* save text even after use */
const MODE4_RUSR = 0x100;  /* read permission: owner */
const MODE4_WUSR = 0x080;  /* write permission: owner */
const MODE4_XUSR = 0x040;  /* execute permission: owner */
const MODE4_RGRP = 0x020;  /* read permission: group */
const MODE4_WGRP = 0x010;  /* write permission: group */
const MODE4_XGRP = 0x008;  /* execute permission: group */
const MODE4_ROTH = 0x004;  /* read permission: other */
const MODE4_WOTH = 0x002;  /* write permission: other */
const MODE4_XOTH = 0x001;  /* execute permission: other */
EOF
	;;

	const_access_deny.x )

cat << EOF > $i
const OPEN4_SHARE_ACCESS_READ	= 0x00000001;
const OPEN4_SHARE_ACCESS_WRITE	= 0x00000002;
const OPEN4_SHARE_ACCESS_BOTH	= 0x00000003;

const OPEN4_SHARE_DENY_NONE	= 0x00000000;
const OPEN4_SHARE_DENY_READ	= 0x00000001;
const OPEN4_SHARE_DENY_WRITE	= 0x00000002;
const OPEN4_SHARE_DENY_BOTH	= 0x00000003;
EOF
	;;

	type_nfs_cb_opnum4.x )

cat << EOF > $i
%
enum nfs_cb_opnum4 {
	OP_CB_GETATTR		= 3,
	OP_CB_RECALL		= 4,
	OP_CB_ILLEGAL		= 10044
};
EOF
        ;;

	type_nfs_cb_argop4.x )

cat << EOF > $i
union nfs_cb_argop4 switch (unsigned argop) {
 case OP_CB_GETATTR:
      CB_GETATTR4args           opcbgetattr;
 case OP_CB_RECALL:
      CB_RECALL4args            opcbrecall;
 case OP_CB_ILLEGAL:            void;
};
EOF
        ;;

	type_CB_COMPOUND4args.x )

cat << EOF > $i
struct CB_COMPOUND4args {
	comptag4	tag;
	uint32_t	minorversion;
	uint32_t	callback_ident;
	nfs_cb_argop4	argarray<>;
};
EOF
        ;;

	type_nfs_cb_resop4.x )

cat << EOF > $i
union nfs_cb_resop4 switch (unsigned resop) {
 case OP_CB_GETATTR:	CB_GETATTR4res	opcbgetattr;
 case OP_CB_RECALL:	CB_RECALL4res	opcbrecall;
 case OP_CB_ILLEGAL:	CB_ILLEGAL4res	opcbillegal;
};
EOF
        ;;

	type_CB_COMPOUND4res.x )

cat << EOF > $i
struct CB_COMPOUND4res {
    	nfsstat4 	status;
	comptag4	tag;
	nfs_cb_resop4	resarray<>;
};
EOF
        ;;

	type_nfs_opnum4.x )

cat << EOF > $i
enum nfs_opnum4 {
 OP_ACCESS		= 3,
 OP_CLOSE		= 4,
 OP_COMMIT		= 5,
 OP_CREATE		= 6,
 OP_DELEGPURGE		= 7,
 OP_DELEGRETURN		= 8,
 OP_GETATTR		= 9,
 OP_GETFH		= 10,
 OP_LINK		= 11,
 OP_LOCK		= 12,
 OP_LOCKT		= 13,
 OP_LOCKU		= 14,
 OP_LOOKUP		= 15,
 OP_LOOKUPP		= 16,
 OP_NVERIFY		= 17,
 OP_OPEN		= 18,
 OP_OPENATTR		= 19,
 OP_OPEN_CONFIRM	= 20,
 OP_OPEN_DOWNGRADE	= 21,
 OP_PUTFH		= 22,
 OP_PUTPUBFH		= 23,
 OP_PUTROOTFH		= 24,
 OP_READ		= 25,
 OP_READDIR		= 26,
 OP_READLINK		= 27,
 OP_REMOVE		= 28,
 OP_RENAME		= 29,
 OP_RENEW		= 30,
 OP_RESTOREFH		= 31,
 OP_SAVEFH		= 32,
 OP_SECINFO		= 33,
 OP_SETATTR		= 34,
 OP_SETCLIENTID		= 35,
 OP_SETCLIENTID_CONFIRM	= 36,
 OP_VERIFY		= 37,
 OP_WRITE		= 38,
 OP_RELEASE_LOCKOWNER	= 39,
 OP_ILLEGAL		= 10044
};
EOF
        ;;

	type_nfs_argop4.x )

cat << EOF > $i
union nfs_argop4 switch (nfs_opnum4 argop) {
 case OP_ACCESS:	ACCESS4args opaccess;
 case OP_CLOSE:		CLOSE4args opclose;
 case OP_COMMIT:	COMMIT4args opcommit;
 case OP_CREATE:	CREATE4args opcreate;
 case OP_DELEGPURGE:	DELEGPURGE4args opdelegpurge;
 case OP_DELEGRETURN:	DELEGRETURN4args opdelegreturn;
 case OP_GETATTR:	GETATTR4args opgetattr;
 case OP_GETFH:		void;
 case OP_LINK:		LINK4args oplink;
 case OP_LOCK:		LOCK4args oplock;
 case OP_LOCKT:		LOCKT4args oplockt;
 case OP_LOCKU:		LOCKU4args oplocku;
 case OP_LOOKUP:	LOOKUP4args oplookup;
 case OP_LOOKUPP:	void;
 case OP_NVERIFY:	NVERIFY4args opnverify;
 case OP_OPEN:		OPEN4args opopen;
 case OP_OPENATTR:	OPENATTR4args opopenattr;
 case OP_OPEN_CONFIRM:	OPEN_CONFIRM4args opopen_confirm;
 case OP_OPEN_DOWNGRADE:
			OPEN_DOWNGRADE4args opopen_downgrade;
 case OP_PUTFH:		PUTFH4args opputfh;
 case OP_PUTPUBFH:	void;
 case OP_PUTROOTFH:	void;
 case OP_READ:		READ4args opread;
 case OP_READDIR:	READDIR4args opreaddir;
 case OP_READLINK:	void;
 case OP_REMOVE:	REMOVE4args opremove;
 case OP_RENAME:	RENAME4args oprename;
 case OP_RENEW:		RENEW4args oprenew;
 case OP_RESTOREFH:	void;
 case OP_SAVEFH:	void;
 case OP_SECINFO:	SECINFO4args opsecinfo;
 case OP_SETATTR:	SETATTR4args opsetattr;
 case OP_SETCLIENTID: SETCLIENTID4args opsetclientid;
 case OP_SETCLIENTID_CONFIRM: SETCLIENTID_CONFIRM4args
				opsetclientid_confirm;
 case OP_VERIFY:	VERIFY4args opverify;
 case OP_WRITE:		WRITE4args opwrite;
 case OP_RELEASE_LOCKOWNER:
			RELEASE_LOCKOWNER4args
			oprelease_lockowner;
 case OP_ILLEGAL:	void;
};
EOF
        ;;

	type_nfs_resop4.x )

cat << EOF > $i
union nfs_resop4 switch (nfs_opnum4 resop) {
 case OP_ACCESS:	ACCESS4res opaccess;
 case OP_CLOSE:		CLOSE4res opclose;
 case OP_COMMIT:	COMMIT4res opcommit;
 case OP_CREATE:	CREATE4res opcreate;
 case OP_DELEGPURGE:	DELEGPURGE4res opdelegpurge;
 case OP_DELEGRETURN:	DELEGRETURN4res opdelegreturn;
 case OP_GETATTR:	GETATTR4res opgetattr;
 case OP_GETFH:		GETFH4res opgetfh;
 case OP_LINK:		LINK4res oplink;
 case OP_LOCK:		LOCK4res oplock;
 case OP_LOCKT:		LOCKT4res oplockt;
 case OP_LOCKU:		LOCKU4res oplocku;
 case OP_LOOKUP:	LOOKUP4res oplookup;
 case OP_LOOKUPP:	LOOKUPP4res oplookupp;
 case OP_NVERIFY:	NVERIFY4res opnverify;
 case OP_OPEN:		OPEN4res opopen;
 case OP_OPENATTR:	OPENATTR4res opopenattr;
 case OP_OPEN_CONFIRM:	OPEN_CONFIRM4res opopen_confirm;
 case OP_OPEN_DOWNGRADE:
			OPEN_DOWNGRADE4res
				opopen_downgrade;
 case OP_PUTFH:		PUTFH4res opputfh;
 case OP_PUTPUBFH:	PUTPUBFH4res opputpubfh;
 case OP_PUTROOTFH:	PUTROOTFH4res opputrootfh;
 case OP_READ:		READ4res opread;
 case OP_READDIR:	READDIR4res opreaddir;
 case OP_READLINK:	READLINK4res opreadlink;
 case OP_REMOVE:	REMOVE4res opremove;
 case OP_RENAME:	RENAME4res oprename;
 case OP_RENEW:		RENEW4res oprenew;
 case OP_RESTOREFH:	RESTOREFH4res oprestorefh;
 case OP_SAVEFH:	SAVEFH4res opsavefh;
 case OP_SECINFO:	SECINFO4res opsecinfo;
 case OP_SETATTR:	SETATTR4res opsetattr;
 case OP_SETCLIENTID: SETCLIENTID4res opsetclientid;
 case OP_SETCLIENTID_CONFIRM:
			SETCLIENTID_CONFIRM4res
				opsetclientid_confirm;
 case OP_VERIFY:	VERIFY4res opverify;
 case OP_WRITE:		WRITE4res opwrite;
 case OP_RELEASE_LOCKOWNER:
			RELEASE_LOCKOWNER4res
				oprelease_lockowner;
 case OP_ILLEGAL:	ILLEGAL4res opillegal;
};
EOF
        ;;

	type_COMPOUND4args.x )

cat << EOF > $i
struct COMPOUND4args {
	comptag4	tag;
	uint32_t	minorversion;
	nfs_argop4	argarray<>;
};
EOF
	;;

	type_COMPOUND4res.x )

cat << EOF > $i
struct COMPOUND4res {
	nfsstat4	status;
	comptag4 	tag;
	nfs_resop4	resarray<>;
};
EOF
	;;

	* )
		echo $0: Error: $i not recognized target.

		exit 1
	;;

	esac

done

rm -f $tmp

exit 0
