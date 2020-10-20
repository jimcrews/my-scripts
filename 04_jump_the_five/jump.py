#!/usr/bin/env python3
"""
Author : Anonymous <Anonymous@localhost>
Date   : 2020-10-20
Purpose: Jump the Five
"""

import argparse


# --------------------------------------------------
def get_args():
    """Get command-line arguments"""

    parser = argparse.ArgumentParser(
        description='Jump the Five',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('text',
                        metavar='str',
                        help='Input text')

    return parser.parse_args()


# --------------------------------------------------
def main():
    """Make a jazz noise here"""

    args = get_args()

    message = args.text
    jumper = {'1': '9', '2': '8', '3': '7', '4': '6', '5': '0',
              '6': '4', '7': '3', '8': '2', '9': '1', '0': '5'}
    new_message = ''

    for i in message:
        if jumper.get(i):
            new_message = new_message + jumper.get(i)
        else:
            new_message = new_message + i

    print(new_message)


# --------------------------------------------------
if __name__ == '__main__':
    main()
