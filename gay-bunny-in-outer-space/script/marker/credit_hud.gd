extends CanvasLayer

class_name CreditHud

func convert_to_human_readable(credits : int) -> String:
	var suffixes : Array = ["", "k", "M", "B", "T", "P"] # Add more if needed
	var index : int = 0
	var value : float = float(credits)

	if credits < 1000:
		return str(credits)

	# Reduce the value and find the appropriate suffix
	while value >= 1000 and index < suffixes.size() - 1:
		value /= 1000
		index += 1

	# Format the result to one decimal place if necessary
	if value >= 10:
		return str(round(value)) + suffixes[index]
	else:
		return "%.1f%s" % [value, suffixes[index]]
