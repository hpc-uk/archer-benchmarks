import os.path
import sys
from glob import glob

def get_filelist(wdir, stem):
    """
    Get list of date files in the specified directory
    """

    files = []
    if os.path.exists(wdir):
        files = glob(os.path.join(wdir, stem + '*' ))
        files.sort()
    else:
        print(wdir)
        sys.stderr.write("Directory does not exist: {0}".format(wdir))
        sys.exit(1)

    return files

def get_filelist_ext(wdir, extension):
    """
    Get list of date files in the specified directory
    """

    files = []
    if os.path.exists(wdir):
        files = glob(wdir + '/*.' + extension)
        files.sort()
    else:
        sys.stderr.write("Directory does not exist: {0}".format(wdir))
        sys.exit(1)

    return files

def get_filelist_pattern(wdir, pattern):
    """
    Get list of date files in the specified directory
    """

    files = []
    if os.path.exists(wdir):
        files = glob(wdir + '/' + pattern)
        files.sort()
    else:
        sys.stderr.write("Directory does not exist: {0}".format(wdir))
        sys.exit(1)

    return files
