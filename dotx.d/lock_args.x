/*
 * For LOCK, transition from open_owner to new lock_owner
 */
include(type_open_to_lock_owner4.x)
/*
 * For LOCK, existing lock_owner continues to request file locks
 */
struct exist_lock_owner4 {
	stateid4	lock_stateid;
	seqid4		lock_seqid;
};

union locker4 switch (bool new_lock_owner) {
 case TRUE:
	open_to_lock_owner4	open_owner;
 case FALSE:
	exist_lock_owner4	lock_owner;
};

/*
 * LOCK/LOCKT/LOCKU: Record lock management
 */
struct LOCK4args {
	/* CURRENT_FH: file */
	nfs_lock_type4	locktype;
	bool		reclaim;
	offset4		offset;
	length4		length;
	locker4		locker;
};

