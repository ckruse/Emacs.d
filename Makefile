
create-init:
	cat init.start.tpl.el > init.el
	cat `ls init/*.el` >> init.el
	cat tweeks.el >> init.el
	cat keybinding.el >> init.el
	cat init.end.tpl.el >> init.el
