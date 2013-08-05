/*
 *  Copyright (C) The IETF Trust (2009-2011)
 *  All Rights Reserved.
 *
 *  Copyright (C) The Internet Society (1998-2011).
 *  All Rights Reserved.
 */

/*
 *	nfs4_prot.x
 *
 */

/*
 * Basic typedefs for RFC 1832 data type definitions
 */
/*
 * typedef int		int32_t;
 * typedef unsigned int	uint32_t;
 * typedef hyper		int64_t;
 * typedef unsigned hyper	uint64_t;
 */

/*
 * Sizes
 */
include(const_sizes.x)

/*
 * File types
 */
enum nfs_ftype4 {
	NF4REG = 1,	/* Regular File */
	NF4DIR = 2,	/* Directory */
	NF4BLK = 3,	/* Special File - block device */
	NF4CHR = 4,	/* Special File - character device */
	NF4LNK = 5,	/* Symbolic Link */
	NF4SOCK = 6,	/* Special File - socket */
	NF4FIFO = 7,	/* Special File - fifo */
	NF4ATTRDIR
                = 8,	/* Attribute Directory */
	NF4NAMEDATTR
                = 9	/* Named Attribute */
};

/*
 * Error status
 */
enum nfsstat4 {
 NFS4_OK		= 0,    /* everything is okay      */
 NFS4ERR_PERM		= 1,    /* caller not privileged   */
 NFS4ERR_NOENT		= 2,    /* no such file/directory  */
 NFS4ERR_IO		= 5,    /* hard I/O error          */
 NFS4ERR_NXIO		= 6,    /* no such device          */
 NFS4ERR_ACCESS		= 13,   /* access denied           */
 NFS4ERR_EXIST		= 17,   /* file already exists     */
 NFS4ERR_XDEV		= 18,   /* different filesystems   */
 /* Unused/reserved        19 */
 NFS4ERR_NOTDIR		= 20,   /* should be a directory   */
 NFS4ERR_ISDIR		= 21,   /* should not be directory */
 NFS4ERR_INVAL		= 22,   /* invalid argument        */
 NFS4ERR_FBIG		= 27,   /* file exceeds server max */
 NFS4ERR_NOSPC		= 28,   /* no space on filesystem  */
 NFS4ERR_ROFS		= 30,   /* read-only filesystem    */
 NFS4ERR_MLINK		= 31,   /* too many hard links     */
 NFS4ERR_NAMETOOLONG	= 63,   /* name exceeds server max */
 NFS4ERR_NOTEMPTY	= 66,   /* directory not empty     */
 NFS4ERR_DQUOT		= 69,   /* hard quota limit reached*/
 NFS4ERR_STALE		= 70,   /* file no longer exists   */
 NFS4ERR_BADHANDLE	= 10001,/* Illegal filehandle      */
 NFS4ERR_BAD_COOKIE	= 10003,/* READDIR cookie is stale */
 NFS4ERR_NOTSUPP	= 10004,/* operation not supported */
 NFS4ERR_TOOSMALL	= 10005,/* response limit exceeded */
 NFS4ERR_SERVERFAULT	= 10006,/* undefined server error  */
 NFS4ERR_BADTYPE	= 10007,/* type invalid for CREATE */
 NFS4ERR_DELAY		= 10008,/* file "busy" - retry     */
 NFS4ERR_SAME		= 10009,/* nverify says attrs same */
 NFS4ERR_DENIED		= 10010,/* lock unavailable	   */
 NFS4ERR_EXPIRED	= 10011,/* lock lease expired	   */
 NFS4ERR_LOCKED		= 10012,/* I/O failed due to lock  */
 NFS4ERR_GRACE		= 10013,/* in grace period	   */
 NFS4ERR_FHEXPIRED	= 10014,/* filehandle expired	   */
 NFS4ERR_SHARE_DENIED	= 10015,/* share reserve denied	   */
 NFS4ERR_WRONGSEC	= 10016,/* wrong security flavor   */
 NFS4ERR_CLID_INUSE	= 10017,/* clientid in use	   */
 NFS4ERR_RESOURCE	= 10018,/* resource exhaustion	   */
 NFS4ERR_MOVED		= 10019,/* filesystem relocated	   */
 NFS4ERR_NOFILEHANDLE	= 10020,/* current FH is not set   */
 NFS4ERR_MINOR_VERS_MISMATCH = 10021,/* minor vers not supp */
 NFS4ERR_STALE_CLIENTID	= 10022,/* server has rebooted     */
 NFS4ERR_STALE_STATEID	= 10023,/* server has rebooted     */
 NFS4ERR_OLD_STATEID	= 10024,/* state is out of sync    */
 NFS4ERR_BAD_STATEID	= 10025,/* incorrect stateid       */
 NFS4ERR_BAD_SEQID	= 10026,/* request is out of seq.  */
 NFS4ERR_NOT_SAME	= 10027,/* verify - attrs not same */
 NFS4ERR_LOCK_RANGE	= 10028,/* lock range not supported*/
 NFS4ERR_SYMLINK	= 10029,/* should be file/directory*/
 NFS4ERR_RESTOREFH	= 10030,/* no saved filehandle     */
 NFS4ERR_LEASE_MOVED	= 10031,/* some filesystem moved   */
 NFS4ERR_ATTRNOTSUPP	= 10032,/* recommended attr not sup*/
 NFS4ERR_NO_GRACE	= 10033,/* reclaim outside of grace*/
 NFS4ERR_RECLAIM_BAD	= 10034,/* reclaim error at server */
 NFS4ERR_RECLAIM_CONFLICT = 10035,/* conflict on reclaim    */
 NFS4ERR_BADXDR		= 10036,/* XDR decode failed       */
 NFS4ERR_LOCKS_HELD	= 10037,/* file locks held at CLOSE*/
 NFS4ERR_OPENMODE	= 10038,/* conflict in OPEN and I/O*/
 NFS4ERR_BADOWNER	= 10039,/* owner translation bad   */
 NFS4ERR_BADCHAR	= 10040,/* utf-8 char not supported*/
 NFS4ERR_BADNAME	= 10041,/* name not supported      */
 NFS4ERR_BAD_RANGE	= 10042,/* lock range not supported*/
 NFS4ERR_LOCK_NOTSUPP	= 10043,/* no atomic up/downgrade  */
 NFS4ERR_OP_ILLEGAL	= 10044,/* undefined operation     */
 NFS4ERR_DEADLOCK	= 10045,/* file locking deadlock   */
 NFS4ERR_FILE_OPEN	= 10046,/* open file blocks op.    */
 NFS4ERR_ADMIN_REVOKED	= 10047,/* lockowner state revoked */
 NFS4ERR_CB_PATH_DOWN   = 10048 /* callback path down      */
};

/*
 * Basic data types
 */
include(basic_types.x)

/*
 * Timeval
 */
include(type_nfstime4.x)
include(type_time_how4.x)
include(type_settime4.x)


/*
 * File attribute definitions
 */

/*
 * FSID structure for major/minor
 */
include(type_fsid4.x)

/*
 * Filesystem locations attribute for relocation/migration
 */
include(type_fs_location4.x)
include(type_fs_locations4.x)

/*
 * Various Access Control Entry definitions
 */

/*
 * Mask that indicates which Access Control Entries
 * are supported. Values for the fattr4_aclsupport attribute.
 */
include(const_aclsupport4.x)

include(type_acetype4.x)

/*
 * acetype4 values, others can be added as needed.
 */
include(const_acetype4.x)


/*
 * ACE flag
 */
include(type_aceflag4.x)

/*
 * ACE flag values
 */
include(const_aceflag4.x)


/*
 * ACE mask
 */
include(type_acemask4.x)

/*
 * ACE mask values
 */
include(const_acemask4.x)

/*
 * ACE4_GENERIC_READ -- defined as combination of
 *	ACE4_READ_ACL |
 *	ACE4_READ_DATA |
 *	ACE4_READ_ATTRIBUTES |
 *	ACE4_SYNCHRONIZE
 */

const ACE4_GENERIC_READ	= 0x00120081;

/*
 * ACE4_GENERIC_WRITE -- defined as combination of
 *	ACE4_READ_ACL |
 *	ACE4_WRITE_DATA |
 *	ACE4_WRITE_ATTRIBUTES |
 *	ACE4_WRITE_ACL |
 *	ACE4_APPEND_DATA |
 *	ACE4_SYNCHRONIZE
 */
const ACE4_GENERIC_WRITE = 0x00160106;


/*
 * ACE4_GENERIC_EXECUTE -- defined as combination of
 *	ACE4_READ_ACL
 *	ACE4_READ_ATTRIBUTES
 *	ACE4_EXECUTE
 *	ACE4_SYNCHRONIZE
 */
const ACE4_GENERIC_EXECUTE = 0x001200A0;


/*
 * Access Control Entry definition
 */
include(type_nfsace4.x)

/*
 * Field definitions for the fattr4_mode attribute
 */
include(const_mode4.x)

/*
 * Special data/attribute associated with
 * file types NF4BLK and NF4CHR.
 */
include(type_specdata4.x)

/*
 * Values for fattr4_fh_expire_type
 */
const	FH4_PERSISTENT		= 0x00000000;
const	FH4_NOEXPIRE_WITH_OPEN	= 0x00000001;
const	FH4_VOLATILE_ANY	= 0x00000002;
const	FH4_VOL_MIGRATION	= 0x00000004;
const	FH4_VOL_RENAME		= 0x00000008;


typedef bitmap4			fattr4_supported_attrs;
typedef nfs_ftype4		fattr4_type;
typedef	uint32_t		fattr4_fh_expire_type;
typedef	changeid4		fattr4_change;
typedef uint64_t		fattr4_size;
typedef	bool			fattr4_link_support;
typedef	bool			fattr4_symlink_support;
typedef bool			fattr4_named_attr;
typedef fsid4			fattr4_fsid;
typedef	bool			fattr4_unique_handles;
typedef uint32_t		fattr4_lease_time;
typedef	nfsstat4		fattr4_rdattr_error;

typedef nfsace4			fattr4_acl<>;
typedef uint32_t		fattr4_aclsupport;
typedef	bool			fattr4_archive;
typedef	bool			fattr4_cansettime;
typedef	bool			fattr4_case_insensitive;
typedef	bool			fattr4_case_preserving;
typedef	bool			fattr4_chown_restricted;
typedef uint64_t		fattr4_fileid;
typedef uint64_t		fattr4_files_avail;
typedef nfs_fh4			fattr4_filehandle;
typedef uint64_t		fattr4_files_free;
typedef uint64_t		fattr4_files_total;
typedef fs_locations4		fattr4_fs_locations;
typedef bool			fattr4_hidden;
typedef bool			fattr4_homogeneous;
typedef uint64_t		fattr4_maxfilesize;
typedef uint32_t		fattr4_maxlink;
typedef uint32_t		fattr4_maxname;
typedef uint64_t		fattr4_maxread;
typedef uint64_t		fattr4_maxwrite;
typedef	ascii_REQUIRED4		fattr4_mimetype;
typedef mode4			fattr4_mode;
typedef uint64_t		fattr4_mounted_on_fileid;
typedef	bool			fattr4_no_trunc;
typedef	uint32_t		fattr4_numlinks;
typedef	utf8val_REQUIRED4	fattr4_owner;
typedef	utf8val_REQUIRED4	fattr4_owner_group;
typedef uint64_t		fattr4_quota_avail_hard;
typedef uint64_t		fattr4_quota_avail_soft;
typedef uint64_t		fattr4_quota_used;
typedef specdata4		fattr4_rawdev;
typedef uint64_t		fattr4_space_avail;
typedef uint64_t		fattr4_space_free;
typedef uint64_t		fattr4_space_total;
typedef uint64_t		fattr4_space_used;
typedef bool			fattr4_system;
typedef nfstime4		fattr4_time_access;
typedef settime4		fattr4_time_access_set;
typedef nfstime4		fattr4_time_backup;
typedef nfstime4		fattr4_time_create;
typedef nfstime4		fattr4_time_delta;
typedef nfstime4		fattr4_time_metadata;
typedef nfstime4		fattr4_time_modify;
typedef settime4		fattr4_time_modify_set;


/*
 * Mandatory Attributes
 */
const FATTR4_SUPPORTED_ATTRS	= 0;
const FATTR4_TYPE		= 1;
const FATTR4_FH_EXPIRE_TYPE	= 2;
const FATTR4_CHANGE		= 3;
const FATTR4_SIZE		= 4;
const FATTR4_LINK_SUPPORT	= 5;
const FATTR4_SYMLINK_SUPPORT	= 6;
const FATTR4_NAMED_ATTR		= 7;
const FATTR4_FSID		= 8;
const FATTR4_UNIQUE_HANDLES	= 9;
const FATTR4_LEASE_TIME		= 10;
const FATTR4_RDATTR_ERROR	= 11;
const FATTR4_FILEHANDLE		= 19;

/*
 * Recommended Attributes
 */
const FATTR4_ACL		= 12;
const FATTR4_ACLSUPPORT		= 13;
const FATTR4_ARCHIVE		= 14;
const FATTR4_CANSETTIME		= 15;
const FATTR4_CASE_INSENSITIVE	= 16;
const FATTR4_CASE_PRESERVING	= 17;
const FATTR4_CHOWN_RESTRICTED	= 18;
const FATTR4_FILEID		= 20;
const FATTR4_FILES_AVAIL	= 21;
const FATTR4_FILES_FREE		= 22;
const FATTR4_FILES_TOTAL	= 23;
const FATTR4_FS_LOCATIONS	= 24;
const FATTR4_HIDDEN		= 25;
const FATTR4_HOMOGENEOUS	= 26;
const FATTR4_MAXFILESIZE	= 27;
const FATTR4_MAXLINK		= 28;
const FATTR4_MAXNAME		= 29;
const FATTR4_MAXREAD		= 30;
const FATTR4_MAXWRITE		= 31;
const FATTR4_MIMETYPE		= 32;
const FATTR4_MODE		= 33;
const FATTR4_NO_TRUNC		= 34;
const FATTR4_NUMLINKS		= 35;
const FATTR4_OWNER		= 36;
const FATTR4_OWNER_GROUP	= 37;
const FATTR4_QUOTA_AVAIL_HARD	= 38;
const FATTR4_QUOTA_AVAIL_SOFT	= 39;
const FATTR4_QUOTA_USED		= 40;
const FATTR4_RAWDEV		= 41;
const FATTR4_SPACE_AVAIL	= 42;
const FATTR4_SPACE_FREE		= 43;
const FATTR4_SPACE_TOTAL	= 44;
const FATTR4_SPACE_USED		= 45;
const FATTR4_SYSTEM		= 46;
const FATTR4_TIME_ACCESS	= 47;
const FATTR4_TIME_ACCESS_SET	= 48;
const FATTR4_TIME_BACKUP	= 49;
const FATTR4_TIME_CREATE	= 50;
const FATTR4_TIME_DELTA		= 51;
const FATTR4_TIME_METADATA	= 52;
const FATTR4_TIME_MODIFY	= 53;
const FATTR4_TIME_MODIFY_SET	= 54;
const FATTR4_MOUNTED_ON_FILEID	= 55;

/*
 * File attribute container
 */
include(type_fattr4.x)

/*
 * Change info for the client
 */
include(type_change_info4.x)

include(type_clientaddr4.x)

/*
 * Callback program info as provided by the client
 */
include(type_cb_client4.x)

/*
 * Stateid
 */
struct stateid4 {
	uint32_t	seqid;
	opaque		other[NFS4_OTHER_SIZE];
};

/*
 * Client ID
 */
include(type_nfs_client_id4.x)

include(type_open_owner4.x)

include(type_lock_owner4.x)

include(type_nfs_lock_type4.x)
