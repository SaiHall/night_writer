# Night Writer/ Night Reader

> Night Writer is designed to translate English text into Braille. It's sister program Night Reader, also included here, does the inverse.

Night Writer reads a text file it was given, accesses the dictionary, and re-writes the text file into simulated Braille characters in a file name that was provided when the program is run.
Night reader reads a text file of simulated Braille, accesses the same dictionary, and re-writes the contents as English in the provided file name.

In order to run the program, provide a file in either English or Braille (file_to_translate), and a file name you would like to access the results in (file_to_create).
From the root of the project, please run:
``ruby ./lib/night_writer.rb file_to_translate.txt file_to_create.txt``
