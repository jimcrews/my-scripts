#!/usr/bin/env python3
"""
Author : jimc <jimc@localhost>
Date   : 2020-10-22
Purpose: Return uppercase text from argument or file
"""

import argparse
import os

# --------------------------------------------------


def get_args():
    """Get command-line arguments"""

    parser = argparse.ArgumentParser(
        description='Return uppercase text from argument or file',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('text',
                        metavar='str',
                        help='File Location or Text')

    parser.add_argument('-o',
                        '--outfile',
                        help='Output File location',
                        metavar='str',
                        type=str,
                        default='')

    return parser.parse_args()


# --------------------------------------------------
def main():
    """Make a jazz noise here"""

    args = get_args()
    pos_arg = args.text
    file_str = args.outfile
    scream_text = ''

    if os.path.isfile(pos_arg):
        text = open(pos_arg).read().rstrip()
        scream_text = text.upper()
    else:
        scream_text = pos_arg.upper()

    if file_str:
        out_fh = open(file_str, 'wt')  # use 'wt' to write a text file
        out_fh.write(scream_text + '\n')
        out_fh.close()
    else:
        print(scream_text + '\n')


# --------------------------------------------------
if __name__ == '__main__':
    main()
