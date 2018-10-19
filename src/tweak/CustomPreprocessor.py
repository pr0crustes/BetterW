#
# Copyright - pr0crustes @ 2018
#
# This script is a simple preprocessor made by me, pr0crustes.
# All Rights Reserved.
#
# Version 2
# Original at https://github.com/pr0crustes/CustomPreprocessor
#


PP_KEY = "$"
PP_USE = PP_KEY + "use "
PP_DEF = PP_KEY + "def "
PP_IDENTIFIER_LIMIT = ": "
PP_LEFT_LIMIT = "("
PP_RIGHT_LIMIT = ")"
PP_SEPARATOR = ","
PP_VAR_USE = "!"
PP_CONTINUE_LINE = "\\"

PP_NEW_LINE = "\n"

PP_FILE_EXT = ".prep"


# Returns the string between two substrings.
def str_between(string, left, right):
    return string.split(left, 1)[1].split(right, 1)[0]


class Macro(object):

    def __init__(self, identifier, arglist, replacement):
        self.identifier = identifier
        self.arglist = arglist
        self.replacement = replacement

    @classmethod
    def __get_args(cls, line):
        line = str_between(line, PP_LEFT_LIMIT, PP_RIGHT_LIMIT)
        line = line.replace(PP_SEPARATOR + " ", PP_SEPARATOR)
        return line.split(PP_SEPARATOR)

    @classmethod
    def from_definition(cls, definition):
        defined, replacement = definition.replace(PP_DEF, "").split(PP_IDENTIFIER_LIMIT, 1)

        identifier = defined.partition(PP_LEFT_LIMIT)[0]
        arglist = cls.__get_args(defined)

        return cls(identifier, arglist, replacement.lstrip())

    def preprocessed_line(self, line):
        used_args = Macro.__get_args(line)

        assert len(used_args) == len(self.arglist), "Error: Invalid Usage of Macro in line ->  " + line

        replaced = self.replacement
        for i in range(len(self.arglist)):
            replaced = replaced.replace(PP_VAR_USE + self.arglist[i], used_args[i])

        return replaced

    def is_line_usage(self, line):
        expected_usage = PP_USE + self.identifier + PP_LEFT_LIMIT
        return line.strip().startswith(expected_usage)

    # Another definition with the same identifier should replace the previous.
    def __eq__(self, other):
        return self.identifier == other.identifier


class PreProcessor(object):

    def __init__(self):
        self.macros = []

    def __replaced_if_needed(self, line):
        for macro in self.macros:
            if macro.is_line_usage(line):
                replaced = macro.preprocessed_line(line)
                # Check for nested pp.
                return PP_NEW_LINE.join([self.__replaced_if_needed(seg) for seg in replaced.split(PP_NEW_LINE)])
        return line

    def __parse_definition(self, line):
        macro = Macro.from_definition(line)
        assert macro not in self.macros, "Trying to redefine existing macro at line: " + line
        self.macros.append(macro)
        return ""  # The line should not be added

    def parse_line(self, line):
        if line.startswith(PP_DEF):  # is prep instruction
            return self.__parse_definition(line)
        else:  # Line is not empty
            return self.__replaced_if_needed(line) + PP_NEW_LINE


class Processor(object):

    def __init__(self, in_file_name):
        self.in_file_name = in_file_name

    # Parses the lines of a file, merging lines that should be continuous.
    def __preparsed_input_file(self):
        orig_lines = [line.replace(PP_NEW_LINE, "") for line in open(self.in_file_name, "r")]

        parsed = []

        current_line = ""

        for line in orig_lines:

            current_line += line

            if line.endswith(PP_CONTINUE_LINE):
                current_line = current_line[:-1] + PP_NEW_LINE  # Remove the \
            else:   # Reset
                parsed.append(current_line)
                current_line = ""

        return parsed

    def preprocess_file(self, out_file_name):
        assert self.in_file_name != out_file_name, "Output file cannot be equal to the input file."

        pre_processor = PreProcessor()

        with open(out_file_name, "w") as outFile:

            for line in self.__preparsed_input_file():

                outFile.write(pre_processor.parse_line(line))


if __name__ == "__main__":

    def user_file():

        import argparse

        parser = argparse.ArgumentParser()
        parser.add_argument("file", type=str, help="The input " + PP_FILE_EXT + " file.")
        parser.add_argument("-o", type=str, help="[Optional] Destiny file. If not provided, it will be the input file without the " + PP_FILE_EXT + " extension.")
        args = parser.parse_args()
        return args.file, args.o

    # FILE, OUT = "example/Test.prep", None  # For testing
    FILE, OUT = user_file()

    OUT = OUT if OUT else FILE.replace(PP_FILE_EXT, "")

    assert FILE.endswith(PP_FILE_EXT), "Input file should end with  " + PP_FILE_EXT

    Processor(FILE).preprocess_file(OUT)

    print("==> CustomPreprocessor preprocessed the file. Output at '" + OUT + "'.")
