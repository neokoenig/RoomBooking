<p>
	BelongsTo Building<br />
	HasMany Images?<br />
	hasOne booking Schema? <--- free/slot/day/range/limited?<br />
	HasMany Resources -> building level inherited, room specific too<br />
	TimeZone/Address is inherited<br />
</p>
<p>
	id<br />
	buildingid<br />
	title<br />
	category?<br />
	description<br />
	capacity<br />
	layouts<br />
	allowconcurrent <--- Allow overlaps?<br />
	bookableby <--- Minimum role required to book<br />
	approvableby <--- Minimum role required to approve<br />
	initialstatus <--- Bookings in this room initially created with approved/pending?<br />
	<br />
	hexcolour<br />
	icon<br />
	<br />
	createdat<br />
	updatedat<br />
	deletedat<br />
</p>
