<cfscript>
	// Given a roleid, get relevant role based permissions
	// If roleid == 0, which is the default, then no role has been assigned
	struct function getRolePermissions(numeric roleid=0){
		local.permissions={};
		if(roleid != 0){
			local.permissionQ=model("rolepermission").findAll(where="roleid=#roleid#", include="permission");
			for(permission in local.permissionQ){
				permission["setby"]="Role";
				local.permissions[permission.name]=permission;
			}
		}
		return local.permissions;
	}
	// Given a userid/email, get user permissions
	struct function getUserPermissions(numeric userid=0){
		local.permissions={};
		if(userid != 0){
			local.permissionQ=model("userpermission").findAll(where="userid=#userid#", include="permission");
			for(permission in local.permissionQ){
				permission["setby"]="User";
				local.permissions[permission.name]=permission;
			}
		}
		return local.permissions;
	}
	// Start with Role Permissions and Override with User Permissions
	struct function mergePermissions(required struct rolePermissions, required struct userPermissions){
		local.permissions={};
		if(structIsEmpty(userPermissions)){
			local.permissions=rolePermissions;
		} else {
			for(permission in userPermissions){
				rolePermissions[permission]=userPermissions[permission];
			}
			local.permissions=rolePermissions;
		}
		return local.permissions;
	}
</cfscript>
