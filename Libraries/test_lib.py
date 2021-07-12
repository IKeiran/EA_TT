from re import search
import re

def check_substring(text, substring):
    words = substring.split()
    found = True
    for word in words:
        if not search(word, text, re.IGNORECASE):
            print("text not found")
            found = False
    return found

def increment_variable(p_num):
    return  int(p_num) + 1

