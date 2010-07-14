/*
 * Various definitions for OPEN
 */
enum createmode4 {
	UNCHECKED4	= 0,
	GUARDED4	= 1,
	EXCLUSIVE4	= 2
};

union createhow4 switch (createmode4 mode) {
 case UNCHECKED4:
 case GUARDED4:
	 fattr4		createattrs;
 case EXCLUSIVE4:
	 verifier4	createverf;
};

enum opentype4 {
	OPEN4_NOCREATE	= 0,
	OPEN4_CREATE	= 1
};

union openflag4 switch (opentype4 opentype) {
 case OPEN4_CREATE:
	 createhow4	how;
 default:
	 void;
};

/* Next definitions used for OPEN delegation */
enum limit_by4 {
	NFS_LIMIT_SIZE		= 1,
	NFS_LIMIT_BLOCKS	= 2
	/* others as needed */
};

struct nfs_modified_limit4 {
	uint32_t	num_blocks;
	uint32_t	bytes_per_block;
};

union nfs_space_limit4 switch (limit_by4 limitby) {
 /* limit specified as file size */
 case NFS_LIMIT_SIZE:
	 uint64_t		filesize;
 /* limit specified by number of blocks */
 case NFS_LIMIT_BLOCKS:
	 nfs_modified_limit4	mod_blocks;
} ;

enum open_delegation_type4 {
	OPEN_DELEGATE_NONE	= 0,
	OPEN_DELEGATE_READ	= 1,
	OPEN_DELEGATE_WRITE	= 2
};

enum open_claim_type4 {
	CLAIM_NULL		= 0,
	CLAIM_PREVIOUS		= 1,
	CLAIM_DELEGATE_CUR	= 2,
	CLAIM_DELEGATE_PREV	= 3
};

struct open_claim_delegate_cur4 {
	stateid4	delegate_stateid;
	component4	file;
};

union open_claim4 switch (open_claim_type4 claim) {
 /*
  * No special rights to file.
  * Ordinary OPEN of the specified file.
  */
 case CLAIM_NULL:
	/* CURRENT_FH: directory */
	component4	file;
 /*
  * Right to the file established by an
  * open previous to server reboot. File
  * identified by filehandle obtained at
  * that time rather than by name.
  */
 case CLAIM_PREVIOUS:
	/* CURRENT_FH: file being reclaimed */
	open_delegation_type4	delegate_type;

 /*
  * Right to file based on a delegation
  * granted by the server. File is
  * specified by name.
  */
 case CLAIM_DELEGATE_CUR:
	/* CURRENT_FH: directory */
	open_claim_delegate_cur4	delegate_cur_info;

 /*
  * Right to file based on a delegation
  * granted to a previous boot instance
  * of the client.  File is specified by name.
  */
 case CLAIM_DELEGATE_PREV:
	 /* CURRENT_FH: directory */
	component4	file_delegate_prev;
};

/*
 * OPEN: Open a file, potentially receiving an open delegation
 */
struct OPEN4args {
	seqid4		seqid;
	uint32_t	share_access;
	uint32_t	share_deny;
	open_owner4	owner;
	openflag4	openhow;
	open_claim4	claim;
};

