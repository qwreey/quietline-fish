# From https://github.com/IlanCosman/tide/blob/main/functions/_tide_parent_dirs.fish
function _qtm_parent_dirs
	set -l parts ''
	echo '/'
	string escape -- (
		for dir in (string split -- / "$argv[1]")
			test -z "$dir"
			and continue
			set -a parts "$dir"
			string join -- / $parts
		end
	)
end
