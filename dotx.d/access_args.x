
const ACCESS4_READ	= 0x00000001;
const ACCESS4_LOOKUP	= 0x00000002;
const ACCESS4_MODIFY	= 0x00000004;
const ACCESS4_EXTEND	= 0x00000008;
const ACCESS4_DELETE	= 0x00000010;
const ACCESS4_EXECUTE	= 0x00000020;

struct ACCESS4args {
	/* CURRENT_FH: object */
	uint32_t	access;
};

