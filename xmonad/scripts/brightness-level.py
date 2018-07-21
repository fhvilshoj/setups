base_path = '/sys/class/backlight/intel_backlight/'

max_file = open(base_path + 'max_brightness')
brightness_file = open(base_path + 'brightness')

max = int(max_file.readline())
b = int(brightness_file.readline())

val = int((b * 100) / max)

print("{}%".format(val))
