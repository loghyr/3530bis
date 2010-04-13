struct open_read_delegation4 {
 stateid4 stateid;    /* Stateid for delegation*/
 bool	  recall;     /* Pre-recalled flag for
                         delegations obtained
                         by reclaim (CLAIM_PREVIOUS) */

 nfsace4 permissions; /* Defines users who don't
			 need an ACCESS call to
			 open for read */
};

struct open_write_delegation4 {
 stateid4 stateid;	/* Stateid for delegation */
 bool	  recall;	/* Pre-recalled flag for
			   delegations obtained
			   by reclaim
			   (CLAIM_PREVIOUS) */

 nfs_space_limit4
           space_limit;	/* Defines condition that
			   the client must check to
			   determine whether the
			   file needs to be flushed
			   to the server on close.  */

 nfsace4   permissions;	/* Defines users who don't
			   need an ACCESS call as
			   part of a delegated
			   open. */
};

union open_delegation4
switch (open_delegation_type4 delegation_type) {
	case OPEN_DELEGATE_NONE:
		void;
	case OPEN_DELEGATE_READ:
		open_read_delegation4 read;
	case OPEN_DELEGATE_WRITE:
		open_write_delegation4 write;
};

/*
 * Result flags
 */

/* Client must confirm open */
const OPEN4_RESULT_CONFIRM	= 0x00000002;
/* Type of file locking behavior at the server */
const OPEN4_RESULT_LOCKTYPE_POSIX = 0x00000004;

struct OPEN4resok {
 stateid4	stateid;      /* Stateid for open */
 change_info4	cinfo;        /* Directory Change Info */
 uint32_t	rflags;       /* Result flags */
 bitmap4	attrset;      /* attribute set for create*/
 open_delegation4 delegation; /* Info on any open
				 delegation */
};

union OPEN4res switch (nfsstat4 status) {
 case NFS4_OK:
	/* CURRENT_FH: opened file */
	OPEN4resok	resok4;
 default:
	void;
};

