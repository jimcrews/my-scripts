#!/usr/bin/env python3
"""
Author : jimc <jimc@localhost>
Date   : 2020-10-23
Purpose: Rock the Casbah
"""

import argparse


# --------------------------------------------------
def get_args():
    """Get command-line arguments"""

    parser = argparse.ArgumentParser(
        description='Look up txt file by letter',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('letters',
                        metavar='letter',
                        nargs='+',  # allows 1 or more. creates array
                        help='letter(s) to lookup')

    return parser.parse_args()

# --------------------------------------------------


def create_dic():
    d = {}
    with open('./gashlycrumb.txt') as f:
        for line in f:
            # A = A is for Amy who fell down the stairs.
            d[line[0]] = line.rstrip()

    return d

# --------------------------------------------------


def main():
    """Make a jazz noise here"""

    dic = create_dic()

    args = get_args()

    letters = args.letters

    for letter in letters:
        for x, y in dic.items():
            if letter.upper() == x.upper():
                print(y)


# --------------------------------------------------
if __name__ == '__main__':
    main()
