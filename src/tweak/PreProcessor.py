import argparse

#
# Copyright  pr0crustes @ 2018
#
# This script is a simple preprocessor made by me, pr0crustes, on October 14th 2018.
# This should be run before logos, like a macro for logos.
#
# This file IS NOT included in the LICENSE, having all rights reserved, as follows:
# You are free to use this file, but only if all the following conditions are met:
# 	Only nonprofit usage;
#	The code is unchanged;
#	This notice must not be changed or removed.
#
# If you want to use this file in any other way, contact "pr0crustes".
#

class PreProcessor(object):

    def __init__(self):
        self.k_use = "///use "
        self.k_def = "///def "
        self.k_deli = " -> "
        self.k_left_deli = "("
        self.k_right_deli = ")"
        self.k_separator = ","
        self.k_var_use = "!"

        self.defined_pp = {}

    def __get_args(self, line):
        line = line.partition(self.k_left_deli)[-1]
        line = line.rpartition(self.k_right_deli)[0]
        line = line.replace(" ", "")
        return line.split(self.k_separator)

    def __parse_def(self, line):
        definition, substitute = line.replace(self.k_def, "").split(self.k_deli, 1)
        self.defined_pp[definition] = substitute

    def __replace_use(self, line, definition, substitute):
        def_args = self.__get_args(definition)
        parsed_args = self.__get_args(line)

        assert len(def_args) == len(parsed_args)

        for i in range(len(def_args)):
            substitute = substitute.replace(self.k_var_use + def_args[i], parsed_args[i])

        return substitute

    def __replace_use_if_needed(self, line):
        for definition, substitute in self.defined_pp.items():
            if line.strip().startswith(self.k_use + definition.split(self.k_left_deli)[0] + self.k_left_deli):
                replaced = self.__replace_use(line, definition, substitute)
                return self.__replace_use_if_needed(replaced)  # Check for nested pp.
        return line

    def preprocess_file(self, in_file_name, out_file_name):

        assert in_file_name != out_file_name

        with open(in_file_name, "r") as inFile, open(out_file_name, "w") as outFile:

            for line in inFile:

                if line.startswith(self.k_def):  # is prep instruction
                    self.__parse_def(line)
                else:
                    parsed = self.__replace_use_if_needed(line)
                    outFile.write(parsed)


if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("file", type=str, help="The input .xm.e file")
    args = parser.parse_args()
    FILE = args.file

    file_ext = ".e"

    assert FILE.endswith(file_ext)

    pp = PreProcessor()
    pp.preprocess_file(FILE, FILE.replace(file_ext, ""))
