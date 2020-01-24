"""
update_version
This script generate versoin.h file.
That file define programm version string, based on
mercurial svn.
"""

import subprocess
import os
import datetime
import argparse

HEADER = "#ifndef VERSION_H \
\n#define VERSION_H \
\n\n// Version explained: <branch>.<in-branch \
sequential revision number>(<revision hash>).(<datetime as ddmmYHM>) \
\n#define CURRENT_VERSION"

FOOTER = "\n\n#endif //VERSION_H"
FILENAME = "version.h"
SCRIPT_PATH = os.path.dirname(os.path.realpath(__file__))


def write_file(version, verbose=False):
    "write_file"

    final_string = HEADER + " \"" + version + "\" " + FOOTER
    full_path = SCRIPT_PATH + "/" + FILENAME

    if verbose:
        print("Full path: " + full_path)

    try:
        file = open(full_path, 'w')
        file.write(final_string)
    except IOError:
        print("Error write file " + FILENAME)

    if verbose:
        print(FILENAME + " write succesfull")

    file.close()


def get_date_time(verbose=False):
    "get_date_time"
    today = datetime.datetime.today()
    if verbose:
        print("Now: " + today.strftime("%d-%m-%Y_%H:%M"))

    return today.strftime("%d-%m-%Y_%H:%M")


def get_branch(verbose=False):
    "get_branch"
    try:
        branch_full = subprocess.check_output(['hg', 'branch']).decode("utf-8")
    except subprocess.CalledProcessError:
        print("Error get branch")
        return "ErrorBranch"

    try:
        branch = branch_full.split()[0]
    except ValueError:
        return "ErrorBranch"

    if verbose:
        print("Branch " + branch)
    return branch


def get_revision(verbose=False):
    "get_revision"
    command = ['hg', 'log', '-r', '.', '--template', '{rev}']

    try:
        output = subprocess.check_output(command).decode("utf-8")
    except subprocess.CalledProcessError:
        print("Error get revision")
        return "ErrorRevision"

    if verbose:
        print("Revision: " + output)
    return output


def get_hash_value(verbose=False):
    "get_hash_value"
    try:
        hash_string = subprocess.check_output(
            ['hg', 'log', '-r', '.', '--template', '{node|short}']
            ).decode("utf-8")
    except subprocess.CalledProcessError:
        print("Error get hash")
        return "ErrorHash"

    try:
        hash_value = hash_string.split()[0]
        hash_value = hash_string.split('+')[0]
    except ValueError:
        print("Error split hash string (" + hash_string + ")")
        return "ErrorHash"

    if verbose:
        print("Hash: " + hash_value)
    return hash_value


def create_parser():
    "create_parser"
    parser = argparse.ArgumentParser()
    parser.add_argument('v', help='Enable verbose', nargs='?')

    return parser


def main():
    "main"
    parser = create_parser()
    namespace = parser.parse_args()

    verbose = False
    if namespace.v:
        verbose = True

    date_time = get_date_time(verbose)
    branch = get_branch(verbose)
    revision = get_revision(verbose)
    hash_value = get_hash_value(verbose)

    version = branch+"."+revision+"("+hash_value+").("+date_time+")"

    if verbose:
        print("Version " + version)

    write_file(version, verbose)
    exit()


if __name__ == "__main__":
    main()
