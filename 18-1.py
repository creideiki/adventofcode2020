#!/usr/bin/env python

from enum import Enum, auto
from collections import deque
import sys

class t(Enum):
    INT = auto()
    ADD = auto()
    MUL = auto()
    OPEN = auto()
    CLOSE = auto()

class Token:
    def __init__(self, repr):
        if repr == '+':
            self.type = t.ADD
        elif repr == '*':
            self.type = t.MUL
        elif repr == '(':
            self.type = t.OPEN
        elif repr == ')':
            self.type = t.CLOSE
        else:
            self.type = t.INT
            self.value = int(repr)

    def __str__(self):
        return f"<{self.__class__.__name__}: type={self.type} value={getattr(self, 'value', None)}>"

def tokenize(str):
    return [Token(s) for s in str.replace('(', ' ( ').replace(')', ' ) ').split()]

class Parser:
    def __init__(self, tokens):
        self.tokens = deque(tokens)

    def next_token(self):
        if len(self.tokens) == 0:
            self.current = None
        else:
            self.current = self.tokens.popleft()

    def expect(self, type):
        return self.current.type == type

    def parse(self):
        self.tokens.reverse()
        self.next_token()
        return self.parse_expr()

    def parse_expr(self):
        if not self.current:
            return 0

        if self.expect(t.INT):
            val = self.current.value
            self.next_token()
        elif self.expect(t.CLOSE):
            self.next_token()
            val = self.parse_expr()
            self.expect(t.OPEN)
            self.next_token()
        else:
            print("Parse error")
            sys.exit()

        if not self.current or self.expect(t.OPEN):
            pass
        elif self.expect(t.ADD):
            self.next_token()
            val += self.parse_expr()
        elif self.expect(t.MUL):
            self.next_token()
            val *= self.parse_expr()
        else:
            print("Parse error")
            sys.exit()

        return val

problems = [line.strip() for line in open('18.input').readlines()]

s = 0

for problem in problems:
    val = Parser(tokenize(problem)).parse()
    print(f"{problem} = {val}")
    s += val

print(s)
