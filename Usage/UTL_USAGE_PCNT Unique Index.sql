-- Create/Recreate indexes 
CREATE unique index U_IDX_UTL_USG_PCNT on UTL_USAGE_PERCENTAGE (utl_id, commodity, month_year);
