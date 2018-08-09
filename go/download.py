import os
with open("a.txt") as f:
  for i in f:
    os.system("adb pull %s %s" % (i.strip(), "../png/"))
