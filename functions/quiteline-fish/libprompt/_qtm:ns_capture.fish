function _qtm:ns_capture \
--description "define namespace enter code. capture _flag_* as defualt" \
--no-scope-shadowing;
	# Parse argument
	set -l execute "" ; set -l var_setter ""; begin
		argparse --max-args 0 \
			'v/var=+' \
			'e/execute=?' \
		-- $argv || return
		for vardefine in $_flag_var
			set -l split (string split -m1 -- '=' "$vardefine")

			test (count $split) = 1
			and set -l value "$$split[1]"
			or  set -l value "$split[2]"

			set var_setter "$var_setter""set -f $split[1] $(string escape -- "$value");"
		end
		set execute "$_flag_execute"
	end
	# Create new id
	set --query _qtm_var_lastnsid
	or set --global _qtm_var_lastnsid "0"
	set --global _qtm_var_lastnsid (math $_qtm_var_lastnsid + 1)
	set -f id $_qtm_var_lastnsid
	set var_setter "$var_setter""set -f id $id;"

	# Create func
	begin
		# Capture _flag
		set -l flag_names (
			set --names --local |
			string match -r -- '^_flag_.*'
		)
		set -l flag_setter ""
		for flag in $flag_names
			set flag_setter "$flag_setter""set -f $flag $(string escape -- "$$flag");"
		end

		eval "function _qtm:nsenter_$id --no-scope-shadowing;$flag_setter$var_setter$execute;end"
	end

	# Return created ns func
	echo "_qtm:nsenter_$id"
end
