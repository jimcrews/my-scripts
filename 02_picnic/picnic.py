#!/usr/bin/env python3
"""
Author : jim
Date   : 2020-10-19
Purpose: Picnic Game

 - Write a program that accepts multiple positional arguments
 - When there is only one item, you’ll print: You are bringing salad.
 - When there are two items, you’ll print “and” between them. You are bringing salad and chips.
 - When there are three or more items, you’ll separate the items with commas: You are bringing salad, chips, and cupcakes.
 - The program will also need to accept a --sorted argument that will require you to sort the items before you print them

"""

import argparse


# --------------------------------------------------
def get_args():
    """Get command-line arguments"""

    parser = argparse.ArgumentParser(
        description='Picnic Game',
        formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('items',
                        metavar='str',
                        nargs='+',  # all command-line args present are gathered into a list
                        help='Items to bring')

    parser.add_argument('-s',
                        '--sorted',
                        action='store_true',
                        help='Sort the items')

    return parser.parse_args()


# --------------------------------------------------
def main():
    """Make a jazz noise here"""

    args = get_args()
    items = None
    isSorted = args.sorted

    if isSorted:
        items = sorted(args.items)
    else:
        items = args.items

    sentence = ''

    if (len(items)) == 1:
        sentence = 'You are bringing {}.'.format(items[0])

    if (len(items)) == 2:
        sentence = 'You are bringing {} and {}.'.format(items[0], items[1])

    if (len(items)) > 2:
        build = []
        myItems = ''
        for idx, i in enumerate(items):
            if idx < len(items)-1:
                build.append(i + ', ')
            if idx == len(items)-1:
                build.append('and ' + i)

        for i in build:
            myItems = myItems + i

        sentence = 'You are bringing {}.'.format(myItems)

    print(sentence)


# --------------------------------------------------
if __name__ == '__main__':
    main()
