
local mine_type = 1
local mine_types_titles = {
	fgettext("Full Version"),
	fgettext("Lite Version"),
	fgettext("Creative Version"),
}

local mine_types_type = {
	"full",
	"lite",
	"creative",
}

local fullscreenshot = defaulttexturedir .. "fullscreenshot.png"

local function get_formspec(tabview, name, tabdata)

	common_update_cached_supp_proto()

	local retval =
		-- "dropdown[0.7,-0.1;2.4;type;",mine_types_titles,,";", mine_type, "]",
		-- Name / Password
		"label[0.67,0.64;" .. fgettext("Name / Password") .. "]" ..
		"field[0.8,1.5;2.25,0.5;te_name;;" ..
			core.formspec_escape(core.settings:get("name")) .. "]" ..
		"pwdfield[2.9,1.5;2.25,0.5;te_pwd;]" ..

		-- System required Description Background
		"label[0.65,1.85;" .. fgettext("System required:") .. "]" ..
		"box[0.5,2.25;4.25,2.6;#999999]"..
		"textarea[0.8,2.3;6,2.9;;;" .. fgettext("Device with 2Gb RAM or more.") .. "]" ..

		-- Connect
		"button[2.68,4.9;2.3,1;btn_mp_connect;" .. fgettext("Connect") .. "]" ..

		"image[5.5,0;3,2;" .. core.formspec_escape(fullscreenshot) .. "]" ..
		"label[8.25,0.6;" .. fgettext("mine") .. "]" ..

		-- Game Description
		"label[5.65,1.85;" .. fgettext("Information:") .. "]" ..
		"box[5.5,2.25;6,3;#999999]" .. 
		"textarea[5.8,2.3;6,3;;;" .. fgettext("Step by step, explore a new world.\nDiscover new crafting recipes.\nBuild cities together or survive alone.\nActivate the portal to hell and get new materials.\nFind the portal to Ender world on the highest peak...") .. "]"
		

	return retval
end

--------------------------------------------------------------------------------

local function main_button_handler(tabview, fields, name, tabdata)
	local serverlist = menudata.search_result or menudata.favorites

	if fields.te_name then
		gamedata.playername = fields.te_name
		core.settings:set("name", fields.te_name)
	end

	if (fields.btn_mp_connect or fields.key_enter)
			then	
		gamedata.playername = fields.te_name
		gamedata.password   = fields.te_pwd
		gamedata.address    = "mine.ksandr.online"
		gamedata.port       = "30007"
		gamedata.selected_world = 0
		gamedata.servername        = ""
		gamedata.serverdescription = ""
		core.settings:set("address",     "mine.ksandr.online")
		core.settings:set("remote_port", "30007")		
		core.start()
		return true
	end
	
	return false
end

local function on_change(type, old_tab, new_tab)
	if type == "LEAVE" then return end
	asyncOnlineFavourites()
end


return {
	name = "mine",
	caption = fgettext("mine"),
	cbf_formspec = get_formspec,
	cbf_button_handler = main_button_handler,
	on_change = on_change
}