#!/usr/bin/env python3
"""tests for gashlycrumb.py"""

import os
import re
import random
import string
from subprocess import getstatusoutput

prg = './gashlycrumb.py'


# --------------------------------------------------
def file_flag():
    """Either -f or --file"""

    return '-f' if random.randint(0, 1) else '--file'


# --------------------------------------------------
def test_exists():
    """exists"""

    assert os.path.isfile(prg)


# --------------------------------------------------
def test_usage():
    """usage"""

    for flag in ['-h', '--help']:
        rv, out = getstatusoutput(f'{prg} {flag}')
        assert rv == 0
        assert re.match("usage", out, re.IGNORECASE)


# --------------------------------------------------
def test_a():
    """Test for 'a'"""

    rv, out = getstatusoutput(f'{prg} a')
    assert rv == 0
    expected = 'A is for Amy who fell down the stairs.'
    assert out.strip() == expected


# --------------------------------------------------
def test_b_c():
    """Test for 'b c'"""

    rv, out = getstatusoutput(f'{prg} b c')
    assert rv == 0
    expected = ('B is for Basil assaulted by bears.\n'
                'C is for Clara who wasted away.')
    assert out.strip() == expected


# --------------------------------------------------
def test_y():
    """Test for 'y'"""

    rv, out = getstatusoutput(f'{prg} Y')
    assert rv == 0
    expected = 'Y is for Yorick whose head was bashed in.'
    assert out.strip() == expected


# --------------------------------------------------
def random_string():
    """generate a random string"""

    k = random.randint(5, 10)
    return ''.join(random.choices(string.ascii_letters + string.digits, k=k))
