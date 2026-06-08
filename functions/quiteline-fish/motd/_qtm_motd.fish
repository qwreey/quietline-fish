function _qtm_motd; argparse --max-args 0 \
	'charactor=*' \
	'line1=*' \
	'line2=*' \
	'line3=*' \
-- $argv
	# Define default
	set -q _flag_charactor || set -l _flag_charactor "cat" "rabbit"
	set _flag_charactor $_flag_charactor[(random 1 (count $_flag_charactor))]

	# Create lines
	set -l line1 (string join '' $_flag_line1)
	set -l line2 (string join '' $_flag_line2)
	set -l line3 (string join '' $_flag_line3)
	_qtm_motdascii_$_flag_charactor "$line1" "$line2" "$line3"
end
