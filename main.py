"""PyTV
Usage: 
  main.py 

Arguments:
    TEXT  Message to be printed

Options:
    --count=N  number of times the message will be output
    --caps  convert the text to upper case
"""

# Docopt is a library for parsing command line arguments
import docopt
import sys
import os
from Tkinter import *
import cec

class pyTV(object):
    def __init__(self):
        cec.init()
        self.tv = cec.Device(0)
        self.start_tv()
#        os.environ['DISPLAY'] = "0.0"
        self.tk = Tk()
        self.tk.attributes("-fullscreen", True)
        self.frame = Frame(self.tk)
        self.frame.pack()
        

    def start_tv(self):
        if self.tv.is_on() is False:
            self.tv.power_on()
        os.system("""echo "as" | cec-client -s""")

if __name__ == '__main__':
    app = pyTV()
    app.tk.mainloop()
