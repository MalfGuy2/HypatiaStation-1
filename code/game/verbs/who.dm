
/client/verb/who()
	set name = "Who"
	set category = "OOC"

	var/msg = "<b>Current Players:</b>\n"

	var/list/Lines = list()

	if(holder)
		for(var/client/C in clients)
			var/entry = "\t[C.key]"
			if(C.holder && C.holder.fakekey)
				entry += " <i>(as [C.holder.fakekey])</i>"
			entry += " - Playing as [C.mob.real_name]"
			switch(C.mob.stat)
				if(UNCONSCIOUS)
					entry += " - <font color='darkgray'><b>Unconscious</b></font>"
				if(DEAD)
					if(isobserver(C.mob))
						var/mob/dead/observer/O = C.mob
						if(O.started_as_observer)
							entry += " - <font color='gray'>Observing</font>"
						else
							entry += " - <font color='black'><b>DEAD</b></font>"
					else
						entry += " - <font color='black'><b>DEAD</b></font>"
			if(is_special_character(C.mob))
				entry += " - <b><font color='red'>Antagonist</font></b>"
			entry += " (<A HREF='?_src_=holder;adminmoreinfo=\ref[C.mob]'>?</A>)"
			Lines += entry
	else
		for(var/client/C in clients)
			if(C.holder && C.holder.fakekey)
				Lines += C.holder.fakekey
			else
				Lines += C.key

	for(var/line in sortList(Lines))
		msg += "[line]\n"

	msg += "<b>Total Players: [length(Lines)]</b>"
	src << msg

/client/verb/adminwho()
	set category = "Admin"
	set name = "Adminwho"


	var/num_mods_online = 0
	var/num_admins_online = 0
	var/num_custom_online = 0
	var/msg = ""  // admins
	var/msg2 = ""  // mods
	var/msg3 = ""  // donors/custom -- will be edited -- dalekfodder

	for(var/client/C in admins)
		if(R_ADMIN & C.holder.rights)
			msg += "\t[C] is a [C.holder.rank]"
			if(holder)
				if(C.holder.fakekey)
					msg += " <i>(as [C.holder.fakekey])</i>"

				if(isobserver(C.mob))
					msg += " - Observing"
				else if(istype(C.mob,/mob/new_player))
					msg += " - Lobby"
				else
					msg += " - Playing"

				if(C.is_afk())
					msg += " (AFK)"
			msg += "\n"

			num_admins_online++
		else if(R_MOD & C.holder.rights)
			msg2 += "\t[C] is a [C.holder.rank]"
			if(holder)
				if(C.holder.fakekey)
					msg2 += " <i>(as [C.holder.fakekey])</i>"

				if(isobserver(C.mob))
					msg2 += " - Observing"
				else if(istype(C.mob,/mob/new_player))
					msg2 += " - Lobby"
				else
					msg2 += " - Playing"

				if(C.is_afk())
					msg2 += " (AFK)"
			msg2 += "\n"

			num_mods_online++

		else
			msg3 += "\t[C] is a [C.holder.rank]"
			if(holder)
				if(C.holder.fakekey)
					msg3 += " <i>(as [C.holder.fakekey])</i>"

				if(isobserver(C.mob))
					msg3 += " - Observing"
				else if(istype(C.mob,/mob/new_player))
					msg3 += " - Lobby"
				else
					msg3 += " - Playing"

				if(C.is_afk())
					msg3 += " (AFK)"
			msg3 += "\n"

			num_custom_online++


/*
	else
		for(var/client/C in admins)
			if(R_ADMIN & C.holder.rights || !(R_MOD & C.holder.rights))
				if(!C.holder.fakekey)
					msg += "\t[C] is a [C.holder.rank]\n"
					num_admins_online++
			else
				num_mods_online++
*/

	msg = "<b>Current Admins online: ([num_admins_online]):</b>\n" + msg
	msg2= "<b>Current Moderators online: ([num_mods_online]):</b>\n" + msg2
	msg3= "<b>Current Custom Ranks online: ([num_custom_online]):</b>\n" + msg3

	// msg += "<b>There are also [num_mods_online] moderators online.</b> To view online moderators, type 'modwho'\n"
	src << msg +"<BR>"+ msg2 +"<BR>"+ msg3



/*
/client/verb/modwho()
	set category = "Admin"
	set name = "Modwho"

	var/msg = ""
	var/num_admins_online = 0
	var/num_mods_online = 0
	if(holder)
		for(var/client/C in admins)
			if(R_ADMIN & C.holder.rights || !(R_MOD & C.holder.rights))
				num_admins_online++
			else
				msg += "\t[C] is a [C.holder.rank]"

				if(isobserver(C.mob))
					msg += " - Observing"
				else if(istype(C.mob,/mob/new_player))
					msg += " - Lobby"
				else
					msg += " - Playing"

				if(C.is_afk())
					msg += " (AFK)"
				msg += "\n"
				num_mods_online++
	else
		for(var/client/C in admins)
			if(R_ADMIN & C.holder.rights || !(R_MOD & C.holder.rights))
				num_admins_online++
			else
				msg += "\t[C] is a [C.holder.rank]\n"

	msg = "<b>Current Moderators ([num_mods_online]):</b>\n" + msg
	msg += "<b>There are also [num_admins_online] admins online.</b> To view online admins, type 'adminwho'\n"
	src << msg
*/
